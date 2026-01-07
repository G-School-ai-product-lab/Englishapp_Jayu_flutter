import React from 'react';
import { TrendingUp, Clock, Target, Award } from 'lucide-react';

const benefits = [
  {
    icon: Clock,
    title: '매일 30분',
    description: '하루 30분만 투자하세요',
    detail: '짧은 시간으로 최대의 효과를 경험할 수 있습니다.',
    color: 'from-blue-500 to-cyan-500',
  },
  {
    icon: TrendingUp,
    title: '3개월 후',
    description: '눈에 띄는 실력 향상',
    detail: '평균 200% 이상의 학습 성과를 달성합니다.',
    color: 'from-green-500 to-emerald-500',
  },
  {
    icon: Target,
    title: '맞춤형 목표',
    description: '당신만의 학습 계획',
    detail: 'AI가 분석한 취약점을 집중적으로 보완합니다.',
    color: 'from-orange-500 to-red-500',
  },
  {
    icon: Award,
    title: '검증된 효과',
    description: '과학적 학습 방법론',
    detail: '간격 반복 학습으로 장기 기억에 저장됩니다.',
    color: 'from-purple-500 to-pink-500',
  },
];

export const Stats: React.FC = () => {
  return (
    <section className="py-24 bg-white relative overflow-hidden">
      {/* Background decoration */}
      <div className="absolute inset-0 bg-gradient-to-br from-brand-50 via-purple-50 to-white opacity-60"></div>
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-gradient-to-br from-brand-200 to-purple-200 rounded-full blur-3xl opacity-20"></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <h2 className="text-brand-500 font-bold tracking-wide uppercase text-sm mb-3">왜 English Boost인가요?</h2>
          <p className="text-4xl sm:text-5xl font-extrabold text-slate-900 mb-4 leading-tight">
            더 빠르고, 더 쉽게,<br/>
            <span className="bg-gradient-to-r from-brand-500 to-purple-500 bg-clip-text text-transparent">더 확실하게</span>
          </p>
          <p className="text-slate-600 text-lg leading-relaxed">
            English Boost는 당신의 시간을 가장 가치 있게 만듭니다
          </p>
        </div>

        {/* Benefits Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-20">
          {benefits.map((benefit, index) => (
            <div
              key={index}
              className="group relative bg-white rounded-3xl p-8 border-2 border-slate-100 hover:border-transparent hover:shadow-2xl transition-all duration-300 hover:-translate-y-2"
            >
              {/* Gradient background on hover */}
              <div className={`absolute inset-0 rounded-3xl bg-gradient-to-br ${benefit.color} opacity-0 group-hover:opacity-5 transition-opacity duration-300`}></div>

              {/* Icon */}
              <div className={`inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-gradient-to-br ${benefit.color} text-white mb-6 shadow-lg group-hover:scale-110 transition-transform duration-300`}>
                <benefit.icon className="w-8 h-8" />
              </div>

              {/* Content */}
              <h3 className="text-2xl font-bold text-slate-900 mb-2">{benefit.title}</h3>
              <p className="text-brand-600 font-semibold mb-3">{benefit.description}</p>
              <p className="text-slate-600 leading-relaxed text-sm">{benefit.detail}</p>
            </div>
          ))}
        </div>

        {/* CTA Section */}
        <div className="relative bg-gradient-to-r from-brand-500 to-purple-500 rounded-3xl p-12 md:p-16 overflow-hidden">
          {/* Background pattern */}
          <div className="absolute inset-0 opacity-10">
            <div className="absolute top-0 right-0 w-96 h-96 bg-white rounded-full blur-3xl"></div>
            <div className="absolute bottom-0 left-0 w-96 h-96 bg-white rounded-full blur-3xl"></div>
          </div>

          <div className="relative z-10 text-center max-w-3xl mx-auto">
            <h3 className="text-3xl md:text-4xl font-extrabold text-white mb-4 leading-tight">
              지금 시작하면<br/>
              첫 달 무료로 체험하세요
            </h3>
            <p className="text-white/90 text-lg mb-8 leading-relaxed">
              English Boost의 모든 기능을 30일 동안 완전 무료로 사용해 보세요.<br/>
              신용카드 등록 없이, 언제든지 취소 가능합니다.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <button
                onClick={() => document.getElementById('waitlist')?.scrollIntoView({ behavior: 'smooth' })}
                className="px-8 py-4 bg-white text-brand-600 font-bold rounded-xl hover:bg-slate-50 transition-all duration-300 hover:scale-105 shadow-xl hover:shadow-2xl"
              >
                무료로 시작하기
              </button>
              <button className="px-8 py-4 bg-transparent border-2 border-white text-white font-bold rounded-xl hover:bg-white/10 transition-all duration-300">
                더 알아보기
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};
