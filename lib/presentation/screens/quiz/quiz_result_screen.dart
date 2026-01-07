import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/quiz/quiz_question.dart';
import '../../providers/quiz_provider.dart';

class QuizResultScreen extends ConsumerWidget {
  const QuizResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final correctCount = quizState.correctAnswersCount;
    final totalCount = quizState.questions.length;
    final accuracy = quizState.accuracy;

    return Scaffold(
      appBar: AppBar(
        title: const Text('퀴즈 결과'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 결과 요약 카드
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    const Text(
                      '퀴즈 완료!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 12.0,
                      percent: accuracy / 100,
                      center: Text(
                        '$accuracy%',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      progressColor: _getColorForAccuracy(accuracy),
                      backgroundColor: Colors.grey[200]!,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _ResultStat(
                          icon: Icons.check_circle,
                          color: Colors.green,
                          label: '정답',
                          value: '$correctCount',
                        ),
                        _ResultStat(
                          icon: Icons.cancel,
                          color: Colors.red,
                          label: '오답',
                          value: '${totalCount - correctCount}',
                        ),
                        _ResultStat(
                          icon: Icons.quiz,
                          color: AppColors.quizCard,
                          label: '전체',
                          value: '$totalCount',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 메시지
            _ResultMessage(accuracy: accuracy),
            const SizedBox(height: 32),
            // 문제별 결과
            const Text(
              '문제별 결과',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...quizState.questions.asMap().entries.map((entry) {
              final index = entry.key;
              final question = entry.value;
              final userAnswer = quizState.userAnswers[index] ?? '';
              final isCorrect = userAnswer == question.correctAnswer;

              return _QuestionResultCard(
                questionNumber: index + 1,
                question: question.question,
                userAnswer: userAnswer,
                correctAnswer: question.correctAnswer,
                isCorrect: isCorrect,
              );
            }),
            const SizedBox(height: 24),
            // 하단 버튼
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ref.read(quizProvider.notifier).resetQuiz();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('종료'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(quizProvider.notifier).resetQuiz();
                      // 같은 타입의 퀴즈 다시 시작
                      if (quizState.quizType != null) {
                        switch (quizState.quizType!) {
                          case QuestionSource.vocabulary:
                            ref
                                .read(quizProvider.notifier)
                                .startVocabularyQuiz();
                            break;
                          case QuestionSource.grammar:
                            ref.read(quizProvider.notifier).startGrammarQuiz();
                            break;
                        }
                      } else {
                        ref.read(quizProvider.notifier).startMixedQuiz();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('다시 도전'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForAccuracy(int accuracy) {
    if (accuracy >= 90) return Colors.green;
    if (accuracy >= 70) return AppColors.quizCard;
    if (accuracy >= 50) return Colors.orange;
    return Colors.red;
  }
}

class _ResultStat extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _ResultStat({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: color),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _ResultMessage extends StatelessWidget {
  final int accuracy;

  const _ResultMessage({required this.accuracy});

  @override
  Widget build(BuildContext context) {
    String message;
    IconData icon;
    Color color;

    if (accuracy >= 90) {
      message = '완벽해요! 훌륭한 실력입니다!';
      icon = Icons.emoji_events;
      color = Colors.green;
    } else if (accuracy >= 70) {
      message = '잘했어요! 조금만 더 노력하면 완벽해요!';
      icon = Icons.thumb_up;
      color = AppColors.quizCard;
    } else if (accuracy >= 50) {
      message = '좋아요! 복습하면 더 잘할 수 있어요!';
      icon = Icons.sentiment_satisfied;
      color = Colors.orange;
    } else {
      message = '포기하지 마세요! 다시 도전해봐요!';
      icon = Icons.refresh;
      color = Colors.red;
    }

    return Card(
      color: color.withValues(alpha: 0.1),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionResultCard extends StatelessWidget {
  final int questionNumber;
  final String question;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;

  const _QuestionResultCard({
    required this.questionNumber,
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isCorrect
              ? Colors.green.withValues(alpha: 0.3)
              : Colors.red.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isCorrect ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isCorrect ? Icons.check : Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '문제 $questionNumber',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              question,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            if (!isCorrect) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.close, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '내 답변',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          userAnswer.isEmpty ? '(답변 안함)' : userAnswer,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '정답',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        correctAnswer,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
