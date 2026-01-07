import 'package:uuid/uuid.dart';
import '../../models/quiz/quiz_question.dart';
import '../../models/quiz/quiz_result.dart';
import '../../models/vocabulary/vocabulary_item.dart';
import '../../models/grammar/grammar_item.dart';
import '../local/database/app_database.dart';

class QuizRepository {
  final _uuid = const Uuid();

  QuizRepository();

  // 단어 기반 퀴즈 문제 생성
  List<QuizQuestion> generateVocabularyQuiz(
    List<VocabularyItem> vocabularyItems, {
    int count = 10,
  }) {
    if (vocabularyItems.length < 4) {
      return [];
    }

    final questions = <QuizQuestion>[];
    final shuffled = List<VocabularyItem>.from(vocabularyItems)..shuffle();
    final selectedItems = shuffled.take(count.clamp(1, shuffled.length));

    for (final item in selectedItems) {
      // 오답 선택지 생성
      final wrongOptions = vocabularyItems
          .where((v) => v.id != item.id)
          .toList()
        ..shuffle();

      final options = [
        item.meaning,
        ...wrongOptions.take(3).map((v) => v.meaning),
      ]..shuffle();

      questions.add(
        QuizQuestion(
          id: _uuid.v4(),
          type: QuestionType.multipleChoice,
          source: QuestionSource.vocabulary,
          sourceItemId: item.id,
          question: '다음 단어의 뜻은? "${item.word}"',
          correctAnswer: item.meaning,
          options: options,
        ),
      );
    }

    return questions;
  }

  // 문법 기반 퀴즈 문제 생성
  List<QuizQuestion> generateGrammarQuiz(
    List<GrammarItem> grammarItems, {
    int count = 10,
  }) {
    if (grammarItems.isEmpty) {
      return [];
    }

    final questions = <QuizQuestion>[];
    final shuffled = List<GrammarItem>.from(grammarItems)..shuffle();
    final selectedItems = shuffled.take(count.clamp(1, shuffled.length));

    for (final item in selectedItems) {
      if (item.exampleSentences.isEmpty) continue;

      final example = item.exampleSentences.first;

      // 빈칸 채우기 문제 생성
      final words = example.split(' ');
      if (words.length < 3) continue;

      final blankIndex = (words.length / 2).floor();
      final correctAnswer = words[blankIndex];
      words[blankIndex] = '______';
      final questionText = words.join(' ');

      // 오답 생성 (같은 난이도의 다른 문법 항목에서)
      final wrongOptions = grammarItems
          .where((g) =>
              g.id != item.id &&
              g.level == item.level &&
              g.exampleSentences.isNotEmpty)
          .toList()
        ..shuffle();

      final options = [
        correctAnswer,
        ...wrongOptions
            .take(3)
            .map((g) => g.exampleSentences.first.split(' ').firstWhere(
                  (word) => word.length > 2,
                  orElse: () => 'option',
                )),
      ]..shuffle();

      questions.add(
        QuizQuestion(
          id: _uuid.v4(),
          type: QuestionType.multipleChoice,
          source: QuestionSource.grammar,
          sourceItemId: item.id,
          question: '빈칸에 알맞은 단어는?\n$questionText',
          correctAnswer: correctAnswer,
          options: options.toSet().toList(), // 중복 제거
        ),
      );
    }

    return questions;
  }

  // 퀴즈 결과 저장
  Future<void> saveQuizResult(QuizResult result) async {
    final db = await AppDatabase.database;
    await db.insert('quiz_results', result.toMap());
  }

  // 퀴즈 결과 조회
  Future<List<QuizResult>> getQuizResults({int? limit}) async {
    final db = await AppDatabase.database;
    final maps = await db.query(
      'quiz_results',
      orderBy: 'answered_at DESC',
      limit: limit,
    );
    return maps.map((map) => QuizResult.fromMap(map)).toList();
  }

  // 퀴즈 통계
  Future<Map<String, dynamic>> getQuizStats() async {
    final db = await AppDatabase.database;

    final totalResult = await db.rawQuery(
      'SELECT COUNT(*) as total FROM quiz_results',
    );
    final total = totalResult.first['total'] as int;

    final correctResult = await db.rawQuery(
      'SELECT COUNT(*) as correct FROM quiz_results WHERE is_correct = 1',
    );
    final correct = correctResult.first['correct'] as int;

    final accuracy = total > 0 ? (correct / total * 100).toInt() : 0;

    return {
      'total': total,
      'correct': correct,
      'incorrect': total - correct,
      'accuracy': accuracy,
    };
  }

  // 틀린 문제 저장
  Future<void> saveWrongAnswer(String questionId) async {
    final db = await AppDatabase.database;
    await db.insert('wrong_answers', {
      'id': _uuid.v4(),
      'question_id': questionId,
      'wrong_count': 1,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
