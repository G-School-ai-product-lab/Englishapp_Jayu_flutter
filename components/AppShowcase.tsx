import React from 'react';
import { Check, Star } from 'lucide-react';

export const AppShowcase: React.FC = () => {
  return (
    <div className="w-full bg-white overflow-hidden">
      
      {/* Section 1: Vocabulary (Img Left, Text Right) */}
      <section className="py-24 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex flex-col md:flex-row items-center gap-16">
          <div className="flex-1 w-full max-w-sm">
             {/* Visual: Vocab Card Stack */}
             <div className="relative">
                <div className="absolute top-4 -right-4 w-full h-full bg-brand-100 rounded-3xl -z-10 rotate-3"></div>
                <div className="bg-white rounded-3xl border-2 border-slate-100 shadow-xl p-6">
                    <div className="flex justify-between items-start mb-4">
                        <div className="space-y-1">
                            <h3 className="text-3xl font-extrabold text-slate-900">practice</h3>
                            <p className="text-slate-400 font-mono text-sm">/'præktɪs/</p>
                        </div>
                        <span className="px-3 py-1 bg-green-500 text-white text-xs font-bold rounded-lg uppercase tracking-wider">Beginner</span>
                    </div>
                    <div className="h-px bg-slate-100 w-full mb-4"></div>
                    <p className="text-2xl font-bold text-slate-700 mb-4">연습하다</p>
                    <span className="inline-block px-3 py-1 bg-slate-100 text-slate-500 text-sm font-semibold rounded-md border border-slate-200">verb</span>
                    <div className="mt-6 flex justify-end">
                       <button className="bg-brand-500 hover:bg-brand-600 text-white rounded-full p-3 shadow-lg shadow-brand-500/30 transition-all">
                          <Check className="w-6 h-6" />
                       </button>
                    </div>
                </div>
             </div>
          </div>
          <div className="flex-1 text-center md:text-left space-y-6">
            <h2 className="text-4xl md:text-5xl font-extrabold text-slate-900 leading-tight">
              단어 학습,<br /> 
              <span className="text-green-500">지루할 틈 없이.</span>
            </h2>
            <p className="text-lg text-slate-500 font-medium">
              내 레벨에 딱 맞는 단어만 쏙쏙 골라 드려요.<br/>
              발음 기호부터 품사까지, 한 장의 카드로 완벽하게 마스터하세요.
            </p>
          </div>
        </div>
      </section>

      {/* Section 2: Grammar (Text Left, Img Right) */}
      <section className="py-24 bg-slate-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="flex flex-col md:flex-row-reverse items-center gap-16">
            <div className="flex-1 w-full max-w-sm">
                {/* Visual: Grammar List */}
                <div className="bg-white rounded-3xl shadow-xl border border-slate-100 overflow-hidden">
                    <div className="bg-slate-50 p-4 border-b border-slate-100 flex justify-between items-center">
                        <span className="font-bold text-slate-900">문법 학습</span>
                        <div className="flex gap-1">
                            <div className="w-3 h-3 rounded-full bg-red-400"></div>
                            <div className="w-3 h-3 rounded-full bg-yellow-400"></div>
                            <div className="w-3 h-3 rounded-full bg-green-400"></div>
                        </div>
                    </div>
                    <div className="p-4 space-y-4">
                        <div className="bg-white border-2 border-slate-100 rounded-2xl p-5 hover:border-brand-300 transition-colors cursor-pointer">
                            <div className="flex justify-between items-start mb-2">
                                <h4 className="font-bold text-lg text-slate-900">Inversion</h4>
                                <span className="px-2 py-1 bg-red-500 text-white text-[10px] font-bold rounded uppercase">Advanced</span>
                            </div>
                            <p className="text-slate-600 text-sm leading-relaxed">
                                도치는 강조나 형식적인 문체를 위해 어순을 바꾸는 것입니다.
                            </p>
                            <div className="mt-3 inline-block px-3 py-1 bg-slate-100 text-slate-500 text-xs rounded-lg">
                                other
                            </div>
                        </div>
                         <div className="bg-white border-2 border-slate-100 rounded-2xl p-5 opacity-60">
                            <div className="flex justify-between items-start mb-2">
                                <h4 className="font-bold text-lg text-slate-900">Causative Verbs</h4>
                                <span className="px-2 py-1 bg-red-500 text-white text-[10px] font-bold rounded uppercase">Advanced</span>
                            </div>
                            <div className="h-2 bg-slate-100 rounded w-3/4 mb-2"></div>
                            <div className="h-2 bg-slate-100 rounded w-1/2"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div className="flex-1 text-center md:text-left space-y-6">
                <h2 className="text-4xl md:text-5xl font-extrabold text-slate-900 leading-tight">
                어려운 문법도<br /> 
                <span className="text-red-500">블록 맞추기처럼.</span>
                </h2>
                <p className="text-lg text-slate-500 font-medium">
                복잡한 문법 용어도 쉬운 예시로 설명해 드려요.<br/>
                핵심만 콕 집어주는 요약 카드로 문법 울렁증을 극복하세요.
                </p>
            </div>
            </div>
        </div>
      </section>

      {/* Section 3: Quiz & Stats (Img Left, Text Right) */}
      <section className="py-24 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex flex-col md:flex-row items-center gap-16">
          <div className="flex-1 w-full max-w-sm flex justify-center">
             {/* Visual: Stats Dashboard */}
             <div className="w-full bg-white rounded-[2rem] shadow-2xl border border-slate-100 p-6 relative">
                 <div className="absolute -top-6 -left-6 bg-yellow-400 p-4 rounded-2xl shadow-lg rotate-12 z-10">
                     <Star className="w-8 h-8 text-white fill-white" />
                 </div>
                 <h3 className="text-xl font-bold text-slate-900 mb-6 pl-2">학습 진도</h3>
                 <div className="grid grid-cols-2 gap-4">
                     <div className="bg-brand-50 rounded-2xl p-5 flex flex-col items-center justify-center space-y-2">
                         <div className="bg-white p-2 rounded-full shadow-sm">
                            <svg className="w-6 h-6 text-brand-500" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" /></svg>
                         </div>
                         <div className="text-3xl font-extrabold text-slate-900">30</div>
                         <div className="text-xs text-slate-500 font-bold">전체 단어</div>
                     </div>
                     <div className="bg-green-50 rounded-2xl p-5 flex flex-col items-center justify-center space-y-2">
                         <div className="bg-white p-2 rounded-full shadow-sm">
                            <Check className="w-6 h-6 text-green-500" />
                         </div>
                         <div className="text-3xl font-extrabold text-slate-900">12</div>
                         <div className="text-xs text-slate-500 font-bold">퀴즈 완료</div>
                     </div>
                     <div className="col-span-2 bg-slate-50 rounded-2xl p-5 flex items-center justify-between">
                         <div className="flex items-center gap-3">
                             <div className="bg-white p-2 rounded-xl shadow-sm">
                                <svg className="w-6 h-6 text-slate-700" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" /></svg>
                             </div>
                             <div>
                                 <div className="font-bold text-slate-900">학습 통계</div>
                                 <div className="text-xs text-slate-500">이번 주 달성률 85%</div>
                             </div>
                         </div>
                         <div className="text-brand-500 font-bold text-sm">보기 &rarr;</div>
                     </div>
                 </div>
             </div>
          </div>
          <div className="flex-1 text-center md:text-left space-y-6">
            <h2 className="text-4xl md:text-5xl font-extrabold text-slate-900 leading-tight">
              매일매일<br /> 
              <span className="text-brand-500">성장하는 재미.</span>
            </h2>
            <p className="text-lg text-slate-500 font-medium">
              퀴즈로 실력을 확인하고 통계로 성장을 체감하세요.<br/>
              English Boost가 당신의 학습 러닝메이트가 되어드립니다.
            </p>
          </div>
        </div>
      </section>

    </div>
  );
};