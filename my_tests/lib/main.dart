import 'package:flutter/material.dart';
import 'test1.dart';
import 'test2.dart';
import 'test3.dart';
import 'test4.dart';
import 'test5.dart';
import 'test6.dart';
import 'test7.dart';
import 'test8.dart';
import 'test9.dart';
import 'test10.dart';
import 'test11.dart';
import 'test12.dart';
import 'test13.dart';
import 'test14.dart';
import 'test15.dart';
import 'chat.dart'; // استيراد ملف الدردشة
import 'profile.dart';
import 'doctor_profile.dart';
import 'patient_profile.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  List<String> suggestedTests = [];
  Map<String, List<String>> keywordsMap = {
    'test1': ['عدواني', 'عدائي', 'شرس', 'همجي', 'عنيف', 'متوحش', 'قاس', 'فظ', 'ضار', 'متسلط', 'جائر'],
    'test2': ['غضب', 'عدوانية', 'انفعالي', 'غيظ', 'هيجان', 'زعل', 'تذمر', 'انزعاج', 'توتر', 'عصبية'],
    'test3': ['غضب', 'عدوانية', 'انفعالي', 'غيظ', 'هيجان', 'زعل', 'تذمر', 'انزعاج', 'توتر', 'عصبية'],
    'test4': ['اكتئاب', 'حزن', 'قلق', 'احباط', 'كآبة', 'يأس', 'ضيق', 'إنكسار', 'تبلد', 'شجن', 'غم'],
    'test5': ['ذاتي', 'نفسي', 'تقدير', 'الثقة بالنفس', 'ثقة', 'قوة الشخصية', 'إحترام الذات', 'حب الذات', 'الوعي الذاتي', 'التقدير الذاتي', 'فخر', 'اعتزاز'],
    'test6': ['قلق', 'أقلق', 'توتر', 'اضطراب', 'خوف', 'هواجس', 'انزعاج', 'توجس', 'ارتياب', 'شك', 'عصبية', 'حيرة'],
    'test7': ['وحدة', 'لوحدي', 'لحالي', 'عزلة', 'اغتراب', 'انطواء', 'شعور بالفراغ', 'انفراد', 'انقطاع اجتماعي', 'ابتعاد عاطفي', 'وحشة'],
    'test8': ['احباط', 'محبط', 'إحباط', 'يأس', 'خيبة امل', 'كبت', 'تثبيط', 'خذلان', 'انكسار', 'إحباط نفسي', 'إنزعاج', 'فشل'],
    'test9': ['خوف اجتماعي', 'قلق اجتماعي', 'رهبة اجتماعية', 'توتر اجتماعي', 'اضطراب اجتماعي', 'خجل مفرط', 'انزعاج اجتماعي', 'عدم ارتياح اجتماعي', 'انطواء اجتماعي', 'حساسية مفرطة', 'تجنب المواقف الاجتماعية', 'حذر اجتماعي'],
    'test10': ['إحباط', 'يأس', 'تعب', 'قنوط', 'إحساس بعدم الجدوى', 'شعور بالعجز', 'فشل', 'حزن عميق', 'عدم التفاؤل', 'انخفاض في النشاط'],
    'test11': ['إدمان إنترنت', 'كثرة جلوس على الإنترنت', 'الإفراط في استخدام الإنترنت', 'تأثير سلبي على العلاقات الاجتماعية', 'اهتمام زائد بالإنترنت'],
    'test12': ['خجل', 'تردد', 'توتر اجتماعي', 'قلق اجتماعي', 'عدم ارتياح', 'انطواء', 'حساسية مفرطة', 'خوف من التقييم', 'تجنب التفاعلات الاجتماعية', 'قلق عند التواصل', 'عدم الراحة في المواقف الاجتماعية'],
    'test13': ['مسؤولية كبيرة', 'ضغوط نفسية', 'عبء إضافي', 'قلق دائم', 'توتر مستمر', 'تضحية', 'تعب عاطفي', 'إرهاق نفسي', 'تحديات يومية', 'خوف على المستقبل', 'شعور بالعجز'],
    'test14': ['رفض', 'تمرد', 'تحدي', 'مواجهة', 'عصيان', 'مخالفة', 'استقلالية مفرطة', 'تمسك بالرأي', 'تمسك بالأسلوب', 'إصرار', 'تحدي للسلطة', 'عدم الامتثال', 'ممانعة', 'تمرد ضد القواعد', 'عداء للسلطة', 'عدم احترام القوانين', 'مواجهة للضغوط', 'رفض للتوجيه', 'تشبث بالرأي الشخصي', 'عدم الاستجابة للأوامر'],
    'test15': ['نشيط للغاية', 'نشاط مفرط', 'تشتت الانتباه', 'صعوبة في التركيز', 'سلوك متهور', 'عدم الاستقرار', 'اندفاع', 'تململ', 'صعوبة في الجلوس لفترات طويلة', 'صعوبة في اتباع التعليمات', 'التصرفات غير المنتظمة', 'انفجارات عاطفية', 'عدم القدرة على إتمام المهام', 'سلوك غير متوقع', 'تبدلات مزاجية']
  };

  void analyzeText(String input) {
    final cleanedInput = cleanText(input);
    suggestTestsBasedOnPhrases(cleanedInput);
  }

  String cleanText(String text) {
    final pattern = RegExp(r'\b(ال|و|ب|في|على|من|الى)\b');
    return text.replaceAll(pattern, '').trim();
  }

  void suggestTestsBasedOnPhrases(String text) {
    setState(() {
      suggestedTests = [];
      for (var entry in keywordsMap.entries) {
        final testId = entry.key;
        final phrases = entry.value;
        for (var phrase in phrases) {
          if (text.contains(phrase)) {
            suggestedTests.add(testId);
            break;
          }
        }
      }
    });
  }

  void navigateToSuggestedTestsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuggestedTestsPage(suggestedTests: suggestedTests),
      ),
    );
  }

  void navigateToChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a2e),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'أدخل المشكلة التي تواجهها:',
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF1a1a2e),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (input) {
                  analyzeText(input);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'أدخل الكلمة المفتاحية',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: navigateToSuggestedTestsPage,
                child: Text('عرض الاختبارات المقترحة'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: navigateToChat,
                child: Text('الدردشة مع الطبيب'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SuggestedTestsPage extends StatefulWidget {
  final List<String> suggestedTests;

  SuggestedTestsPage({required this.suggestedTests});

  @override
  _SuggestedTestsPageState createState() => _SuggestedTestsPageState();
}

class _SuggestedTestsPageState extends State<SuggestedTestsPage> {
  Map<String, int> testResults = {};

  void navigateToTest(String testId) async {
  Widget page;

 switch (testId) {
  case 'test1':
    page = test1();
    break;
  case 'test2':
    page = test2();
    break;
  case 'test3':
    page = test3();
    break;
  case 'test4':
    page = test4();
    break;
  case 'test5':
    page = test5();
    break;
  case 'test6':
    page = test6();
    break;
  case 'test7':
    page = test7();
    break;
  case 'test8':
    page = test8();
    break;
  case 'test9':
    page = test9();
    break;
  case 'test10':
    page = test10();
    break;
  case 'test11':
    // Pass the testId parameter to test11 widget
    page = test11(testId: testId);
    break;
  case 'test12':
    // Pass the testId parameter to test12 widget
    page = test12(testId: testId);
    break;
    case 'test13':
    page = test13(); // إذا كان test13 لا يتطلب testId
    break;
  case 'test14':
    page = test14(); // إذا كان test14 لا يتطلب testId
    break;
  case 'test15':
    page = test15(testId: testId); // تمرير testId لـ test15
    break;
  default:
    return; // أو قم بتحديد صفحة افتراضية
}

  

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );

    if (result != null && result is int) {
      setState(() {
        testResults[testId] = result;
      });
    }
  }

  void showAllResults() {
    String allResults = '';

    for (String testId in widget.suggestedTests) {
      String resultDescription;

      if (testResults.containsKey(testId)) {
        int score = testResults[testId]!;

        // قم بتحديد وصف النتيجة بناءً على score
        switch (testId) {
          case 'test1':
            resultDescription = score > 18 ? 'شخص عدواني بشكل كبير' : 'شخص غير عدائي';
            break;
          case 'test2':
          case 'test3':
            resultDescription = score <= 9 ? 'قليل الغضب' : 'غضب عادي';
            break;
          // أضف المزيد من الحالات بناءً على الاختبارات الأخرى
          default:
            resultDescription = 'لا يوجد وصف متاح';
            break;
        }

        allResults += '$testId: $resultDescription\n';
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('نتائج جميع الاختبارات'),
          content: Text(allResults.isEmpty ? 'لا توجد نتائج' : allResults),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('الاختبارات المقترحة'),
    ),
    body: ListView(
      children: widget.suggestedTests.map((testId) {
        return ListTile(
          title: Text('اختبار $testId'),
          onTap: () => navigateToTest(testId),
        );
      }).toList(),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: showAllResults,
      child: Icon(Icons.show_chart),
      tooltip: 'عرض جميع النتائج',
    ),
    bottomNavigationBar: BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorProfile(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatientProfile(),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );

}}