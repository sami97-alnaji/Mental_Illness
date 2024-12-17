 import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_tests/view/Doctors.dart';
import 'package:my_tests/view/chat.dart';
import 'package:my_tests/view/doctorsdata.dart';
import 'package:my_tests/view/evaluation.dart';
import 'package:my_tests/view/splash_view/splash.dart';
import 'package:my_tests/view/welcomepage.dart';// تأكد من استيراد ملف صفحة تسجيل الدخول
// import 'view/profile.dart'; // تأكد من استيراد ملف Profile
//import 'welcome_page.dart'; // تأكد من استيراد ملف صفحة الترحيب
import 'view_test/test2.dart';
import 'view_test/test4.dart';
import 'view/bot.dart';
import 'package:flutter/material.dart';
import 'view_test/test1.dart';
import 'view_test/test2.dart';
import 'view_test/test3.dart';
import 'view_test/test4.dart';
import 'view_test/test5.dart';
import 'view_test/test6.dart';
import 'view_test/test7.dart';
import 'view_test/test8.dart';
import 'view_test/test9.dart';
import 'view_test/test10.dart';
import 'view_test/test11.dart';
import 'view_test/test12.dart';
import 'view_test/test13.dart';
import 'view_test/test14.dart';
import 'view_test/test15.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

// Ideal time to initialize
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///8C:B3:C2:C4:47:CC:F0:7E:3B:45:47:60:05:F5:FE:60:83:32:C6:B2
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      // Splash(),
      WelcomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
final List<Widget> _pages = [
  const MyHomePage(), // الصفحة الرئيسية
  const ChatScreen(), // محادثة المسنجر
  //SpecialistsPage(), // الأخصائيين
  evaluation(), // تتبع التقدم
];
void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
        if (index == 0) { // إذا كانت الصفحة "تتبع التقدم"
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        ),
      );
    }    if (index == 1) { // إذا كانت الصفحة "تتبع التقدم"
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        ),
      );
    }    if (index == 2) { // إذا كانت الصفحة "تتبع التقدم"
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TherapistList(),
        ),
      );
    }
    // Navigate to specific page based on the selected index
    if (index == 3) { // إذا كانت الصفحة "تتبع التقدم"
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestsPage(),
        ),
      );
    }
  }

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

    // إذا كانت القائمة تحتوي على أكثر من 5 اختبارات، قم بتقليصها إلى 5 فقط
    if (suggestedTests.length > 5) {
      suggestedTests = suggestedTests.sublist(0, 5);
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(20),
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
              const Text(
                'أدخل المشكلة التي تواجهها:',
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF1a1a2e),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (input) {
                  analyzeText(input);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'أدخل الكلمة المفتاحية',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: navigateToSuggestedTestsPage,
                child: const Text('عرض الاختبارات المقترحة'),
              ),
            ],
          ),
        ),
      ),



bottomNavigationBar: BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: _onItemTapped,
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home,color: _selectedIndex == 0 ? Colors.black : const Color.fromARGB(255, 69, 69, 74)),
      label: 'الأسئلة',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat,color: _selectedIndex == 1 ? Colors.black:  const Color.fromARGB(255, 69, 69, 74)),
      label: 'محادثة',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people,color: _selectedIndex == 2 ? Colors.black :  const Color.fromARGB(255, 69, 69, 74)),
      label: 'الأخصائيين',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.track_changes,color: _selectedIndex == 3 ? Colors.black : const Color.fromARGB(255, 69, 69, 74)),
      label: 'تتبع التقدم',
    ),
  ],
),


    );
  }
}

class SuggestedTestsPage extends StatefulWidget {
  final List<String> suggestedTests;

  SuggestedTestsPage({super.key, required this.suggestedTests});

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



    if (result != null && result is int) {
      setState(() {
        testResults[testId] = result;
      });
    }
  }
Doctor? getTopRatedDoctor(String specialization) {
  // قائمة الأطباء
  List<Doctor> doctors = [
    Doctor(name: "Dr. John Doe", specialization: "عدوانية", rating: 4.8),
    Doctor(name: "Dr. Jane Smith", specialization: "اكتئاب", rating: 4.5),
    Doctor(name: "Dr. Ahmed Ali", specialization: "قلق", rating: 4.9),
    // أضف باقي الأطباء هنا
  ];

  // فلترة الأطباء بناءً على التخصص وترتيبهم حسب التقييم
  List<Doctor> filteredDoctors = doctors
      .where((doctor) => doctor.specialization == specialization)
      .toList()
    ..sort((a, b) => b.rating.compareTo(a.rating));

  // إرجاع الطبيب الأعلى تقييمًا أو null إذا لم يتم العثور على طبيب
  return filteredDoctors.isNotEmpty ? filteredDoctors.first : null;
}

