from django.apps import AppConfig
import firebase_admin
from firebase_admin import credentials
from dotenv import load_dotenv
import os

load_dotenv()

class ChatConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'chat'

    def ready(self):
        cred = credentials.Certificate(os.getenv("SERVICE_ACCOUNT_KEY_FILENAME"))
        firebase_admin.initialize_app(cred)

