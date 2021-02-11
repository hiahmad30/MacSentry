import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:macsentry/Views/HomeDrawer.dart';
import 'package:macsentry/Views/Login.dart';

//import 'package:mongo_dart/mongo_dart.dart';

class AuthController extends GetxController {
  // Intilize the flutter app
  FirebaseApp firebaseApp;
  User firebaseUser;
  FirebaseAuth firebaseAuth;

  Future<void> initlizeFirebaseApp() async {
    firebaseApp = await Firebase.initializeApp();
    // await database.openDb();
  }

  Future<Widget> checkUserLoggedIn() async {
    if (firebaseApp == null) {
      await initlizeFirebaseApp();
    }
    if (firebaseAuth == null) {
      firebaseAuth = FirebaseAuth.instance;
      update();
    }
    if (firebaseAuth.currentUser == null) {
      return LoginPage();
    } else {
      firebaseUser = firebaseAuth.currentUser;
      update();

      //TODO
    }
  }

  ////////////////////////////////////////////////////////////Auth with email////////////////////////
  Future<void> signInwithEmail(String emails, String passs) async {
    try {
      EasyLoading.show(status: 'loading...');
      firebaseAuth = FirebaseAuth.instance;

      final userCredentialData = await firebaseAuth.signInWithEmailAndPassword(
          email: emails, password: passs);
      firebaseUser = userCredentialData.user;

      update();
      Get.back();

      Get.offAll(HomeDrawer());
    } catch (ex) {
      print(ex.toString());
      Get.back();
      Get.snackbar('Sign In Error', 'Error Signing in with email and password',
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ));
    }
  }

  // Future<void> signInWithGoogle() async {
  //   try {
  //     Get.dialog(Center(child: LoadingWidget()), barrierDismissible: false);

  //     // await initlizeFirebaseApp();

  //     //  firebaseAuth = FirebaseAuth.instance;
  //     GoogleSignIn _googleSignIn = GoogleSignIn();
  //     final googleUser = await _googleSignIn.signIn();

  //     final googleAuth = await googleUser.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     final userCredentialData =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     firebaseUser = userCredentialData.user;
  //     update();
  //     Get.back();
  //     Get.to(HomeDrawer());
  //   } catch (ex) {
  //     Get.back();
  //     Get.snackbar('Sign In Error', 'Error Google Signing in' + ex.toString(),
  //         duration: Duration(seconds: 5),
  //         backgroundColor: Colors.black,
  //         colorText: Colors.white,
  //         snackPosition: SnackPosition.BOTTOM,
  //         icon: Icon(
  //           Icons.error,
  //           color: Colors.red,
  //         ));
  //   }
  // }

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   //   try {
  //   final AccessToken result = await FacebookAuth.instance.login();

  //   // Create a credential from the access token
  //   //final FacebookAuthCredential facebookAuthCredential =
  //   //  FacebookAuthProvider.credential(result.token);

  //   // Once signed in, return the UserCredential
  //   update();
  //   Get.back();
  //   // return await FirebaseAuth.instance
  //   //     .signInWithCredential(facebookAuthCredential);
  //   // } catch (erf) {
  //   //   update();
  //   //   Get.back();
  //   //   Get.snackbar('Sign In Error', erf.toString(),
  //   //       duration: Duration(seconds: 5),
  //   //       backgroundColor: Colors.black,
  //   //       colorText: Colors.white,
  //   //       snackPosition: SnackPosition.BOTTOM,
  //   //       icon: Icon(Icons.error, color: Colors.red));
  //   //   return null;
  //   // }
  // }

  Future<void> sendpasswordresetemail1(String email) async {
    firebaseAuth = FirebaseAuth.instance;
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        Get.offAll(LoginPage());
        Get.snackbar("Password Reset email link is been sent", "Success");
      }).catchError(
          (onError) => Get.snackbar("Error In Email Reset", onError.message));
    } catch (e) {
      print("Error is: " + e.toString());
    }
  }

  // function to createuser, login and sign out user

  Future<void> createUser(String name, String email, String password) async {
    firebaseAuth = FirebaseAuth.instance;

    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        //TODO
      }).catchError(
        (onError) =>
            Get.snackbar("Error while creating account ", onError.message),
      );
      update();
    } catch (err) {
      Get.back();
      Get.snackbar("Error:  ", err.message);
    }
  }

///////////////////////////////////////////////////////// delete Account////////////////////////////
  void deleteuseraccount(String email, String pass) async {
    User user = firebaseAuth.currentUser;

    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pass);

    await user.reauthenticateWithCredential(credential).then((value) {
      value.user.delete().then((res) {
        Get.offAll(LoginPage());
        Get.snackbar("User Account Deleted ", "Success");
      });
    }).catchError((onError) => Get.snackbar("Credential Error", "Failed"));
  }

  Future<void> signOut() async {
    EasyLoading.show(status: 'loading...');
    await firebaseAuth.signOut();
    update();
    Get.back();
    // Navigate to Login again
    Get.offAll(LoginPage());
  }
}
