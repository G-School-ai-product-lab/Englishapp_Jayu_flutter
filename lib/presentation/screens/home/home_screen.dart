import 'package:flutter/material.dart';
import '../vocabulary/vocabulary_list_screen.dart';
import '../grammar/grammar_list_screen.dart';
import '../quiz/quiz_screen.dart';
import '../progress/progress_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const VocabularyListScreen(),
    const GrammarListScreen(),
    const QuizScreen(),
    const ProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '단어',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '문법',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: '퀴즈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '진도',
          ),
        ],
      ),
    );
  }
}
