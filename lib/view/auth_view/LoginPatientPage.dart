import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_tests/view/auth_view/ResetPasswordRequestPage.dart'; // استيراد صفحة إعادة تعيين كلمة المرور
import 'package:my_tests/view/auth_view/SignUpPatientPage.dart';
import '../../main.dart'; // استيراد صفحة المشاكل
// import 'main.dart'; // تأكد من عدم استيراد صفحة الترحيب إذا كنت لا تحتاجها

class LoginPatientPage extends StatefulWidget {
  const LoginPatientPage({super.key});

  @override
  _LoginPatientPageState createState() => _LoginPatientPageState();
}

class _LoginPatientPageState extends State<LoginPatientPage> {
  bool isDarkMode = true;
  bool obscurePassword = true;

  // تعريف المتحكمات
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xFF1a1a2e) : const Color(0xFFF0F0F0),
      appBar: AppBar(
        title: Text(
          'Login as Patient',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor:
            isDarkMode ? const Color(0xFF1a1a2e) : const Color(0xFFF0F0F0),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
            color: isDarkMode ? Colors.white : Colors.black, // لون الأيقونة
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset('assets/images/profilePersonaly.png',
                    width: 100),
              ),
              const SizedBox(height: 40),
              // حقل إدخال البريد الإلكتروني
              TextField(
                controller: _emailController, // ربط المتحكم بحقل الإدخال
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: isDarkMode ? Colors.white24 : Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              // حقل إدخال كلمة المرور
              TextField(
                controller: _passwordController, // ربط المتحكم بحقل الإدخال
                obscureText: obscurePassword,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: isDarkMode ? Colors.white24 : Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // الانتقال إلى صفحة إعادة تعيين كلمة المرور
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ResetPasswordRequestPage(), // تأكد من استيراد صفحة إعادة تعيين كلمة المرور
                      ),
                    );
                  },
                  child: Text(
                    'Forgot?',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // زر تسجيل الدخول
              ElevatedButton(
                onPressed: () {
                  // تحقق من صحة بيانات الدخول هنا
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  if (email.isNotEmpty && password.isNotEmpty) {
                    // هنا يمكنك إضافة منطق التحقق من البيانات، مثل الاتصال بقاعدة البيانات

                    // بعد التحقق، انتقل إلى صفحة المشاكل
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage()), // الانتقال إلى صفحة "المشاكل"
                    );
                  } else {
                    // يمكنك إظهار رسالة خطأ للمستخدم هنا
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please enter valid credentials')),
                    );
                  }
                },
                child: const Text('Log In'),
              ),
              const SizedBox(height: 10),
              // زر التسجيل باستخدام Google
              ElevatedButton.icon(
                onPressed: () async {
                  //TODO: Implement Google Sign In

                 await _signInWithGoogle();
                },
                icon: const Icon(Icons.login, color: Colors.white),
                label: const Text('Continue with Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // لون زر Google
                ),
              ),
              const SizedBox(height: 10),
              // زر التسجيل باستخدام Facebook
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.facebook, color: Colors.white),
                label: const Text('Continue with Facebook'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // لون زر Facebook
                ),
              ),
              const SizedBox(height: 10),
              // زر الانتقال إلى صفحة التسجيل
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SignUpPatientPage()), // تأكد من استيراد صفحة إنشاء الحساب
                  );
                },
                child: const Text(
                  "Don't have an account? Create now",
                  style: TextStyle(
                    color: Color(0xFFF2C94C),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: <String>[
  //     'safeyaali58@gmail.com',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );
  Future<void> _signInWithGoogle() async {
    print('Srates SignIN');
    try {
      const List<String> scopes = <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ];

      GoogleSignIn _googleSignIn = GoogleSignIn(
        // Optional clientId
        // clientId: 'your-client_id.apps.googleusercontent.com',
        scopes: scopes,
      );
      // بدء عملية مصادقة Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        // Process sign-in
        print("User signed in: ${googleUser.displayName}");
      }


      // الحصول على تفاصيل المصادقة من الطلب
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      print('googleAuh :;::: ${googleAuth?.idToken}');

      // إنشاء بيانات اعتماد جديدة
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // تسجيل الدخول باستخدام بيانات الاعتماد
      await FirebaseAuth.instance.signInWithCredential(credential);

      // الانتقال إلى الشاشة التالية أو تنفيذ إجراءات أخرى
      // على سبيل المثال:
      // Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      // معالجة أي أخطاء أثناء تسجيل الدخول
      print('فشل تسجيل الدخول مع رمز الخطأ: ${e.code}');
      print(e.message);
      // يمكنك عرض رسالة خطأ للمستخدم هنا
    }
    print('object');
  }
}