void showMostChronicResult() {
  String? mostChronicSpecialization; // لتخزين التخصص الأكثر أهمية
  int highestScore = 0; // لتخزين أعلى درجة

  // جلب النتائج من قائمة الاختبارات المقترحة
  for (String testId in widget.suggestedTests) {
    int score = getTestScore(testId); // جلب الدرجة للاختبار الحالي
    String specialization = testToSpecialization[testId]?.first ?? 'غير محدد';

    // مقارنة الدرجات لتحديد الحالة الأعلى
    if (score > highestScore) {
      highestScore = score;
      mostChronicSpecialization = specialization;
    }
  }

  if (mostChronicSpecialization != null) {
    // البحث عن الطبيب الأعلى تقييمًا للتخصص
    Doctor? doctor = getTopRatedDoctor(mostChronicSpecialization);

    if (doctor != null) {
      print(
          'الطبيب المقترح لحالتك المزمنة: ${doctor.name} , تقييمه: ${doctor.rating}');
    } else {
      print('يمكنك مراجعةصفحة الاطباء لايجاد الطبيب المناسب لك ');
    }
  } else {
    print('لم يتم العثور على حالات مزمنة بناءً على نتائج الاختبارات.');
  }
}

// دالة لجلب الدرجة من مصدر البيانات
int getTestScore(String testId) {
  // يمكنك تخصيص هذه الدالة لتجلب البيانات من قاعدة بيانات أو من كائن النتائج
  // مثال:
  return testResults[testId] ?? 0;
}


