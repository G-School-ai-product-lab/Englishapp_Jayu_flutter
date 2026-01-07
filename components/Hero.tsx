import React from 'react';
import { Button } from './Button';

export const Hero: React.FC = () => {
  return (
    <section className="relative pt-32 pb-20 lg:pt-48 lg:pb-32 overflow-hidden bg-gradient-to-br from-white via-brand-50/30 to-purple-50/30 flex flex-col items-center">
      {/* Animated background gradients */}
      <div className="absolute top-0 left-0 w-[600px] h-[600px] bg-gradient-to-br from-brand-200 to-purple-200 rounded-full blur-3xl opacity-20 animate-pulse"></div>
      <div className="absolute bottom-0 right-0 w-[500px] h-[500px] bg-gradient-to-br from-purple-200 to-pink-200 rounded-full blur-3xl opacity-20 animate-pulse" style={{ animationDelay: '1s' }}></div>
      <div className="absolute top-1/2 left-1/3 w-[400px] h-[400px] bg-gradient-to-br from-cyan-200 to-blue-200 rounded-full blur-3xl opacity-10 animate-pulse" style={{ animationDelay: '2s' }}></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 w-full flex flex-col lg:flex-row items-center gap-16 relative z-10">
        
        {/* Left: Copy */}
        <div className="flex-1 text-center lg:text-left z-10">
          {/* Badge */}
          <div className="inline-flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-brand-500 to-purple-500 text-white rounded-full text-sm font-bold mb-6 shadow-lg shadow-brand-500/30 hover:shadow-xl hover:shadow-brand-500/40 transition-all cursor-pointer">
            <span className="relative flex h-2 w-2">
              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-white opacity-75"></span>
              <span className="relative inline-flex rounded-full h-2 w-2 bg-white"></span>
            </span>
            10,000명이 선택한 1등 영어 학습 앱
          </div>

          <h1 className="text-5xl md:text-6xl lg:text-7xl font-extrabold tracking-tight mb-6 text-slate-900 leading-[1.15]">
            영어가<br/>
            <span className="bg-gradient-to-r from-brand-500 via-purple-500 to-pink-500 bg-clip-text text-transparent">가장 쉬워지는</span><br/>
            방법
          </h1>
          <p className="mt-6 text-xl text-slate-600 leading-relaxed max-w-2xl mx-auto lg:mx-0 font-medium">
            단어 암기부터 문법, 퀴즈까지. <br className="hidden md:block"/>
            과학적으로 설계된 <span className="font-bold text-brand-600">English Boost</span>로 매일 성장하세요.
          </p>
          <div className="mt-10 flex flex-col sm:flex-row gap-4 justify-center lg:justify-start">
             <Button size="lg" className="w-full sm:w-auto px-10 shadow-xl shadow-brand-500/20 bg-gradient-to-r from-brand-500 to-purple-500 hover:from-brand-600 hover:to-purple-600 border-0" onClick={() => document.getElementById('waitlist')?.scrollIntoView({ behavior: 'smooth' })}>
                무료로 시작하기 →
             </Button>
             <button className="px-10 py-4 bg-white border-2 border-slate-200 text-slate-700 font-bold rounded-xl hover:border-brand-500 hover:text-brand-600 hover:shadow-lg transition-all duration-300">
                데모 보기
             </button>
          </div>

          {/* Trust indicators */}
          <div className="mt-12 flex flex-wrap items-center gap-8 justify-center lg:justify-start text-sm text-slate-600">
            <div className="flex items-center gap-2">
              <svg className="w-5 h-5 text-green-500" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
              </svg>
              <span className="font-semibold">신용카드 불필요</span>
            </div>
            <div className="flex items-center gap-2">
              <svg className="w-5 h-5 text-green-500" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
              </svg>
              <span className="font-semibold">30일 무료 체험</span>
            </div>
            <div className="flex items-center gap-2">
              <svg className="w-5 h-5 text-green-500" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
              </svg>
              <span className="font-semibold">언제든지 취소 가능</span>
            </div>
          </div>
        </div>

        {/* Right: Hero Image / Mockup */}
        <div className="flex-1 w-full flex justify-center lg:justify-end relative">
          {/* Decorative Blobs */}
          <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[120%] h-[120%] bg-brand-100/50 rounded-full blur-[80px] -z-10"></div>
          
          {/* Main App Mockup Container */}
          <div className="relative w-[320px] h-[640px] bg-white rounded-[40px] border-[8px] border-slate-900 shadow-2xl overflow-hidden animate-float">
             {/* Mockup Header */}
             <div className="h-14 bg-white flex items-center justify-center border-b border-slate-100">
                <span className="font-bold text-lg">단어 학습</span>
             </div>
             
             {/* Mockup Content: Stats Header */}
             <div className="p-4 bg-brand-500 text-white m-4 rounded-2xl shadow-lg shadow-brand-500/30">
                <div className="flex justify-between text-center">
                   <div>
                      <div className="text-2xl font-bold">30</div>
                      <div className="text-xs opacity-80">전체</div>
                   </div>
                   <div>
                      <div className="text-2xl font-bold">12</div>
                      <div className="text-xs opacity-80">암기</div>
                   </div>
                   <div>
                      <div className="text-2xl font-bold">18</div>
                      <div className="text-xs opacity-80">미암기</div>
                   </div>
                </div>
             </div>

             {/* Mockup Content: Cards */}
             <div className="px-4 space-y-3">
                {/* Card 1 */}
                <div className="bg-white p-4 rounded-xl border border-slate-100 shadow-sm flex items-start gap-3">
                   <div className="mt-1 w-5 h-5 border-2 border-slate-300 rounded flex-shrink-0"></div>
                   <div className="flex-grow">
                      <div className="flex justify-between items-start">
                         <div>
                            <h3 className="font-bold text-lg">study</h3>
                            <span className="text-sm text-slate-400 font-mono">/'stʌdi/</span>
                         </div>
                         <span className="px-2 py-0.5 bg-green-500 text-white text-[10px] font-bold rounded">beginner</span>
                      </div>
                      <p className="text-slate-700 mt-1 font-medium">공부하다</p>
                      <span className="inline-block mt-2 px-2 py-0.5 bg-slate-100 text-slate-500 text-xs rounded border border-slate-200">verb</span>
                   </div>
                </div>

                 {/* Card 2 */}
                <div className="bg-white p-4 rounded-xl border border-slate-100 shadow-sm flex items-start gap-3 opacity-90">
                   <div className="mt-1 w-5 h-5 border-2 border-slate-300 rounded flex-shrink-0"></div>
                   <div className="flex-grow">
                      <div className="flex justify-between items-start">
                         <div>
                            <h3 className="font-bold text-lg">learn</h3>
                            <span className="text-sm text-slate-400 font-mono">/lɜːrn/</span>
                         </div>
                         <span className="px-2 py-0.5 bg-green-500 text-white text-[10px] font-bold rounded">beginner</span>
                      </div>
                      <p className="text-slate-700 mt-1 font-medium">배우다</p>
                      <span className="inline-block mt-2 px-2 py-0.5 bg-slate-100 text-slate-500 text-xs rounded border border-slate-200">verb</span>
                   </div>
                </div>
             </div>
             
             {/* Mockup Bottom Nav */}
             <div className="absolute bottom-0 left-0 right-0 h-16 bg-white border-t border-slate-100 flex justify-around items-center px-2">
                <div className="flex flex-col items-center gap-1">
                   <div className="w-6 h-6 bg-brand-500 rounded-md"></div>
                   <div className="w-8 h-2 bg-slate-200 rounded-full"></div>
                </div>
                <div className="flex flex-col items-center gap-1 opacity-40">
                   <div className="w-6 h-6 bg-slate-400 rounded-md"></div>
                   <div className="w-8 h-2 bg-slate-200 rounded-full"></div>
                </div>
                <div className="flex flex-col items-center gap-1 opacity-40">
                   <div className="w-6 h-6 bg-slate-400 rounded-md"></div>
                   <div className="w-8 h-2 bg-slate-200 rounded-full"></div>
                </div>
                <div className="flex flex-col items-center gap-1 opacity-40">
                   <div className="w-6 h-6 bg-slate-400 rounded-md"></div>
                   <div className="w-8 h-2 bg-slate-200 rounded-full"></div>
                </div>
             </div>
          </div>
        </div>

      </div>
    </section>
  );
};