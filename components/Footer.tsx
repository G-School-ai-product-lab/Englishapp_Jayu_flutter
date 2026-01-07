import React from 'react';
import { Twitter, Github, Linkedin, BookOpen } from 'lucide-react';

export const Footer: React.FC = () => {
  return (
    <footer className="bg-white border-t border-slate-100 pt-16 pb-12">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-12 mb-12">
          <div className="col-span-1 md:col-span-1">
            <div className="flex items-center space-x-2 mb-4">
               <div className="bg-brand-600 p-1.5 rounded-lg">
                <BookOpen className="h-5 w-5 text-white" />
               </div>
              <span className="text-xl font-bold text-slate-900">English Boost</span>
            </div>
            <p className="text-slate-500 text-sm leading-relaxed word-keep-all">
              누구나 쉽고 재미있게 영어를 배울 수 있도록.<br/>
              우리는 언어 학습의 장벽을 허물고 있습니다.
            </p>
          </div>

          <div>
            <h4 className="text-slate-900 font-bold mb-4">학습하기</h4>
            <ul className="space-y-2 text-sm text-slate-500">
              <li><a href="#" className="hover:text-brand-600 transition-colors">기초 회화</a></li>
              <li><a href="#" className="hover:text-brand-600 transition-colors">비즈니스 영어</a></li>
              <li><a href="#" className="hover:text-brand-600 transition-colors">여행 영어</a></li>
              <li><a href="#" className="hover:text-brand-600 transition-colors">AI 발음 교정</a></li>
            </ul>
          </div>

          <div>
            <h4 className="text-slate-900 font-bold mb-4">회사</h4>
            <ul className="space-y-2 text-sm text-slate-500">
              <li><a href="#" className="hover:text-brand-600 transition-colors">팀 소개</a></li>
              <li><a href="#" className="hover:text-brand-600 transition-colors">채용</a></li>
              <li><a href="#" className="hover:text-brand-600 transition-colors">블로그</a></li>
              <li><a href="#" className="hover:text-brand-600 transition-colors">문의하기</a></li>
            </ul>
          </div>

          <div>
            <h4 className="text-slate-900 font-bold mb-4">정책</h4>
            <ul className="space-y-2 text-sm text-slate-500">
              <li><a href="#" className="hover:text-brand-600 transition-colors">개인정보 처리방침</a></li>
              <li><a href="#" className="hover:text-brand-600 transition-colors">이용약관</a></li>
            </ul>
          </div>
        </div>

        <div className="border-t border-slate-100 pt-8 flex flex-col md:flex-row justify-between items-center">
          <p className="text-slate-400 text-sm mb-4 md:mb-0">
            &copy; {new Date().getFullYear()} English Boost Inc. All rights reserved.
          </p>
          <div className="flex space-x-6">
            <a href="#" className="text-slate-400 hover:text-brand-600 transition-colors">
              <Twitter className="h-5 w-5" />
            </a>
            <a href="#" className="text-slate-400 hover:text-brand-600 transition-colors">
              <Github className="h-5 w-5" />
            </a>
            <a href="#" className="text-slate-400 hover:text-brand-600 transition-colors">
              <Linkedin className="h-5 w-5" />
            </a>
          </div>
        </div>
      </div>
    </footer>
  );
};