# Firebase 설정 가이드

이 앱은 Firebase Authentication과 Cloud Firestore를 사용하여 사용자 데이터를 동기화합니다.

## 1. Firebase 프로젝트 생성

1. [Firebase Console](https://console.firebase.google.com/) 접속
2. "프로젝트 추가" 클릭
3. 프로젝트 이름 입력 (예: `english-learning-app`)
4. Google Analytics 설정 (선택사항)
5. 프로젝트 생성 완료

## 2. iOS 앱 설정

### 2.1 Firebase Console에서 iOS 앱 추가

1. Firebase 프로젝트 개요 페이지에서 "iOS 앱 추가" 클릭
2. 번들 ID 입력: `com.example.englishappFlutter`
3. 앱 닉네임 (선택사항): `영어 학습 앱`
4. `GoogleService-Info.plist` 파일 다운로드

### 2.2 GoogleService-Info.plist 추가

1. 다운로드한 `GoogleService-Info.plist` 파일을 `ios/Runner/` 폴더에 복사
2. Xcode에서 프로젝트 열기:
   ```bash
   open ios/Runner.xcworkspace
   ```
3. Xcode에서:
   - 왼쪽 프로젝트 네비게이터에서 `Runner` 폴더 우클릭
   - "Add Files to Runner" 선택
   - `GoogleService-Info.plist` 파일 선택
   - "Copy items if needed" 체크
   - "Add" 클릭

## 3. Android 앱 설정

### 3.1 Firebase Console에서 Android 앱 추가

1. Firebase 프로젝트 개요 페이지에서 "Android 앱 추가" 클릭
2. 패키지 이름 입력: `com.example.englishapp_flutter`
3. `google-services.json` 파일 다운로드

### 3.2 google-services.json 추가

1. 다운로드한 `google-services.json` 파일을 `android/app/` 폴더에 복사

### 3.3 build.gradle 수정

**android/build.gradle** 파일 수정:

```gradle
buildscript {
    dependencies {
        // Firebase
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

**android/app/build.gradle** 파일 맨 아래에 추가:

```gradle
apply plugin: 'com.google.gms.google-services'
```

## 4. Web 앱 설정 (선택사항)

### 4.1 Firebase Console에서 Web 앱 추가

1. Firebase 프로젝트 개요 페이지에서 "Web 앱 추가" 클릭
2. 앱 닉네임 입력
3. Firebase SDK 설정 코드 복사

### 4.2 Web 설정 코드 업데이트

`lib/core/services/firebase_service.dart` 파일에서 Web 설정 값 업데이트:

```dart
if (kIsWeb) {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "여기에_API_KEY",
      authDomain: "여기에_프로젝트_ID.firebaseapp.com",
      projectId: "여기에_프로젝트_ID",
      storageBucket: "여기에_프로젝트_ID.appspot.com",
      messagingSenderId: "여기에_SENDER_ID",
      appId: "여기에_APP_ID",
    ),
  );
}
```

## 5. Firebase Authentication 활성화

1. Firebase Console에서 "Authentication" 메뉴 클릭
2. "시작하기" 클릭
3. "로그인 방법" 탭 선택
4. "이메일/비밀번호" 활성화
5. (선택사항) "익명" 로그인도 활성화 가능

## 6. Cloud Firestore 설정

1. Firebase Console에서 "Firestore Database" 메뉴 클릭
2. "데이터베이스 만들기" 클릭
3. **테스트 모드로 시작** 선택 (개발용)
   - 프로덕션 배포 시 보안 규칙 수정 필요
4. 위치 선택: `asia-northeast3 (Seoul)` 권장
5. "사용 설정" 클릭

### 6.1 Firestore 보안 규칙 (프로덕션용)

나중에 다음 규칙으로 변경:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // 사용자는 자신의 데이터만 읽기/쓰기 가능
    match /users/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## 7. 앱 실행

모든 설정이 완료되면:

```bash
flutter clean
flutter pub get
flutter run
```

## 주요 기능

### Authentication
- 이메일/비밀번호 로그인
- 회원가입
- 비밀번호 재설정
- 익명 로그인
- 자동 로그인

### Firestore 데이터 동기화
- 단어장 데이터 실시간 동기화
- 문법 데이터 실시간 동기화
- 사용자별 학습 데이터 관리
- 오프라인 지원 (로컬 SQLite + Firestore 동기화)

## 데이터 구조

### Firestore Collection 구조
```
users/
  {userId}/
    vocabulary/
      items/
        {vocabId}: VocabularyItem
    grammar/
      items/
        {grammarId}: GrammarItem
```

## 문제 해결

### iOS 빌드 오류
- `GoogleService-Info.plist`가 제대로 추가되었는지 확인
- Xcode에서 "Copy items if needed" 옵션이 체크되었는지 확인
- `pod install` 재실행

### Android 빌드 오류
- `google-services.json`이 `android/app/` 폴더에 있는지 확인
- `build.gradle` 파일 수정사항 확인

### Firebase 초기화 오류
- `GoogleService-Info.plist` / `google-services.json` 파일 경로 확인
- Firebase 프로젝트 설정이 올바른지 확인
