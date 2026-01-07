<div align="center">
<img width="1200" height="475" alt="GHBanner" src="https://github.com/user-attachments/assets/0aa67016-6eaf-458a-adb2-6e31a0763ed6" />
</div>

# English Boost - 영어 학습 앱 랜딩 페이지

English Boost는 과학적으로 검증된 학습 방법과 AI 기술을 결합한 혁신적인 영어 학습 플랫폼입니다.

## 주요 기능

- 🧠 **맞춤형 학습**: AI가 당신의 실력을 분석하여 최적의 학습 경로 제공
- 📚 **과학적 암기법**: 간격 반복 학습(Spaced Repetition)으로 장기 기억 강화
- ⚡ **실시간 퀴즈**: 게임처럼 재미있는 학습 경험
- 📈 **성장 시각화**: 학습 데이터를 한눈에 확인
- 🏆 **레벨별 학습**: 초급부터 고급까지 체계적인 커리큘럼
- ✨ **AI 발음 코칭**: 정확한 발음 학습 지원

## 기술 스택

- React 19
- TypeScript
- Vite
- Tailwind CSS
- Lucide React Icons
- Google Gemini AI

## 로컬 실행 방법

**필수 요구사항:** Node.js

1. 의존성 설치:
   ```bash
   npm install
   ```

2. `.env.local` 파일에 Gemini API 키 설정:
   ```
   VITE_GEMINI_API_KEY=your_api_key_here
   ```

3. 개발 서버 실행:
   ```bash
   npm run dev
   ```

4. 브라우저에서 `http://localhost:3000` 접속

## 빌드

프로덕션 빌드:
```bash
npm run build
```

빌드 미리보기:
```bash
npm run preview
```

## 프로젝트 구조

```
├── components/          # React 컴포넌트
│   ├── Hero.tsx        # 히어로 섹션
│   ├── Features.tsx    # 기능 소개
│   ├── AppShowcase.tsx # 앱 미리보기
│   ├── Stats.tsx       # 통계 및 혜택
│   ├── Testimonials.tsx # 사용자 후기
│   ├── Waitlist.tsx    # 대기자 명단
│   └── Footer.tsx      # 푸터
├── services/           # API 서비스
└── App.tsx            # 메인 앱 컴포넌트
```

## 라이선스

MIT

## 문의

프로젝트에 대한 문의사항이 있으시면 이슈를 등록해주세요.
