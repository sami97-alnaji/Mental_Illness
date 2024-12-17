import 'package:flutter/material.dart';

class test101 extends StatefulWidget {
  @override
  _HopelessnessTestAppState createState() => _HopelessnessTestAppState();
}

class _HopelessnessTestAppState extends State<test101> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار مقياس اليأس',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HopelessnessTest(
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

class HopelessnessTest extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final Function(int) onTestCompleted;

  HopelessnessTest({required this.isDarkMode, required this.onThemeChanged, required this.onTestCompleted});

  @override
  _HopelessnessTestState createState() => _HopelessnessTestState();
}

class _HopelessnessTestState extends State<HopelessnessTest> {
  int currentPage = 0;
  final int questionsPerPage = 7;

  List<Map<String, dynamic>> questions = [
    {'question': 'أتطلع إلى المستقبل بأمل وحماس.', 'options': ['نعم', 'لا'], 'scores': [0, 1]},
    {'question': 'يمكنني أن أقر بعجزي لأنني لم أستطيع تحقيق الأفضل بالنسبة لنفسي.', 'options': ['نعم', 'لا'], 'scores': [1, 0]},
    {'question': 'عندما تسوء الأمور، فإنه تساعدني معرفتي بأن الأمور لن تدوم كذلك إلى الأبد.', 'options': ['نعم', 'لا'], 'scores': [0, 1]},
    {'question': 'لا أستطيع أن أتخيل ماذا ستكون عليه حياتي بعد عشر سنوات.', 'options': ['نعم', 'لا'], 'scores': [1, 0]},
    {'question': 'لدي الوقت الكافي لانجاز الأشياء التي تشتد رغبتي في القيام بها.', 'options': ['نعم', 'لا'], 'scores': [0, 1]},
    {'question': 'في المستقبل، أتوقع أن أنجح فيها هو أكثر أهمية بالنسبة لي.', 'options': ['نعم', 'لا'], 'scores': [0, 1]},
    {'question': 'يبدو أن المستقبل مظلم بالنسبة لي.', 'options': ['نعم', 'لا'], 'scores': [1, 0]},
    {'question': 'أتوقع أن أحمل من الأشياء الجيدة في الحياة قدرا أكبر مما ينال الشخص العادي.', 'options': ['نعم', 'لا'], 'scores': [0, 1]},
    {'question': 'لم يكن لي حظ سعيد، وليس هناك سبب يدعو للاعتقاد بأنني سأحصل عليه في المستقبل.', 'options': ['نعم', 'لا'], 'scores': [1, 0]},
    {'question': 'أن خبراتي الماضية قد أعدتني إعدادا جيدا للمستقبل.', 'options': ['نعم', 'لا'], 'scores': [0, 1]},
    {'question': 'كل ما أستطيع رؤيته أمامي، هو أمور سيئة أكثر مما هي سارة.', 'options': ['نعم', 'لا'], 'scores': [1, 0]},
    {'question': 'لا أتوقع أن أحصل على ما أريده حقيقة.', 'options': ['نعم', 'لا'], 'scores': [1, 0]},
    {'question': 'عندما أتطلع إلى المستقبل، أتوقع أنني سوف أكون أسعد مما أنا عليه الآن.', 'options': ['نعم', 'لا'], 'scores': [0, 1]},
    {'question': 'لن تحدث الأمور في المستقبل بالطريقة التي أودها.', 'options': ['نعم', 'لا'], 'scores': [1, 0]},
    {'question': 'لدي (عندي) ثقة كبيرة في المستقبل.', 'options': ['نعم', 'لا'], 'scores': [0, 1]},
    {'question': 'أنا لا أحصل أبدا على ما أريد، ولذلك فمن الحماقة أن أرغب في أي شيء.', 'options': ['نعم', 'لا'], 'scores': [1, 0]},
    {'question': 'من غير المتوقع أنني سأحقق أي إشباع حقيقي لرغباتي في المستقبل.', 'options': ['نعم', 'لا'], 'scores': [1, 0]},
    {'question': 'يبدو لي المستقبل غامضا ومشكوكا فيه.', 'options': ['نعم', 'لا'], 'scores': [1, 0]},
    {'question': 'باستطاعتي أن أتوقع أن الأيام الهانئة ستكون أكثر من الأيام السيئة.', 'options': ['نعم', 'لا'], 'scores': [0, 1]},
    {'question': 'لا فائدة من المحاولة الجادة للحصول على شيء ما أريده، لأنني لن أتمكن من الحصول عليه في الغالب.', 'options': ['نعم', 'لا'], 'scores': [1, 0]},
  ];

  List<int?> responses = List.generate(20, (index) => null);

  void nextPage() {
    setState(() {
      if (currentPage < (questions.length / questionsPerPage).ceil() - 1) {
        currentPage++;
      }
    });
  }

  void prevPage() {
    setState(() {
      if (currentPage > 0) {
        currentPage--;
      }
    });
  }

  void calculateResult() {
    int totalScore = 0;
    int maxScore = questions.length; // أقصى مجموع ممكن للنقاط

    for (int i = 0; i < responses.length; i++) {
      if (responses[i] != null) {
        totalScore += (questions[i]['scores'][responses[i]!] as num).toInt();
      }
    }

    double percentageScore = (totalScore / maxScore) * 100;

    widget.onTestCompleted(totalScore.toInt()); // إرسال النتيجة إلى الصفحة السابقة
    Navigator.pop(context); // العودة إلى الصفحة السابقة
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (questions.length / questionsPerPage).ceil();
    int startIndex = currentPage * questionsPerPage;
    int endIndex = (startIndex + questionsPerPage).clamp(0, questions.length);

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text('اختبار مقياس اليأس'),
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
              'الصفحة ${currentPage + 1} من $totalPages',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 16.0),
            ...List.generate(
              endIndex - startIndex,
              (index) {
                int questionIndex = startIndex + index;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'سؤال ${questionIndex + 1}: ${questions[questionIndex]['question']}',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ...List.generate(
                        questions[questionIndex]['options'].length,
                        (optIndex) {
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  questions[questionIndex]['options'][optIndex],
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (currentPage > 0)
                  ElevatedButton(
                    onPressed: prevPage,
                    child: Text('السابق'),
                  ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: currentPage == totalPages - 1
                      ? calculateResult
                      : nextPage,
                  child: Text(currentPage == totalPages - 1 ? 'إرسال' : 'التالي'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
