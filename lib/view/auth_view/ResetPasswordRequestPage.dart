import 'package:flutter/material.dart';
import 'package:my_tests/view/auth_view/OTPVerificationPage.dart';

class ResetPasswordRequestPage extends StatefulWidget {
  const ResetPasswordRequestPage({super.key});

  @override
  _ResetPasswordRequestPageState createState() => _ResetPasswordRequestPageState();
}

class _ResetPasswordRequestPageState extends State<ResetPasswordRequestPage> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1a1a2e) : const Color(0xFFF0F0F0),
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor: isDarkMode ? const Color(0xFF1a1a2e) : Colors.white,
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
              'Enter your email to receive a password reset link',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 16, // زيادة حجم الخط
              ),
            ),
            const SizedBox(height: 20),
            TextField(
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OTPVerificationPage(),
                  ),
                );
              },
              child: const Text('Send Code'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey, // لون الزر
              ),
            ),
          ],
        ),
      ),
    );
  }
}
