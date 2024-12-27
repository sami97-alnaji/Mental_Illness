import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpPatientPage extends StatefulWidget {
  const SignUpPatientPage({super.key});

  @override
  _SignUpPatientPageState createState() => _SignUpPatientPageState();
}

class _SignUpPatientPageState extends State<SignUpPatientPage> {
  bool _isDarkMode = false;
  bool _isPasswordVisible = false;
  bool _isCodeSent = false; // لتتبع حالة إرسال الكود
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _verificationCodeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up as Patient'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/profilePersonaly.png', // ضع صورة الترحيب هنا
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Patient Sign Up',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField('Name', TextInputType.name, false),
                  const SizedBox(height: 20),
                  _buildTextField('Email', TextInputType.emailAddress, false),
                  const SizedBox(height: 20),
                  _buildPhoneField(), // حقل رقم الهاتف
                  const SizedBox(height: 20),
                  _isCodeSent
                      ? _buildVerificationCodeField() // حقل إدخال كود التحقق
                      : Container(),
                  const SizedBox(height: 20),
                  _buildPasswordField('Password'),
                  const SizedBox(height: 20),
                  _buildPasswordField('Confirm Password'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Logic for sign up
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey, // لون زر التسجيل
                    ),
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
                        if (googleUser == null) {
                           null; // إذا تم إلغاء تسجيل الدخول
                        }

                        final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
                        final AuthCredential credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth.accessToken,
                          idToken: googleAuth.idToken,
                        );

                        final UserCredential userCredential = await _auth.signInWithCredential(credential);
                        user = userCredential.user;
                      } catch (e) {
                        print("Error: $e");

                      }
                    },
                    icon: const Icon(Icons.login, color: Colors.white),
                    label: const Text('Continue with Google'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // لون زر Google
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logic for Facebook Sign Up
                    },
                    icon: const Icon(Icons.facebook, color: Colors.white),
                    label: const Text('Continue with Facebook'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // لون زر Facebook
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // دالة لبناء حقل الإدخال
  Widget _buildTextField(String labelText, TextInputType inputType, bool obscureText) {
    return TextField(
      keyboardType: inputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  // دالة لبناء حقل كلمة المرور
  Widget _buildPasswordField(String labelText) {
    return TextField(
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
    );
  }

  // دالة لبناء حقل رقم الهاتف
  Widget _buildPhoneField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isCodeSent = true;
            });
            // Logic to send verification code
          },
          child: const Text('Send Code'),
        ),
      ],
    );
  }

  // دالة لبناء حقل كود التحقق
  Widget _buildVerificationCodeField() {
    return TextField(
      controller: _verificationCodeController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Verification Code',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
