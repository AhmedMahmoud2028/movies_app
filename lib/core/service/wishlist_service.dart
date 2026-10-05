import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class WishlistService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> toggleWishlist(Map<String, dynamic> movieData) async {
    final user = _auth.currentUser;

    // 1. التأكد من وجود مستخدم مسجل الدخول
    if (user == null) {
      if (kDebugMode) print("❌ Error: No user logged in!");
      return;
    }

    final docId = movieData['id'].toString();
    final docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('wishlist')
        .doc(docId);

    try {
      final doc = await docRef.get();

      if (doc.exists) {
        // إذا كان الفيلم موجوداً مسبقاً -> نحذفه
        await docRef.delete();
        if (kDebugMode) print("🗑️ Movie removed from wishlist!");
      } else {
        // إذا لم يكن موجوداً -> نضيفه
        await docRef.set(movieData);
        if (kDebugMode) print("✅ Movie added to wishlist successfully!");
      }
    } catch (e) {
      if (kDebugMode) print("❌ Error updating wishlist: $e");
    }
  }
}