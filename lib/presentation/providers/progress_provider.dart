import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/repositories/vocabulary_repository.dart';
import '../../data/datasources/repositories/grammar_repository.dart';
import '../../data/datasources/repositories/quiz_repository.dart';

// Progress State
class ProgressState {
  final int totalVocabulary;
  final int memorizedVocabulary;
  final int totalGrammar;
  final int totalQuizzes;
  final int correctAnswers;
  final int quizAccuracy;

  ProgressState({
    this.totalVocabulary = 0,
    this.memorizedVocabulary = 0,
    this.totalGrammar = 0,
    this.totalQuizzes = 0,
    this.correctAnswers = 0,
    this.quizAccuracy = 0,
  });

  int get memorizedPercentage {
    if (totalVocabulary == 0) return 0;
    return (memorizedVocabulary / totalVocabulary * 100).round();
  }

  ProgressState copyWith({
    int? totalVocabulary,
    int? memorizedVocabulary,
    int? totalGrammar,
    int? totalQuizzes,
    int? correctAnswers,
    int? quizAccuracy,
  }) {
    return ProgressState(
      totalVocabulary: totalVocabulary ?? this.totalVocabulary,
      memorizedVocabulary: memorizedVocabulary ?? this.memorizedVocabulary,
      totalGrammar: totalGrammar ?? this.totalGrammar,
      totalQuizzes: totalQuizzes ?? this.totalQuizzes,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      quizAccuracy: quizAccuracy ?? this.quizAccuracy,
    );
  }
}

// Progress Notifier
class ProgressNotifier extends StateNotifier<ProgressState> {
  final VocabularyRepository _vocabularyRepository;
  final GrammarRepository _grammarRepository;
  final QuizRepository _quizRepository;

  ProgressNotifier(
    this._vocabularyRepository,
    this._grammarRepository,
    this._quizRepository,
  ) : super(ProgressState()) {
    loadProgress();
  }

  Future<void> loadProgress() async {
    final vocabularyItems = await _vocabularyRepository.getAllVocabulary();
    final grammarItems = await _grammarRepository.getAllGrammar();
    final quizStats = await _quizRepository.getQuizStats();

    final totalVocab = vocabularyItems.length;
    final memorizedVocab =
        vocabularyItems.where((v) => v.isMemorized).length;
    final totalGrammar = grammarItems.length;

    state = ProgressState(
      totalVocabulary: totalVocab,
      memorizedVocabulary: memorizedVocab,
      totalGrammar: totalGrammar,
      totalQuizzes: quizStats['total'] as int,
      correctAnswers: quizStats['correct'] as int,
      quizAccuracy: quizStats['accuracy'] as int,
    );
  }

  Future<void> refresh() async {
    await loadProgress();
  }
}

// Progress Provider
final progressProvider =
    StateNotifierProvider<ProgressNotifier, ProgressState>((ref) {
  final vocabularyRepository = VocabularyRepository();
  final grammarRepository = GrammarRepository();
  final quizRepository = QuizRepository();

  return ProgressNotifier(
    vocabularyRepository,
    grammarRepository,
    quizRepository,
  );
});