void showAllResults() {
  String allResults = '';
  Doctor? recommendedDoctor; // لتخزين الطبيب الموصى به

  for (String testId in widget.suggestedTests) {
    String resultDescription;
    String specialization = testToSpecialization[testId]?.first ?? 'غير محدد';

    // البحث عن الطبيب المناسب
    if (recommendedDoctor == null) {
      recommendedDoctor = getTopRatedDoctor(specialization);
    }

    if (testResults.containsKey(testId)) {
      int score = testResults[testId]!;
      String result = '';
      switch (testId) {
        case 'test1':
          if (score > 18) {
            resultDescription = 'شخص عدواني بشكل كبير';
          } else if (score < 18) {
            resultDescription = 'شخص غير عدائي';
          } else {
            resultDescription = 'شخص متوازن وغير عدائي';
          }
          break;
        case 'test2':
        case 'test3':
          if (score <= 9) {
            result = 'قليل الغضب';
          } else if (score <= 15) {
            result = 'تتحكم بغضبك بشكل كبير';
          } else if (score <= 23) {
            result = 'تمتلك الحد الطبيعي من الغضب';
          } else if (score <= 30) {
            result = 'لا تتحكم في غضبك';
          } else {
            result = 'غضبك يخرج عن السيطرة';
          }
          resultDescription = result;
          break;
        case 'test4':
          if (score <= 7) {
            resultDescription = 'اكتئاب خفيف';
          } else if (score <= 15) {
            resultDescription = 'اكتئاب معتدل';
          } else if (score <= 23) {
            resultDescription = 'اكتئاب شديد';
          } else {
            resultDescription = 'اكتئاب حاد';
          }
          break;
        case 'test5':
          resultDescription = score > 20 ? 'شخص يفتقر لتقدير الذات' : 'شخص ذو تقدير عالي للذات';
          break;
        case 'test6':
          resultDescription = score > 20 ? 'قلق عالي' : 'قلق منخفض';
          break;
        case 'test7':
          resultDescription = score > 20 ? 'شخص يشعر بالوحدة بشكل كبير' : 'شخص لا يشعر بالوحدة';
          break;
        case 'test8':
          resultDescription = score > 20 ? 'شخص يعاني من إحباط كبير' : 'شخص يعاني من إحباط خفيف';
          break;
        case 'test9':
          resultDescription = score > 20 ? 'مشاكل اجتماعية كبيرة' : 'مشاكل اجتماعية خفيفة';
          break;
        case 'test10':
          resultDescription = score > 20 ? 'شخص يعاني من إحباط شديد' : 'شخص يعاني من إحباط خفيف';
          break;
        case 'test11':
          if (score >= 21) {
            resultDescription = 'درجة مرتفعة من أعراض إدمان الانترنت والتي تستلزم تدخلاً إرشادياً لدى متخصصين في الإرشاد النفسي.';
          } else if (score >= 16) {
            resultDescription = 'درجة متوسطة من أعراض إدمان الانترنت، ويمكنك التغلب على تلك الأعراض ببعض السيطرة على النفس.';
          } else {
            resultDescription = 'لا تعاني من أعراض إدمان الانترنت.';
          }
          break;
        case 'test12':
          if (score <= 10) {
            resultDescription = 'خجل خفيف؛ قد تحتاج إلى تحسين مهارات التواصل الاجتماعي.';
          } else if (score <= 20) {
            resultDescription = 'خجل معتدل؛ قد تؤثر هذه المشاعر على تفاعلاتك الاجتماعية بشكل ملحوظ.';
          } else if (score <= 30) {
            resultDescription = 'خجل شديد؛ قد تحتاج إلى دعم نفسي لتخفيف هذا الخجل وتعزيز مهاراتك الاجتماعية.';
          } else {
            resultDescription = 'خجل مفرط؛ من المهم التحدث مع أخصائي لتحسين جودة حياتك الاجتماعية.';
          }
          break;
        case 'test13':
          if (score <= 48) {
            resultDescription = 'تواجه احتياجات قليلة لرعاية الطفل المعاق.';
          } else if (score <= 72) {
            resultDescription = 'تواجه احتياجات متوسطة لرعاية الطفل المعاق.';
          } else {
            resultDescription = 'تواجه احتياجات كبيرة لرعاية الطفل المعاق وتحتاج إلى دعم كبير.';
          }
          break;
        case 'test14':
          if (score < 27) {
            resultDescription = 'مستوى منخفض من التمرد؛ تفضل الانسجام والامتثال للقواعد.';
          } else if (score <= 68) {
            resultDescription = 'مستوى معتدل من التمرد؛ لديك ميل للمواجهة ولكنك لا تتجاوز الحدود بشكل متكرر.';
          } else if (score <= 108) {
            resultDescription = 'مستوى عالٍ من التمرد؛ تظهر الكثير من المعارضة والتحدي للسلطة والأنظمة.';
          } else {
            resultDescription = 'مستوى مرتفع جداً من التمرد؛ لديك ميول قوية لرفض القواعد والتحدي المستمر للسلطة.';
          }
          break;
        case 'test15':
          if (score >= 47) {
            resultDescription = 'النشاط الزائد عند الأطفال؛ قد تشير درجة النشاط الزائد إلى صعوبة في التركيز أو مشاكل سلوكية أخرى.';
          } else {
            resultDescription = 'النشاط الزائد ليس ملحوظاً بدرجة كبيرة.';
          }
          break;
        default:
          resultDescription = 'لا يوجد وصف متاح';
          break;
       }
      // إضافة النتيجة للوصف
      allResults += '$testId: $resultDescription\n';

      // تحديد الطبيب الموصى به بناءً على التخصص
      Doctor? doctor = getTopRatedDoctor(specialization);
      if (doctor != null && recommendedDoctor == null) {
        recommendedDoctor = doctor;
      }
    }
  }// إضافة توصية الطبيب إلى النتائج
  if (recommendedDoctor != null) {
    allResults +=
        '\nننصح بزيارة: ${recommendedDoctor.name} , تقييم: ${recommendedDoctor.rating})';
  } else if (allResults.isEmpty) {
    allResults = 'لا توجد نتائج لتحليلها.';
  } else {
    allResults += '\nلم يتم العثور على طبيب موصى به بناءً على النتائج.';
  }

  // عرض النتائج في مربع حوار
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('نتائج جميع الاختبارات'),
        content: Text(allResults),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('إغلاق'),
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
        title: const Text('الاختبارات المقترحة'),
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
        child: const Icon(Icons.show_chart),
        tooltip: 'عرض جميع النتائج',
      ),
    );
  }
}
class Doctor {
  final String name;
  final String specialization;
  final double rating;

  Doctor({
    required this.name,
    required this.specialization,
    required this.rating,
  });
}
