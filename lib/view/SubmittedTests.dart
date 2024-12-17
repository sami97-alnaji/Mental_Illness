import 'package:flutter/material.dart';

class SubmittedTests {
  static List<Map<String, dynamic>> results = [];
}

class TestsOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحة الاختبارات'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: SubmittedTests.results.length,
                itemBuilder: (context, index) {
                  var testResult = SubmittedTests.results[index];
                  return ListTile(
                    title: Text('اختبار ${testResult['test']}'),
                    subtitle: Text('الدرجة: ${testResult['score']} - الحالة: ${testResult['result']}'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AllResultsPage(),
                  ),
                );
              },
              child: Text('عرض جميع النتائج'),
            ),
          ],
        ),
      ),
    );
  }
}

class AllResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نتائج جميع الاختبارات'),
      ),
      body: ListView.builder(
        itemCount: SubmittedTests.results.length,
        itemBuilder: (context, index) {
          var testResult = SubmittedTests.results[index];
          return ListTile(
            title: Text('اختبار ${testResult['test']}'),
            subtitle: Text('الدرجة: ${testResult['score']} - الحالة: ${testResult['result']}'),
          );
        },
      ),
    );
  }
}
