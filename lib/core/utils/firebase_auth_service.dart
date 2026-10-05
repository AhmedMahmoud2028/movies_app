import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../service/snack_bar_service.dart';

class FirebaseAuthService {

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<bool> createAccount ({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    /// Don't Forget install flutter pub add firebase_auth before that
    /// After That => flutterfire configure

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password ,);
      await credential.user?.updateDisplayName(name);

      if (credential.user != null) {
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'uid': credential.user!.uid,
          'name': name,
          'email': email,
          'phone': phone,
          'createdAt': DateTime.now(),
        });
      }

      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarService.showErrorMessage("The password provided is too weak.");
        return Future.value(false);

      } else if (e.code == 'email-already-in-use') {
        SnackBarService.showErrorMessage("The account already exists for that email.");
        return Future.value(false);
      }
      return Future.value(false);
    } catch (e) {
      SnackBarService.showErrorMessage("something went wrong");
      return Future.value(false);
    }

  }

  static Future<bool> signInWithAccount (String emailAddress,String password) async {

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarService.showErrorMessage("No user found for that email.");
        return Future.value(false);
      } else if (e.code == 'invalid-credential') {
        SnackBarService.showErrorMessage(
            "Wrong password provided for that user.");
        return Future.value(false);
      }
      return Future.value(false);
    } catch (e){
      SnackBarService.showErrorMessage("something went wrong");
      return Future.value(false);
    }

  }


}