import React from 'react';
import { Header } from './components/Header';
import { Hero } from './components/Hero';
import { AppShowcase } from './components/AppShowcase';
import { Features } from './components/Features';
import { Stats } from './components/Stats';
import { Testimonials } from './components/Testimonials';
import { Waitlist } from './components/Waitlist';
import { Footer } from './components/Footer';

const App: React.FC = () => {
  return (
    <div className="min-h-screen flex flex-col bg-white text-slate-900 overflow-x-hidden">
      <Header />
      <main className="flex-grow">
        <Hero />
        <AppShowcase />
        <Features />
        <Stats />
        <Testimonials />
        <Waitlist />
      </main>
      <Footer />
    </div>
  );
};

export default App;