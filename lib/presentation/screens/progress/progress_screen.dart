import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/page_transitions.dart';
import '../../providers/progress_provider.dart';
import '../settings/settings_screen.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(progressProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('학습 진도'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                PageTransitions.slideFromRight(const SettingsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(progressProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(progressProvider.notifier).refresh();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 전체 진행률 요약
              _OverallProgressCard(progressState: progressState),
              const SizedBox(height: 16),
              // 단어 학습 진도
              _VocabularyProgressCard(progressState: progressState),
              const SizedBox(height: 16),
              // 문법 학습 진도
              _GrammarProgressCard(progressState: progressState),
              const SizedBox(height: 16),
              // 퀴즈 성적
              _QuizProgressCard(progressState: progressState),
              const SizedBox(height: 16),
              // 학습 통계
              _StudyStatsCard(progressState: progressState),
            ],
          ),
        ),
      ),
    );
  }
}

// 전체 진행률 카드
class _OverallProgressCard extends StatelessWidget {
  final ProgressState progressState;

  const _OverallProgressCard({required this.progressState});

  @override
  Widget build(BuildContext context) {
    final overallProgress = _calculateOverallProgress();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              '전체 학습 진행률',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 15.0,
              percent: overallProgress / 100,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${overallProgress.round()}%',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '완료',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              progressColor: AppColors.primary,
              backgroundColor: Colors.grey[200]!,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ],
        ),
      ),
    );
  }

  double _calculateOverallProgress() {
    // 단어 암기율 50%, 퀴즈 정확도 50%로 계산
    final vocabProgress = progressState.memorizedPercentage;
    final quizProgress = progressState.quizAccuracy;
    return (vocabProgress + quizProgress) / 2;
  }
}

// 단어 학습 진도 카드
class _VocabularyProgressCard extends StatelessWidget {
  final ProgressState progressState;

  const _VocabularyProgressCard({required this.progressState});

  @override
  Widget build(BuildContext context) {
    final percentage = progressState.memorizedPercentage;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.vocabularyCard.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.book,
                    color: AppColors.vocabularyCard,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  '단어 학습',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            LinearPercentIndicator(
              padding: EdgeInsets.zero,
              lineHeight: 12.0,
              percent: percentage / 100,
              backgroundColor: Colors.grey[200],
              progressColor: AppColors.vocabularyCard,
              barRadius: const Radius.circular(6),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '암기한 단어: ${progressState.memorizedVocabulary}/${progressState.totalVocabulary}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  '$percentage%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.vocabularyCard,
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

// 문법 학습 진도 카드
class _GrammarProgressCard extends StatelessWidget {
  final ProgressState progressState;

  const _GrammarProgressCard({required this.progressState});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.grammarCard.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.school,
                    color: AppColors.grammarCard,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  '문법 학습',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu_book,
                  size: 48,
                  color: AppColors.grammarCard,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${progressState.totalGrammar}개',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '학습 가능한 문법',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 퀴즈 성적 카드
class _QuizProgressCard extends StatelessWidget {
  final ProgressState progressState;

  const _QuizProgressCard({required this.progressState});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.quizCard.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.quiz,
                    color: AppColors.quizCard,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  '퀴즈 성적',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (progressState.totalQuizzes > 0) ...[
              LinearPercentIndicator(
                padding: EdgeInsets.zero,
                lineHeight: 12.0,
                percent: progressState.quizAccuracy / 100,
                backgroundColor: Colors.grey[200],
                progressColor: _getColorForAccuracy(progressState.quizAccuracy),
                barRadius: const Radius.circular(6),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '푼 문제: ${progressState.totalQuizzes}개',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    '${progressState.quizAccuracy}%',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _getColorForAccuracy(progressState.quizAccuracy),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '정답: ${progressState.correctAnswers}개 / 오답: ${progressState.totalQuizzes - progressState.correctAnswers}개',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ] else
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.quiz_outlined,
                        size: 48,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '아직 푼 퀴즈가 없습니다',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
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

// 학습 통계 카드
class _StudyStatsCard extends StatelessWidget {
  final ProgressState progressState;

  const _StudyStatsCard({required this.progressState});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.progressCard.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.bar_chart,
                    color: AppColors.progressCard,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  '학습 통계',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  icon: Icons.book_outlined,
                  value: '${progressState.totalVocabulary}',
                  label: '전체 단어',
                  color: AppColors.vocabularyCard,
                ),
                _StatItem(
                  icon: Icons.check_circle_outline,
                  value: '${progressState.memorizedVocabulary}',
                  label: '암기 완료',
                  color: Colors.green,
                ),
                _StatItem(
                  icon: Icons.school_outlined,
                  value: '${progressState.totalGrammar}',
                  label: '문법 항목',
                  color: AppColors.grammarCard,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
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
            fontSize: 12,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
