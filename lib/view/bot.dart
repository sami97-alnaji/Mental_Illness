import 'package:flutter/material.dart';
import 'package:my_tests/view/8l8.dart';
import 'package:my_tests/view/e7ba6.dart';
import 'package:my_tests/view/nfs.dart';
import 'package:my_tests/view/ya2s.dart';
import '3udwanieh.dart';
import 'ghdb.dart';
import 'ekt2ab.dart';
import '8l8.dart';
import 'w7deh.dart';
import 'ya2s.dart';
class TestsPage extends StatelessWidget {
  final List<TestItem> tests = [
    TestItem(name: "مقياس القلق", color: Colors.brown, icon: Icons.psychology),
    TestItem(name: "مقياس الاكتئاب", color: Colors.purple, icon: Icons.heart_broken),
    TestItem(name: "مقياس العدوانية", color: Colors.red, icon: Icons.warning),
    TestItem(name: "مقياس الغضب", color: Colors.orange, icon: Icons.sentiment_very_dissatisfied),
    TestItem(name: "مقياس تقدير النفس", color: Colors.green, icon: Icons.star),
    TestItem(name: "مقياس الوحدة", color: Colors.blue, icon: Icons.sentiment_satisfied),
    TestItem(name: "مقياس الإحباط", color: Colors.teal, icon: Icons.sentiment_dissatisfied),
   // TestItem(name: "مقياس الخوف الاجتماعي", color: Colors.cyan, icon: Icons.group),
   // TestItem(name: "مقياس إدمان الإنترنت", color: Colors.deepPurple, icon: Icons.computer),
    TestItem(name: "مقياس اليأس", color: Colors.indigo, icon: Icons.people),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("مقاييس الصحة النفسية"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // عدد الأعمدة
            mainAxisSpacing: 10, // المسافة العمودية بين العناصر
            crossAxisSpacing: 10, // المسافة الأفقية بين العناصر
            childAspectRatio: 3 / 2, // النسبة بين العرض والطول
          ),
          itemCount: tests.length,
          itemBuilder: (context, index) {
            final test = tests[index];
            return GestureDetector(
              onTap: () {
                // الانتقال إلى صفحة الاختبار الخاصة بالعدوانية
                if (test.name == "مقياس العدوانية") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Aggression(),
                    ),
                  );
                }             else if (test.name == "مقياس الوحدة") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => test77(),
                    ),
                  );
                }   else if (test.name == "مقياس الغضب") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => test22(),
                    ),
                  );
                }   else if (test.name == "مقياس القلق") {
                  Navigator.push(//بدون نتيجة
                    context,
                    MaterialPageRoute(
                      builder: (context) => test66(),
                    ),
                  );
                }   else if (test.name == "مقياس تقدير النفس") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => test55(),
                    ),
                  );
                } else if (test.name == "مقياس الإحباط") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => test88(),
                    ),
                  );
                }   else if (test.name == "مقياس اليأس") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => test101(),
                    ),
                  );
                }  else if (test.name == "مقياس الاكتئاب") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => test22(),
                    ),
                  );
                }else {
                  // انتقل إلى صفحة الاختبار الأخرى (بإمكانك تعديلها)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestDetailPage(testName: test.name),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: test.color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(test.icon, size: 40, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      test.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "الأقسام"),
          BottomNavigationBarItem(icon: Icon(Icons.support_agent), label: "استشارة"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "الحساب"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "الإعدادات"),
        ],
        currentIndex: 0, // حدد الصفحة الحالية
        onTap: (index) {
          // التحكم في التنقل السفلي
        },
      ),
    );
  }
}

class TestItem {
  final String name;
  final Color color;
  final IconData icon;

  TestItem({required this.name, required this.color, required this.icon});
}

class TestDetailPage extends StatelessWidget {
  final String testName;

  const TestDetailPage({required this.testName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(testName),
      ),
      body: Center(
        child: Text(
          "هنا سيكون محتوى الاختبار الخاص بـ $testName",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// صفحة اختبار العدوانية
class AnxietyTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("اختبار القلق")),
      body: Center(child: Text("هنا سيكون اختبار القلق", style: TextStyle(fontSize: 18))),
    );
  }
}

class DepressionTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("اختبار الاكتئاب")),
      body: Center(child: Text("هنا سيكون اختبار الاكتئاب", style: TextStyle(fontSize: 18))),
    );
  }
}

class AggressionTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("اختبار العدوانية")),
      body: Center(child: Text("هنا سيكون اختبار العدوانية", style: TextStyle(fontSize: 18))),
    );
  }
}

// أضف بقية صفحات الاختبارات بنفس الطريقة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اختبار العدوانية"),
      ),
      body: Center(
        child: Text(
          "هنا سيكون اختبار العدوانية",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

