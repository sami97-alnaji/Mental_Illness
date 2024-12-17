import 'package:flutter/material.dart';

class DoctorProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بروفايل الطبيب'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('اسم الطبيب: د. أحمد محمد', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('تخصص: الطب النفسي', style: TextStyle(fontSize: 18)),
            // أضف المزيد من المعلومات هنا
          ],
        ),
      ),
    );
  }
}
