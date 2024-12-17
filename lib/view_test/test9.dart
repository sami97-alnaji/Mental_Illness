import 'package:flutter/material.dart';

void main() => runApp(test9());

class test9 extends StatefulWidget {
  @override
  _Test9PageState createState() => _Test9PageState();
}

class _Test9PageState extends State<test9> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مقياس القلق الاجتماعي',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: SocialAnxietyTestPage(
        isDarkMode: _isDarkMode,
        onThemeChanged: (bool value) {
          setState(() {
            _isDarkMode = value;
          });
        },
        onTestCompleted: (int testResult) {
          Navigator.pop(context, testResult); // إرسال النتيجة إلى الصفحة السابقة
        },
      ),
    );
  }
}

class SocialAnxietyTestPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final Function(int) onTestCompleted;

  SocialAnxietyTestPage({
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.onTestCompleted,
  });

  @override
  _SocialAnxietyTestPageState createState() => _SocialAnxietyTestPageState();
}

class _SocialAnxietyTestPageState extends State<SocialAnxietyTestPage> {
  int currentPage = 0;
  late List<Map<String, dynamic>> questions;
  late List<int?> responses;
  late List<List<Map<String, dynamic>>> pagedQuestions;
  @override
  void initState() {
    super.initState();

    // تعريف الأسئلة
    questions = [
      {'question': 'أكون عادة غير واثقا من نفسي ومتوتراً عند لقائي بآخرين', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'ألاحظ أني أفكر في أشياء، ليس لها علاقة بالموقف الذي أكون فيه', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أشعر دائماً بردود أفعال جسدي، كالحكة والألم والتعرق والغثيان (الشعور بالإقياء) مثلاً عندما أكون مع الآخرين', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أشعر وكأني مشلول عندما أفكر في لقاء علي القيام به مع أشخاص آخرين', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أكون متوتراً جداً قبل حدوث موقف اجتماعي ما', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أفكر في أشياء غير مهمة عندما أكون مع أشخاص آخرين', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'يخفق قلبي عندما أكون بين الآخرين في موقف اجتماعي ما', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'تشرد أفكاري دائماً أثناء مخالطتي للآخرين', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أكون متوتراً أثناء وجودي بين الآخرين', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'ألاحظ أنني أشعر بالخوف قبل حدوث موقف اجتماعي', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'يصبح العمل صعباً علي عندما أشعر أن أحدهم ينظر إلي (يراقبني) أثناء قيامي به', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'عندما أكون في حفلة ما أو بين مجموعة أشخاص فإني لا أصدق كيف تنتهي هذه الحفلة', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أكون عاجزاً عن النقاش إذا دار حديث ما ضمن مجموعة من الأفراد', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'كثرة الناس حولي تربكني', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أشعر بالصداع في أثناء وجودي في المواقف الاجتماعية المهمة', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'قبل أن أدخل في موقف اجتماعي أكون مهموماً من احتمال فشلي في هذا الموقف', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أصاب بالصداع قبل حدوث ملاقاة اجتماعية ما', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'غالباً ما أكون متردداً عندما أريد أن أسأل شخصاً ما عن أمر من الأمور كسؤال شخص ما عن شارع معين', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أحياناً أشعر بالدوار عندما أتجاذب الحديث مع الآخرين', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'غالباً ما تشرد أفكاري في المواقف الاجتماعية', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أشعر بالخجل عندما أتحدث مع شخص مهم', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أنزعج عندما ينظر إلي الناس في الشارع أو في الأماكن العامة', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'عندما أكون بين الآخرين فإني غالباً ما أظل في الخلفية (لا أشاركهم الحديث)', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أحتاج لوقت حتى أستطيع التغلب على خجلي في المواقف غير المألوفة بالنسبة لي', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'يصعب علي التعبير عن رأيي في نقاش مع أشخاص لا أعرفهم', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'يكون حلقي جافاً عندما أكون بين الآخرين', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'من الصعب علي أن أتحدث مع شخص لا أعرفه', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أعاني من قلق مرعب عندما أكون بين الناس', 'options': ['أبداً', 'أحياناً', 'دائماً']},
      {'question': 'أشعر بالضيق الشديد والارتباك عندما يكون علي الحديث أمام مجموعة من الأشخاص', 'options': ['أبداً', 'أحياناً', 'دائماً']},
    ];

    // تحديث الأسئلة وتقسيمها إلى صفحات
    updatePagedQuestions();

    // تهيئة responses بعد تقسيم الأسئلة
    responses = List.generate(questions.length, (index) => null);
  }


  void updatePagedQuestions() {
    final int questionsPerPage = (questions.length / 3).ceil();
    pagedQuestions = List.generate(
      ((questions.length / questionsPerPage).ceil()), 
      (pageIndex) => questions.sublist(
        pageIndex * questionsPerPage,
        (pageIndex + 1) * questionsPerPage < questions.length 
            ? (pageIndex + 1) * questionsPerPage 
            : questions.length,
      ),
    );

    // طباعة للمساعدة في تصحيح الأخطاء
    print('Paged Questions: $pagedQuestions');
  }

  void nextPage() {
    if (validatePage()) {
      setState(() {
        if (currentPage < pagedQuestions.length - 1) {
          currentPage++;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى الإجابة على جميع الأسئلة قبل الانتقال إلى الصفحة التالية.')),
      );
    }
  }

  void prevPage() {
    setState(() {
      if (currentPage > 0) {
        currentPage--;
      }
    });
  }

  bool validatePage() {
    List<Map<String, dynamic>> currentQuestions = pagedQuestions[currentPage];
    for (int i = 0; i < currentQuestions.length; i++) {
      int questionIndex = currentPage * ((questions.length / 3).ceil()) + i;
      if (responses[questionIndex] == null) {
        return false;
      }
    }
    return true;
  }

  void calculateResult() {
    if (responses.contains(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى الإجابة على جميع الأسئلة قبل إرسال النموذج.')),
      );
      return;
    }

    int totalScore = responses.where((r) => r != null).cast<int>().fold(0, (sum, value) => sum + value);

    String result;
    if (totalScore >= 29) {
      result = "مستوى عالي من القلق الاجتماعي";
    } else {
      result = "مستوى منخفض من القلق الاجتماعي";
    }

    widget.onTestCompleted(totalScore); // إرسال النتيجة عند الحساب
    Navigator.pop(context); // العودة إلى صفحة الاختبارات المقترحة
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentQuestions = pagedQuestions[currentPage];
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text('مقياس القلق الاجتماعي'),
        ),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.brightness_7 : Icons.brightness_2),
            onPressed: () {
              widget.onThemeChanged(!widget.isDarkMode);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'الصفحة ${currentPage + 1} من ${pagedQuestions.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 16.0),
            ...List.generate(
              currentQuestions.length,
              (index) {
                int questionIndex = currentPage * ((questions.length / 3).ceil()) + index;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'فقرة ${questionIndex + 1}: ${currentQuestions[index]['question']}',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ...List.generate(
                        currentQuestions[index]['options'].length,
                        (optIndex) {
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  currentQuestions[index]['options'][optIndex],
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Radio<int>(
                                value: optIndex,
                                groupValue: responses[questionIndex],
                                onChanged: (int? value) {
                                  setState(() {
                                    responses[questionIndex] = value;
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage > 0)
                  ElevatedButton(
                    onPressed: prevPage,
                    child: Text('الصفحة السابقة'),
                  ),
                if (currentPage < pagedQuestions.length - 1)
                  ElevatedButton(
                    onPressed: nextPage,
                    child: Text('الصفحة التالية'),
                  ),
                if (currentPage == pagedQuestions.length - 1)
                  ElevatedButton(
                    onPressed: calculateResult,
                    child: Text('عرض النتيجة'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
