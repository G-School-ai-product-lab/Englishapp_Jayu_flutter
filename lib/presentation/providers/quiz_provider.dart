import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/quiz/quiz_question.dart';
import '../../data/models/quiz/quiz_result.dart';
import '../../data/datasources/repositories/quiz_repository.dart';
import '../../data/datasources/repositories/vocabulary_repository.dart';
import '../../data/datasources/repositories/grammar_repository.dart';
import 'package:uuid/uuid.dart';

// Repository Providers
final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepository();
});

final vocabularyRepositoryProvider = Provider<VocabularyRepository>((ref) {
  return VocabularyRepository();
});

final grammarRepositoryProvider = Provider<GrammarRepository>((ref) {
  return GrammarRepository();
});

// Quiz State
class QuizState {
  final List<QuizQuestion> questions;
  final int currentQuestionIndex;
  final Map<int, String> userAnswers;
  final bool isCompleted;
  final QuestionSource? quizType;

  QuizState({
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.userAnswers = const {},
    this.isCompleted = false,
    this.quizType,
  });

  QuizState copyWith({
    List<QuizQuestion>? questions,
    int? currentQuestionIndex,
    Map<int, String>? userAnswers,
    bool? isCompleted,
    QuestionSource? quizType,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      userAnswers: userAnswers ?? this.userAnswers,
      isCompleted: isCompleted ?? this.isCompleted,
      quizType: quizType ?? this.quizType,
    );
  }

  QuizQuestion? get currentQuestion {
    if (currentQuestionIndex < questions.length) {
      return questions[currentQuestionIndex];
    }
    return null;
  }

  int get correctAnswersCount {
    int correct = 0;
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] == questions[i].correctAnswer) {
        correct++;
      }
    }
    return correct;
  }

  int get accuracy {
    if (questions.isEmpty) return 0;
    return (correctAnswersCount / questions.length * 100).round();
  }
}

// Quiz StateNotifier
class QuizNotifier extends StateNotifier<QuizState> {
  final QuizRepository _quizRepository;
  final VocabularyRepository _vocabularyRepository;
  final GrammarRepository _grammarRepository;

  QuizNotifier(
    this._quizRepository,
    this._vocabularyRepository,
    this._grammarRepository,
  ) : super(QuizState());

  // 단어 퀴즈 시작
  Future<void> startVocabularyQuiz({int count = 10}) async {
    final vocabularyItems = await _vocabularyRepository.getAllVocabulary();
    final questions =
        _quizRepository.generateVocabularyQuiz(vocabularyItems, count: count);

    state = QuizState(
      questions: questions,
      currentQuestionIndex: 0,
      userAnswers: {},
      isCompleted: false,
      quizType: QuestionSource.vocabulary,
    );
  }

  // 문법 퀴즈 시작
  Future<void> startGrammarQuiz({int count = 10}) async {
    final grammarItems = await _grammarRepository.getAllGrammar();
    final questions =
        _quizRepository.generateGrammarQuiz(grammarItems, count: count);

    state = QuizState(
      questions: questions,
      currentQuestionIndex: 0,
      userAnswers: {},
      isCompleted: false,
      quizType: QuestionSource.grammar,
    );
  }

  // 혼합 퀴즈 시작
  Future<void> startMixedQuiz({int count = 10}) async {
    final vocabularyItems = await _vocabularyRepository.getAllVocabulary();
    final grammarItems = await _grammarRepository.getAllGrammar();

    final vocabQuestions = _quizRepository.generateVocabularyQuiz(
      vocabularyItems,
      count: (count / 2).ceil(),
    );
    final grammarQuestions = _quizRepository.generateGrammarQuiz(
      grammarItems,
      count: (count / 2).floor(),
    );

    final allQuestions = [...vocabQuestions, ...grammarQuestions]..shuffle();

    state = QuizState(
      questions: allQuestions,
      currentQuestionIndex: 0,
      userAnswers: {},
      isCompleted: false,
      quizType: null, // Mixed
    );
  }

  // 답변 제출
  void submitAnswer(String answer) {
    final newAnswers = Map<int, String>.from(state.userAnswers);
    newAnswers[state.currentQuestionIndex] = answer;

    state = state.copyWith(userAnswers: newAnswers);
  }

  // 다음 문제로
  void nextQuestion() {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
      );
    } else {
      completeQuiz();
    }
  }

  // 이전 문제로
  void previousQuestion() {
    if (state.currentQuestionIndex > 0) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex - 1,
      );
    }
  }

  // 퀴즈 완료
  Future<void> completeQuiz() async {
    state = state.copyWith(isCompleted: true);

    // 결과 저장
    const uuid = Uuid();
    for (int i = 0; i < state.questions.length; i++) {
      final question = state.questions[i];
      final userAnswer = state.userAnswers[i] ?? '';
      final isCorrect = userAnswer == question.correctAnswer;

      final result = QuizResult(
        id: uuid.v4(),
        questionId: question.id,
        userAnswer: userAnswer,
        isCorrect: isCorrect,
        answeredAt: DateTime.now(),
      );

      await _quizRepository.saveQuizResult(result);

      // 틀린 문제 저장
      if (!isCorrect) {
        await _quizRepository.saveWrongAnswer(question.id);
      }
    }
  }

  // 퀴즈 초기화
  void resetQuiz() {
    state = QuizState();
  }
}

// Quiz Provider
final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>((ref) {
  final quizRepository = ref.watch(quizRepositoryProvider);
  final vocabularyRepository = ref.watch(vocabularyRepositoryProvider);
  final grammarRepository = ref.watch(grammarRepositoryProvider);

  return QuizNotifier(
    quizRepository,
    vocabularyRepository,
    grammarRepository,
  );
});

// Quiz Stats Provider
final quizStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final repository = ref.watch(quizRepositoryProvider);
  return await repository.getQuizStats();
});
