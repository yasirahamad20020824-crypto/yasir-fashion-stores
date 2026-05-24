import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  /// Fetches the current user's profile data from Firestore.
  Stream<Map<String, dynamic>?> getUserProfile() {
    final uid = _userId;
    if (uid == null) return Stream.value(null);

    return _db.collection('users').doc(uid).snapshots().map((doc) => doc.data());
  }

  /// Updates the current user's profile data in Firestore.
  Future<void> updateProfile({
    required String name,
    required String phone,
    String? address,
    String? city,
  }) async {
    try {
      final uid = _userId;
      if (uid == null) throw Exception('User not logged in');

      await _db.collection('users').doc(uid).set({
        'name': name,
        'phone': phone,
        'address': address,
        'city': city,
        'email': _auth.currentUser?.email,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Also update display name in Firebase Auth
      await _auth.currentUser?.updateDisplayName(name);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
