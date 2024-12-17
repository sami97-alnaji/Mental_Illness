import 'package:flutter/material.dart';

class PatientProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بروفايل المريض'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('اسم المريض: سارة علي', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('العمر: 30', style: TextStyle(fontSize: 18)),
            // أضف المزيد من المعلومات هنا
          ],
        ),
      ),
    );
  }
}
