import React, { useState } from 'react';
import { Button } from './Button';
import { generateWelcomeMessage } from '../services/geminiService';
import { Send, Mail } from 'lucide-react';

export const Waitlist: React.FC = () => {
  const [email, setEmail] = useState('');
  const [interest, setInterest] = useState('');
  const [status, setStatus] = useState<'idle' | 'loading' | 'success'>('idle');
  const [personalMessage, setPersonalMessage] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email || !interest) return;

    setStatus('loading');
    
    // Simulate network delay
    await new Promise(resolve => setTimeout(resolve, 800));

    // Call Gemini
    const message = await generateWelcomeMessage(interest);
    
    setPersonalMessage(message);
    setStatus('success');
    setEmail('');
    setInterest('');
  };

  return (
    <section id="waitlist" className="py-32 bg-slate-900 relative overflow-hidden">
      {/* Background patterns */}
      <div className="absolute inset-0 opacity-10">
          <div className="absolute top-10 left-10 w-32 h-32 bg-white rounded-full blur-3xl"></div>
          <div className="absolute bottom-10 right-10 w-64 h-64 bg-brand-500 rounded-full blur-3xl"></div>
      </div>

      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10 text-center">
        
        <div className="mb-12 space-y-4">
            <h2 className="text-4xl md:text-5xl font-extrabold text-white">
            가장 먼저 시작하세요
            </h2>
            <p className="text-xl text-slate-300">
            지금 사전 예약하면 <span className="text-brand-400 font-bold">평생 무료 이용권</span>을 드립니다.
            </p>
        </div>

        {status === 'success' ? (
          <div className="max-w-md mx-auto bg-slate-800 rounded-3xl p-8 border border-slate-700 animate-in fade-in zoom-in duration-300">
            <div className="w-16 h-16 bg-green-500 rounded-full flex items-center justify-center mx-auto mb-6 shadow-lg shadow-green-500/30">
                <svg className="w-8 h-8 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
                    <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
                </svg>
            </div>
            <h3 className="text-2xl font-bold text-white mb-2">신청 완료!</h3>
            <div className="bg-slate-900/50 rounded-xl p-6 mt-6 border border-slate-700">
              <p className="text-brand-300 italic font-medium leading-relaxed">"{personalMessage}"</p>
              <div className="mt-4 text-xs text-slate-500 uppercase tracking-widest font-bold">From AI Tutor</div>
            </div>
            <button onClick={() => setStatus('idle')} className="mt-8 text-slate-400 hover:text-white text-sm font-medium underline underline-offset-4">
              다시 신청하기
            </button>
          </div>
        ) : (
          <form onSubmit={handleSubmit} className="max-w-lg mx-auto bg-white rounded-3xl p-2 pl-6 shadow-2xl flex flex-col sm:flex-row items-center gap-2">
             <div className="flex-grow w-full space-y-2 sm:space-y-0 py-2 sm:py-0">
                <div className="flex items-center">
                    <Mail className="w-5 h-5 text-slate-400 mr-3 flex-shrink-0" />
                    <input
                        type="email"
                        required
                        className="w-full bg-transparent border-none focus:ring-0 text-slate-900 placeholder-slate-400 font-medium"
                        placeholder="이메일 주소를 입력하세요"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                    />
                </div>
                <div className="h-px bg-slate-100 sm:hidden"></div>
                 {/* Hidden input for interest to simplify UI or use a modal in real app. 
                     For this demo, let's keep it simple or incorporate it. 
                     Wait, the prompt requires the 'interest' for Gemini. 
                     Let's make this a multi-step or just a larger form if we need interest.
                     Actually, let's just restore the card form for better UX with 'interest'.
                  */}
             </div>
             
             {/* Reverting to a better form layout for two inputs */}
             <style>{`.simple-form { display: none; }`}</style>
          </form>
        )}
        
        {/* Actual Form (visible) */}
        {status !== 'success' && (
            <div className="max-w-md mx-auto bg-white rounded-3xl p-6 md:p-8 shadow-2xl text-left">
                <form onSubmit={handleSubmit} className="space-y-4">
                    <div>
                        <label className="block text-sm font-bold text-slate-700 mb-1 ml-1">이메일</label>
                        <input 
                            type="email" 
                            required
                            className="w-full bg-slate-50 border-2 border-slate-100 rounded-xl px-4 py-3 text-slate-900 font-medium focus:outline-none focus:border-brand-500 transition-colors"
                            placeholder="hello@example.com"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                        />
                    </div>
                    <div>
                        <label className="block text-sm font-bold text-slate-700 mb-1 ml-1">영어 고민</label>
                        <input 
                            type="text" 
                            required
                            className="w-full bg-slate-50 border-2 border-slate-100 rounded-xl px-4 py-3 text-slate-900 font-medium focus:outline-none focus:border-brand-500 transition-colors"
                            placeholder="예: 단어가 안 외워져요"
                            value={interest}
                            onChange={(e) => setInterest(e.target.value)}
                        />
                    </div>
                    <Button type="submit" size="lg" className="w-full mt-4 text-lg py-4 shadow-xl shadow-brand-500/20" isLoading={status === 'loading'}>
                        초대장 받기 <Send className="ml-2 w-5 h-5" />
                    </Button>
                </form>
            </div>
        )}

      </div>
    </section>
  );
};