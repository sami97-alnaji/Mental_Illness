import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_tests/view/auth_view/LoginPatientPage.dart';// تأكد من استيراد صفحة تسجيل الدخول
import 'package:firebase_auth/firebase_auth.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  bool isDarkMode = true;

  void toggleMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1A1A2E) : const Color.fromARGB(255, 239, 241, 168),
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1A1A2E) :  const Color.fromARGB(255, 239, 241, 168),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            color: isDarkMode ? Colors.white : Colors.black,
            onPressed: toggleMode,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/profilePersonaly.png', width: 200), // تأكد من وجود الصورة في مجلد assets
            const SizedBox(height: 25),
            Text(
              'Welcome to Your App',
              style: TextStyle(
                fontSize: 24,
                color: isDarkMode ? const Color.fromARGB(255, 230, 243, 163) : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'This is a brief description of what your app offers.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              child: Column(
                children: [

                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDB4437),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () async {

                      //TODO::  إضافة وظيفة هنا عند الضغط على زر Continue with Google
                      //     await _handleSignIn();
                          await _signInWithGoogle1();

                    },
                    child: const Text('Continue with Google'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B5998),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {

                      // إضافة وظيفة هنا عند الضغط على زر Continue with Facebook
                    },
                    child: const Text('Continue with Facebook'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPatientPage()), // تأكد من استيراد صفحة تسجيل الدخول
                );
              },
              child: const Text(
                'Already have an account? Log in',
                style: TextStyle(
                  color: Color(0xFFF2C94C),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        print('User Email: ${account.email}');
        // النجاح في تسجيل الدخول
      }
    } on PlatformException catch (error) {
      print('Platform Error: ${error.code}');
      print('Platform Error Details: ${error.details}');
    } catch (error) {
      print('General Error: $error');
    }
  }

  Future<void> _signInWithGoogle1() async {
    try {

      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',   // للوصول إلى البريد الإلكتروني
          'profile', // للوصول إلى بيانات الملف الشخصي مثل الاسم والصورة
        ],
      );

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        print('Signed in as: ${googleUser.email}');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to the next screen or perform other actions
      // For example:
      // Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      // Handle any errors during sign-in
      print('Failed with error code: ${e.code}');
      print(e.message);
      // You can display an error message to the user here
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: ['email', 'profile'],
        // Optional: Specify client ID if needed
        // clientId: 'your-client-id.apps.googleusercontent.com'
      ).signIn();

      if (googleUser == null) {
        print('Google Sign-In was canceled');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate or perform post-sign-in actions
    } catch (e) {
      print('Sign-In Error: $e');
      // Handle specific error scenarios
    }
  }

}
