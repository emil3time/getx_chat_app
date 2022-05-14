import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_chat_app/app/modules/auth/views/auth_view.dart';
import 'package:getx_chat_app/app/modules/chat/views/chat_view.dart';

enum AuthError {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  emailAlreadyInUse,
  invalidCredential,
  operationNotAllowed,
  weakPassword,
  error,
}

class AuthController extends GetxController {
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Rx<User?> firebaseUser = Rxn<User>();
  // bool isLoading = false;

  late String authorUID = auth.currentUser!.uid;
  DateTime createdAt = DateTime.now();
  String? messageContent;
  bool visible = true;

  //  snapshot.data!.docs[index].reference.update({

  Future<void> saveMessage() async {
    try {
      await FirebaseFirestore.instance
          .collection('chat_app')
          .doc('XUabc2KTxL0jod7tPIv8')
          .collection('messages')
          .add({
        "authorUID": authorUID,
        "createdAt": createdAt,
        "messageContent": messageController.text.trim(),
        "visible": true
      });
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      print(e.toString());
    }
    messageController.clear();
    closeKeyboard();
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      // user is logged in
      Get.offAll(() => ChatView());
    } else {
      // user is null as in user is not available or not logged in
      Get.offAll(() => AuthView());
    }
  }

  Future<void> register(
      {required String email, required String password}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((response) {
        final id = response.user!.uid;
        final em = email;
        _addUserToFirestore(id, em);
      });
    } on FirebaseAuthException catch (e) {
      throw _determineError(e);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _addUserToFirestore(String userId, String email) async {
    await FirebaseFirestore.instance
        .collection('chat_app')
        .doc('XUabc2KTxL0jod7tPIv8')
        .collection('users_collection')
        .doc(userId)
        .set({'id': userId, 'email': email});
  }

  Future<void> login({required String email, required String password}) async {
    try {
      _showLoading();
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      dismissLoading();
      throw _determineError(e);
    } catch (e) {
      print(e.toString());
      dismissLoading();
    }
  }

  void signOut() {
    if (firebaseUser.value == null) {
      Get.snackbar('User info', 'No user log in');
      return;
    }
    try {
      auth.signOut();
    } catch (e) {
      Get.snackbar('Error Sign Out ', e.toString());
    }
  }

  _showLoading() {
    Get.defaultDialog(
        barrierDismissible: true,
        title: 'Loading...',
        content: CircularProgressIndicator());
  }

  dismissLoading() {
    Get.back(closeOverlays: true);
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
  }

  AuthError _determineError(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return AuthError.invalidEmail;
      case 'user-disabled':
        return AuthError.userDisabled;
      case 'user-not-found':
        return AuthError.userNotFound;
      case 'wrong-password':
        return AuthError.wrongPassword;
      case 'email-already-in-use':
      case 'account-exists-with-different-credential':
        return AuthError.emailAlreadyInUse;
      case 'invalid-credential':
        return AuthError.invalidCredential;
      case 'operation-not-allowed':
        return AuthError.operationNotAllowed;
      case 'weak-password':
        return AuthError.weakPassword;
      case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
      default:
        return AuthError.error;
    }
  }

  String? validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
    // Minimum six characters, at least one letter and one number:
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return ' Password: min. 6 characters witch at least one number';
      } else {
        return null;
      }
    }
  }

  String? validateEmail(String value) {
    RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value.isEmpty) {
      return 'Please enter email';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter Correct Email Address';
      } else {
        return null;
      }
    }
  }

  closeKeyboard() {
    return Get.focusScope!.unfocus();
  }

  String? messageValidator(String value) {
    if (value.isEmpty) {
      return 'write some text';
    }
    if (value.length > 500) {
      return 'Max message lenght = 500 char';
    }
    return null;
  }
}
