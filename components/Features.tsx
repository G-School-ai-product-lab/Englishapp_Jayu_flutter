import React from 'react';
import { BookOpen, Brain, Trophy, Zap, LineChart, Sparkles } from 'lucide-react';

const features = [
  {
    name: '맞춤형 학습',
    description: 'AI가 당신의 실력을 분석해서 꼭 필요한 단어와 문법만 추천해 드려요. 더 이상 불필요한 시간 낭비는 없습니다.',
    icon: Brain,
    color: 'from-purple-500 to-pink-500',
  },
  {
    name: '과학적 암기법',
    description: '간격 반복 학습(Spaced Repetition)으로 장기 기억에 확실하게 저장됩니다. 한번 외운 단어, 평생 기억하세요.',
    icon: BookOpen,
    color: 'from-blue-500 to-cyan-500',
  },
  {
    name: '실시간 퀴즈',
    description: '학습한 내용을 바로바로 퀴즈로 확인하세요. 게임처럼 재미있는 문제 풀이로 지루할 틈이 없습니다.',
    icon: Zap,
    color: 'from-yellow-500 to-orange-500',
  },
  {
    name: '성장 시각화',
    description: '매일매일 쌓이는 학습 데이터를 한눈에 확인하세요. 당신의 성장 곡선을 직접 눈으로 확인할 수 있습니다.',
    icon: LineChart,
    color: 'from-green-500 to-emerald-500',
  },
  {
    name: '레벨별 학습',
    description: '초급부터 고급까지, 당신의 레벨에 딱 맞는 콘텐츠를 제공합니다. 무리하지 않고 차근차근 실력을 쌓아가세요.',
    icon: Trophy,
    color: 'from-red-500 to-rose-500',
  },
  {
    name: 'AI 발음 코칭',
    description: '정확한 발음 기호와 예시 문장으로 원어민처럼 말할 수 있도록 도와드립니다. 듣기와 말하기를 동시에 향상시키세요.',
    icon: Sparkles,
    color: 'from-indigo-500 to-purple-500',
  },
];

export const Features: React.FC = () => {
  return (
    <section id="features" className="py-24 bg-gradient-to-b from-white via-slate-50 to-white relative overflow-hidden">
      {/* Decorative background elements */}
      <div className="absolute top-0 left-1/4 w-96 h-96 bg-brand-100 rounded-full blur-3xl opacity-30"></div>
      <div className="absolute bottom-0 right-1/4 w-96 h-96 bg-purple-100 rounded-full blur-3xl opacity-30"></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="text-center max-w-3xl mx-auto mb-16">
          <h2 className="text-brand-500 font-bold tracking-wide uppercase text-sm mb-3">핵심 기능</h2>
          <p className="text-4xl sm:text-5xl font-extrabold text-slate-900 mb-4 leading-tight">
            당신의 영어 실력을<br/>
            <span className="bg-gradient-to-r from-brand-500 to-purple-500 bg-clip-text text-transparent">확실하게 성장</span>시키는 방법
          </p>
          <p className="text-slate-600 text-lg leading-relaxed">
            English Boost는 과학적으로 검증된 학습 방법과 AI 기술을 결합하여<br/>
            가장 효과적인 영어 학습 경험을 제공합니다.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {features.map((feature) => (
            <div
              key={feature.name}
              className="group relative p-8 rounded-3xl bg-white border-2 border-slate-100 hover:border-transparent hover:shadow-2xl hover:shadow-brand-500/10 transition-all duration-300 hover:-translate-y-1"
            >
              {/* Gradient border on hover */}
              <div className={`absolute inset-0 rounded-3xl bg-gradient-to-r ${feature.color} opacity-0 group-hover:opacity-100 -z-10 blur transition-opacity duration-300`}></div>

              <div className={`inline-flex items-center justify-center p-4 rounded-2xl bg-gradient-to-r ${feature.color} text-white mb-5 shadow-lg shadow-slate-900/10 group-hover:scale-110 transition-transform duration-300`}>
                <feature.icon className="h-7 w-7" aria-hidden="true" />
              </div>
              <h3 className="text-2xl font-bold text-slate-900 mb-3 group-hover:text-brand-600 transition-colors">
                {feature.name}
              </h3>
              <p className="text-slate-600 leading-relaxed">
                {feature.description}
              </p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};