import React from 'react';
import { Star, Quote } from 'lucide-react';

const testimonials = [
  {
    name: '김민지',
    role: '대학생',
    image: '👩‍🎓',
    content: 'English Boost 덕분에 토익 점수를 6개월 만에 200점이나 올렸어요! 매일 30분씩만 투자했는데 이렇게 효과가 있을 줄 몰랐어요.',
    rating: 5,
  },
  {
    name: '박준혁',
    role: '직장인',
    image: '👨‍💼',
    content: '출퇴근 시간에 틈틈이 공부하니까 정말 편해요. 특히 AI가 추천해주는 맞춤 학습이 너무 좋아요. 시간 낭비 없이 효율적으로 공부할 수 있어요.',
    rating: 5,
  },
  {
    name: '이수진',
    role: '취업준비생',
    image: '👩‍💻',
    content: '문법이 항상 약점이었는데, English Boost의 쉬운 설명 덕분에 이제는 자신감이 생겼어요. 면접 준비할 때 정말 많은 도움이 됐습니다!',
    rating: 5,
  },
  {
    name: '최영훈',
    role: '고등학생',
    image: '👨‍🎓',
    content: '게임하듯이 퀴즈 풀면서 공부하니까 전혀 지루하지 않아요. 내신 성적도 많이 올랐고, 친구들한테도 추천했어요!',
    rating: 5,
  },
  {
    name: '정하은',
    role: '프리랜서',
    image: '👩‍🎨',
    content: '해외 클라이언트와 소통할 때 자신감이 생겼어요. 발음 연습 기능이 특히 유용했고, 실생활에 바로 쓸 수 있는 표현들이 많아서 좋아요.',
    rating: 5,
  },
  {
    name: '강동현',
    role: '스타트업 대표',
    image: '👨‍💼',
    content: '바쁜 일정 속에서도 영어 공부를 놓치지 않을 수 있어요. 짧은 시간에 핵심만 공부할 수 있어서 완벽해요. 직원들에게도 추천했습니다!',
    rating: 5,
  },
];

export const Testimonials: React.FC = () => {
  return (
    <section className="py-24 bg-gradient-to-b from-slate-900 to-slate-800 relative overflow-hidden">
      {/* Decorative elements */}
      <div className="absolute top-20 left-10 w-72 h-72 bg-brand-500/10 rounded-full blur-3xl"></div>
      <div className="absolute bottom-20 right-10 w-96 h-96 bg-purple-500/10 rounded-full blur-3xl"></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="text-center max-w-3xl mx-auto mb-16">
          <h2 className="text-brand-400 font-bold tracking-wide uppercase text-sm mb-3">사용자 후기</h2>
          <p className="text-4xl sm:text-5xl font-extrabold text-white mb-4 leading-tight">
            이미 <span className="bg-gradient-to-r from-brand-400 to-purple-400 bg-clip-text text-transparent">10,000명 이상</span>이<br/>
            English Boost와 함께하고 있어요
          </p>
          <p className="text-slate-400 text-lg leading-relaxed">
            실제 사용자들의 생생한 경험을 들어보세요
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {testimonials.map((testimonial, index) => (
            <div
              key={index}
              className="group relative bg-slate-800/50 backdrop-blur-sm border border-slate-700/50 rounded-3xl p-8 hover:bg-slate-800 hover:border-brand-500/50 transition-all duration-300 hover:-translate-y-2 hover:shadow-2xl hover:shadow-brand-500/10"
            >
              {/* Quote icon */}
              <div className="absolute top-6 right-6 text-brand-500/20 group-hover:text-brand-500/30 transition-colors">
                <Quote className="w-8 h-8" />
              </div>

              {/* Stars */}
              <div className="flex gap-1 mb-4">
                {[...Array(testimonial.rating)].map((_, i) => (
                  <Star key={i} className="w-5 h-5 fill-yellow-400 text-yellow-400" />
                ))}
              </div>

              {/* Content */}
              <p className="text-slate-300 leading-relaxed mb-6 relative z-10">
                "{testimonial.content}"
              </p>

              {/* Author */}
              <div className="flex items-center gap-4">
                <div className="w-12 h-12 rounded-full bg-gradient-to-br from-brand-500 to-purple-500 flex items-center justify-center text-2xl shadow-lg">
                  {testimonial.image}
                </div>
                <div>
                  <div className="font-bold text-white">{testimonial.name}</div>
                  <div className="text-sm text-slate-400">{testimonial.role}</div>
                </div>
              </div>

              {/* Gradient overlay on hover */}
              <div className="absolute inset-0 bg-gradient-to-br from-brand-500/5 to-purple-500/5 rounded-3xl opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none"></div>
            </div>
          ))}
        </div>

        {/* Stats */}
        <div className="mt-20 grid grid-cols-2 md:grid-cols-4 gap-8">
          <div className="text-center">
            <div className="text-4xl md:text-5xl font-extrabold text-white mb-2">10,000+</div>
            <div className="text-slate-400 font-medium">활성 사용자</div>
          </div>
          <div className="text-center">
            <div className="text-4xl md:text-5xl font-extrabold text-white mb-2">50만+</div>
            <div className="text-slate-400 font-medium">학습한 단어</div>
          </div>
          <div className="text-center">
            <div className="text-4xl md:text-5xl font-extrabold text-white mb-2">98%</div>
            <div className="text-slate-400 font-medium">만족도</div>
          </div>
          <div className="text-center">
            <div className="text-4xl md:text-5xl font-extrabold text-white mb-2">4.9/5</div>
            <div className="text-slate-400 font-medium">평균 평점</div>
          </div>
        </div>
      </div>
    </section>
  );
};
