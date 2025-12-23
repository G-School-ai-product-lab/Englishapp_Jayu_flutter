import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/vocabulary/vocabulary_item.dart';
import '../../models/grammar/grammar_item.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collections
  String get _vocabularyCollection => 'vocabulary';
  String get _grammarCollection => 'grammar';
  String get _userDataCollection => 'users';

  // Get user-specific collection path
  String _getUserPath(String userId) => '$_userDataCollection/$userId';

  // ==================== Vocabulary ====================

  /// Sync vocabulary to Firestore
  Future<void> syncVocabulary(String userId, VocabularyItem item) async {
    try {
      await _firestore
          .collection(_getUserPath(userId))
          .doc(_vocabularyCollection)
          .collection('items')
          .doc(item.id)
          .set(item.toMap());
    } catch (e) {
      throw Exception('Failed to sync vocabulary: $e');
    }
  }

  /// Sync multiple vocabulary items
  Future<void> syncVocabularyBatch(
    String userId,
    List<VocabularyItem> items,
  ) async {
    try {
      final batch = _firestore.batch();
      final collectionRef = _firestore
          .collection(_getUserPath(userId))
          .doc(_vocabularyCollection)
          .collection('items');

      for (var item in items) {
        batch.set(collectionRef.doc(item.id), item.toMap());
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to sync vocabulary batch: $e');
    }
  }

  /// Get all vocabulary for user
  Future<List<VocabularyItem>> getUserVocabulary(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_getUserPath(userId))
          .doc(_vocabularyCollection)
          .collection('items')
          .get();

      return snapshot.docs
          .map((doc) => VocabularyItem.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get user vocabulary: $e');
    }
  }

  /// Stream vocabulary changes
  Stream<List<VocabularyItem>> vocabularyStream(String userId) {
    return _firestore
        .collection(_getUserPath(userId))
        .doc(_vocabularyCollection)
        .collection('items')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => VocabularyItem.fromMap(doc.data()))
            .toList());
  }

  /// Delete vocabulary item
  Future<void> deleteVocabulary(String userId, String itemId) async {
    try {
      await _firestore
          .collection(_getUserPath(userId))
          .doc(_vocabularyCollection)
          .collection('items')
          .doc(itemId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete vocabulary: $e');
    }
  }

  // ==================== Grammar ====================

  /// Sync grammar to Firestore
  Future<void> syncGrammar(String userId, GrammarItem item) async {
    try {
      await _firestore
          .collection(_getUserPath(userId))
          .doc(_grammarCollection)
          .collection('items')
          .doc(item.id)
          .set(item.toMap());
    } catch (e) {
      throw Exception('Failed to sync grammar: $e');
    }
  }

  /// Sync multiple grammar items
  Future<void> syncGrammarBatch(
    String userId,
    List<GrammarItem> items,
  ) async {
    try {
      final batch = _firestore.batch();
      final collectionRef = _firestore
          .collection(_getUserPath(userId))
          .doc(_grammarCollection)
          .collection('items');

      for (var item in items) {
        batch.set(collectionRef.doc(item.id), item.toMap());
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to sync grammar batch: $e');
    }
  }

  /// Get all grammar for user
  Future<List<GrammarItem>> getUserGrammar(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_getUserPath(userId))
          .doc(_grammarCollection)
          .collection('items')
          .get();

      return snapshot.docs
          .map((doc) => GrammarItem.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get user grammar: $e');
    }
  }

  /// Stream grammar changes
  Stream<List<GrammarItem>> grammarStream(String userId) {
    return _firestore
        .collection(_getUserPath(userId))
        .doc(_grammarCollection)
        .collection('items')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => GrammarItem.fromMap(doc.data()))
            .toList());
  }

  /// Delete grammar item
  Future<void> deleteGrammar(String userId, String itemId) async {
    try {
      await _firestore
          .collection(_getUserPath(userId))
          .doc(_grammarCollection)
          .collection('items')
          .doc(itemId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete grammar: $e');
    }
  }

  // ==================== User Data Sync ====================

  /// Initial sync: Push local data to Firestore
  Future<void> initialSync(
    String userId,
    List<VocabularyItem> vocabulary,
    List<GrammarItem> grammar,
  ) async {
    try {
      await Future.wait([
        syncVocabularyBatch(userId, vocabulary),
        syncGrammarBatch(userId, grammar),
      ]);
    } catch (e) {
      throw Exception('Failed to perform initial sync: $e');
    }
  }

  /// Pull all user data from Firestore
  Future<Map<String, dynamic>> pullUserData(String userId) async {
    try {
      final results = await Future.wait([
        getUserVocabulary(userId),
        getUserGrammar(userId),
      ]);

      return {
        'vocabulary': results[0] as List<VocabularyItem>,
        'grammar': results[1] as List<GrammarItem>,
      };
    } catch (e) {
      throw Exception('Failed to pull user data: $e');
    }
  }
}
