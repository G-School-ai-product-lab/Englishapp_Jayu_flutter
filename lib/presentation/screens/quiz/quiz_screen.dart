import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/quiz_provider.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);

    if (quizState.questions.isEmpty) {
      return const QuizStartScreen();
    }

    if (quizState.isCompleted) {
      return const QuizResultScreen();
    }

    return const QuizQuestionScreen();
  }
}

// 퀴즈 시작 화면
class QuizStartScreen extends ConsumerWidget {
  const QuizStartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('퀴즈'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.quiz,
              size: 100,
              color: AppColors.quizCard,
            ),
            const SizedBox(height: 24),
            const Text(
              '퀴즈를 시작하세요!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              '학습한 내용을 퀴즈로 확인해보세요',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            _QuizTypeCard(
              title: '단어 퀴즈',
              subtitle: '단어의 뜻을 맞춰보세요',
              icon: Icons.book,
              color: AppColors.vocabularyCard,
              onTap: () {
                ref.read(quizProvider.notifier).startVocabularyQuiz();
              },
            ),
            const SizedBox(height: 16),
            _QuizTypeCard(
              title: '문법 퀴즈',
              subtitle: '문법 문제를 풀어보세요',
              icon: Icons.school,
              color: AppColors.grammarCard,
              onTap: () {
                ref.read(quizProvider.notifier).startGrammarQuiz();
              },
            ),
            const SizedBox(height: 16),
            _QuizTypeCard(
              title: '혼합 퀴즈',
              subtitle: '단어와 문법을 함께 학습하세요',
              icon: Icons.shuffle,
              color: AppColors.progressCard,
              onTap: () {
                ref.read(quizProvider.notifier).startMixedQuiz();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuizTypeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// 퀴즈 문제 화면
class QuizQuestionScreen extends ConsumerWidget {
  const QuizQuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final question = quizState.currentQuestion;

    if (question == null) {
      return const Scaffold(
        body: Center(child: Text('문제가 없습니다')),
      );
    }

    final selectedAnswer = quizState.userAnswers[quizState.currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '문제 ${quizState.currentQuestionIndex + 1} / ${quizState.questions.length}',
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('퀴즈 종료'),
                content: const Text('퀴즈를 종료하시겠습니까?\n진행 상황은 저장되지 않습니다.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('취소'),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(quizProvider.notifier).resetQuiz();
                      Navigator.pop(context);
                    },
                    child: const Text('종료'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          // 진행률 표시
          LinearProgressIndicator(
            value: (quizState.currentQuestionIndex + 1) /
                quizState.questions.length,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 문제
                  Card(
                    elevation: 0,
                    color: AppColors.quizCard.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // 선택지
                  ...question.options!.asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    final isSelected = selectedAnswer == option;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _OptionButton(
                        option: option,
                        index: index,
                        isSelected: isSelected,
                        onTap: () {
                          ref.read(quizProvider.notifier).submitAnswer(option);
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          // 하단 버튼
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                if (quizState.currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ref.read(quizProvider.notifier).previousQuestion();
                      },
                      child: const Text('이전'),
                    ),
                  ),
                if (quizState.currentQuestionIndex > 0)
                  const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: selectedAnswer != null
                        ? () {
                            ref.read(quizProvider.notifier).nextQuestion();
                          }
                        : null,
                    child: Text(
                      quizState.currentQuestionIndex ==
                              quizState.questions.length - 1
                          ? '완료'
                          : '다음',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  final String option;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionButton({
    required this.option,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final labels = ['A', 'B', 'C', 'D'];

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? AppColors.primary.withOpacity(0.05)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  labels[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
