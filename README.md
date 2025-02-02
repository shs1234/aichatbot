# 📝 채팅 애플리케이션 (Flutter + Firebase + Django)

이 프로젝트는 Flutter, Firebase, Django, OpenAI를 이용하여  
**실시간 메시지 송수신 및 AI 챗봇 응답**이 가능한 채팅 애플리케이션입니다.  
사용자는 **회원가입 및 로그인**을 거쳐 채팅방에 입장할 수 있으며, **AI 챗봇과 대화**할 수 있습니다.

## 🛠️ 기술 스택

### 프론트엔드
- **Flutter**  
    - 크로스 플랫폼 모바일 애플리케이션 개발 프레임워크

### 백엔드
- **Firebase Authentication**  
    - 회원가입 및 로그인 기능 제공
- **Firebase Firestore**  
    - 유저 디테일 및 채팅 로그 저장을 위한 NoSQL 데이터베이스
- **Django RESTful API**  
    - OpenAI API와 연동되는 서버 구축


---

## 📂 파일별 설명

### 📱 Flutter (클라이언트)

#### 로그인 화면
| 파일명                 | 설명 |
|----------------------|------------------------------|
| `main.dart`         | Firebase 초기화 후, 로그인 상태에 따라 화면을 전환 |
| `main_screen.dart`  | 로그인 및 회원가입 화면 구현 |

#### 채팅 화면
| 파일명                 | 설명 |
|----------------------|------------------------------|
| `chat_screen.dart`  | 메시지 목록과 새 메시지 입력 필드 포함 (채팅방) |
| `ChatBubble.dart`   | 개별 메시지를 표시하는 위젯 |
| `Messages.dart`     | Firestore에서 메시지를 실시간으로 가져와 표시 |
| `NewMessage.dart`   | 새 메시지를 작성하고 서버로 전송 (AI 챗봇 응답 처리) |

#### 프로필 화면
| 파일명                 | 설명 |
|----------------------|------------------------------|
| `my_profile.dart`   | 사용자 프로필 조회 및 닉네임 수정 가능 |

### 🖥️ Django (서버)

#### API 뷰
| 파일명                 | 설명 |
|----------------------|------------------------------|
| `views.py`          | AI 챗봇 응답을 처리하는 API 뷰 |
| `urls.py`           | API 엔드포인트 정의 |

---

## ⚙️ 설치 및 실행

### Flutter 클라이언트

1. **프로젝트 클론**
   ```bash
   git clone https://github.com/shs1234/aichatbot.git
   cd practice
   ```

2. **패키지 설치**
   ```bash
   flutter pub get
   ```

3. **Firebase 설정**
   - Firebase 콘솔 설정에서 `serviceAccountKey.json` 파일 다운

4. **앱 실행**
   ```bash
   flutter run
   ```

### Django 서버

1. **프로젝트 클론**
   ```sh
   git clone https://github.com/shs1234/aichatbot.git
   cd chatbotapi
   ```

2. **가상 환경 생성 및 활성화**
   ```sh
   python -m venv venv
   source venv/bin/activate  # macOS/Linux
   ```

3. **필요한 패키지 설치**
   ```sh
   pip install -r requirements.txt
   ```

4. **환경 변수 설정**
   - 프로젝트 루트에 `.env` 파일을 생성하고 OpenAI API 키를 추가:
     ```
     OPENAI_API_KEY=your_openai_api_key
     ```

5. **Django 서버 실행**
   ```sh
   python manage.py runserver
   ```


---
## 📸 예시 화면

**문맥을 파악하여 두번째 질문의 대답으로 한국의 인구수를 대답합니다.**

<img src="./untitled.gif" width="300" alt="예시화면">
