import 'package:flutter/material.dart';
import 'ResetPasswordPage.dart';
class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key});

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  bool isDarkMode = true;
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF1a1a2e) : Color(0xFFF0F0F0),
      appBar: AppBar(
        title: Text(
          'Verify Code',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor: isDarkMode ? Color(0xFF1a1a2e) : Colors.white,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the verification code sent to your email',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 16, // زيادة حجم الخط
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Verification Code',
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.white24 : Colors.white,
              ),
            ),
            SizedBox(height: 20), // إضافة مسافة
            ElevatedButton(
              onPressed: () {
                // منطق للتحقق من الرمز المدخل
                String otpCode = _otpController.text;
                if (otpCode.isNotEmpty) {
                  // هنا يمكنك إضافة منطق للتحقق من الرمز
                  print('Verification code entered: $otpCode');
                  // الانتقال إلى صفحة إعادة تعيين كلمة المرور
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordPage(),
                    ),
                  );
                } else {
                  // إظهار رسالة خطأ في حالة عدم إدخال رمز
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter the verification code')),
                  );
                }
              },
              child: Text(
                'Verify',
                style: TextStyle(
                  color: isDarkMode ? Colors.black : Colors.white, // لون النص
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.white : Colors.blueGrey, // لون الزر
              ),
            ),
          ],
        ),
      ),
    );
  }
}
