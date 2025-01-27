from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from firebase_admin import firestore
from openai import OpenAI
from dotenv import load_dotenv
import os

load_dotenv()

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

class ChatAPI(APIView):
    def post(self, request):
        try:
            # 사용자 입력 받기
            user_uid = request.data.get("uid")

            # if not user_message or not user_uid:
            if not user_uid:
                return Response({"error": "Invalid input"}, status=400)

            db = firestore.client()
            messages_ref = db.collection("chat").document(user_uid).collection("messages")
            query = messages_ref.order_by("time").stream()

            # Firestore 데이터를 OpenAI 메시지 포맷으로 변환
            messages = [{"role": "system", "content": "You are a helpful assistant."}]
            for doc in query:
                data = doc.to_dict()
                role = "user" if data["uid"] == user_uid else "assistant"
                messages.append({"role": role, "content": data["text"]})

            # OpenAI API 호출
            response = client.chat.completions.create(
                model="gpt-4",
                messages=messages,
            )
            ai_response = response.choices[0].message.content
            return Response({"response": ai_response})
        except Exception as e:
            print(e)
            return Response({"error": str(e)}, status=500)
