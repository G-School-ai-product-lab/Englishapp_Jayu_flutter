import React, { useState, useEffect } from 'react';
import { Menu, X, BookOpen } from 'lucide-react';
import { Button } from './Button';

export const Header: React.FC = () => {
  const [isScrolled, setIsScrolled] = useState(false);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 20);
    };
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const navLinks = [
    { name: '학습 방법', href: '#' },
    { name: '커뮤니티', href: '#' },
  ];

  return (
    <header 
      className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 ${
        isScrolled || mobileMenuOpen ? 'bg-white/80 backdrop-blur-md border-b border-slate-200 shadow-sm' : 'bg-transparent border-transparent'
      }`}
    >
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-20">
          {/* Logo */}
          <div className="flex items-center space-x-2 cursor-pointer" onClick={() => window.scrollTo(0,0)}>
            <div className="bg-brand-600 p-2 rounded-xl shadow-lg shadow-brand-500/30">
              <BookOpen className="h-6 w-6 text-white" />
            </div>
            <span className="text-xl font-extrabold text-slate-900 tracking-tight">
              English<span className="text-brand-600">Boost</span>
            </span>
          </div>

          {/* Desktop Nav */}
          <nav className="hidden md:flex items-center space-x-8">
            {navLinks.map((link) => (
              <a 
                key={link.name} 
                href={link.href}
                className="text-slate-600 hover:text-brand-600 text-sm font-semibold transition-colors"
              >
                {link.name}
              </a>
            ))}
            <Button size="sm" onClick={() => document.getElementById('waitlist')?.scrollIntoView({ behavior: 'smooth' })}>
              앱 다운로드
            </Button>
          </nav>

          {/* Mobile Menu Button */}
          <div className="md:hidden">
            <button 
              onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
              className="text-slate-600 hover:text-brand-600 p-2"
            >
              {mobileMenuOpen ? <X size={24} /> : <Menu size={24} />}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile Nav */}
      {mobileMenuOpen && (
        <div className="md:hidden bg-white border-b border-slate-100 animate-in slide-in-from-top-5 shadow-lg">
          <div className="px-4 pt-2 pb-6 space-y-2">
            {navLinks.map((link) => (
              <a
                key={link.name}
                href={link.href}
                className="block px-3 py-3 rounded-lg text-base font-medium text-slate-600 hover:text-brand-600 hover:bg-brand-50"
                onClick={() => setMobileMenuOpen(false)}
              >
                {link.name}
              </a>
            ))}
            <div className="mt-6 pt-4 border-t border-slate-100">
               <Button className="w-full" onClick={() => {
                 setMobileMenuOpen(false);
                 document.getElementById('waitlist')?.scrollIntoView({ behavior: 'smooth' });
               }}>
                사전 예약하기
              </Button>
            </div>
          </div>
        </div>
      )}
    </header>
  );
};