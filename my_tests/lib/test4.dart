import 'package:flutter/material.dart';

class test4 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<test4> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار مقياس بيك للاكتئاب',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: BeckDepressionTest(
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

class BeckDepressionTest extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final Function(int) onTestCompleted;

  BeckDepressionTest({required this.isDarkMode, required this.onThemeChanged, required this.onTestCompleted});

  @override
  _BeckDepressionTestState createState() => _BeckDepressionTestState();
}

class _BeckDepressionTestState extends State<BeckDepressionTest> {
  int currentPage = 0;
  List<Map<String, dynamic>> questions =[
    {'question': 'أشعر بالحزن', 'options': ['لا أشعر بالحزن.', 'أشعر بالحزن في بعض الأحيان.', 'أشعر بالحزن طيلة الوقت ولا أستطيع التخلص من هذا الشعور.', 'أشعر بالحزن والتعاسة لدرجة لا أستطيع احتمالها.']},
    {'question': 'أشعر بأن حياتي بلا معنى:', 'options': ['لا أشعر بذلك.', 'أشعر بذلك أحيانًا.', 'أشعر بذلك غالبًا.', 'أشعر بذلك دائمًا.']},
    {'question': 'لا أستطيع النوم جيدًا:', 'options': ['لا أواجه أي مشكلة في النوم.', 'أواجه مشكلة بسيطة في النوم.', 'أواجه مشكلة كبيرة في النوم.', 'لا أستطيع النوم نهائيًا.']},
    {'question': 'أواجه صعوبة في الاستيقاظ من النوم:', 'options': ['لا أواجه أي مشكلة.', 'أواجه صعوبة خفيفة.', 'أواجه صعوبة كبيرة.', 'لا أستطيع الاستيقاظ من النوم.']},
    {'question': 'أجد صعوبة في الاستمتاع بالأشياء التي كنت أستمتع بها:', 'options': ['لا أجد أي صعوبة.', 'أجد صعوبة خفيفة.', 'أجد صعوبة كبيرة.', 'لا أستطيع الاستمتاع بأي شيء.']},
    {'question': 'أعتقد أنني فاشل أو غير جدير بالثقة:', 'options': ['لا أعتقد ذلك.', 'أعتقد ذلك أحيانًا.', 'أعتقد ذلك غالبًا.', 'أعتقد ذلك دائمًا.']},
    {'question': 'أشعر بالإرهاق الجسدي أو الذهني:', 'options': ['لا أشعر بالإرهاق.', 'أشعر بالإرهاق أحيانًا.', 'أشعر بالإرهاق غالبًا.', 'أشعر بالإرهاق دائمًا.']},
    {'question': 'لدي صعوبة في التركيز على الأمور:', 'options': ['لا أواجه أي صعوبة.', 'أواجه صعوبة خفيفة.', 'أواجه صعوبة كبيرة.', 'لا أستطيع التركيز على أي شيء.']},
    {'question': 'أشعر بعدم الأمل في المستقبل:', 'options': ['لا أشعر بذلك.', 'أشعر بذلك أحيانًا.', 'أشعر بذلك غالبًا.', 'أشعر بذلك دائمًا.']},
    {'question': 'لدي رغبة أقل في التحدث إلى الآخرين:', 'options': ['لا أشعر بذلك.', 'أشعر بذلك أحيانًا.', 'أشعر بذلك غالبًا.', 'أشعر بذلك دائمًا.']},
    {'question': 'أشعر بالإحباط بشأن مظهري أو صحتي:', 'options': ['لا أشعر بالإحباط.', 'أشعر بالإحباط أحيانًا.', 'أشعر بالإحباط غالبًا.', 'أشعر بالإحباط دائمًا.']},
    {'question': 'أستجيب بسرعة للحزن أو الغضب:', 'options': ['لا أستجيب بسرعة.', 'أستجيب بسرعة أحيانًا.', 'أستجيب بسرعة غالبًا.', 'أستجيب بسرعة دائمًا.']},
    {'question': 'أواجه صعوبة في اتخاذ القرارات:', 'options': ['لا أواجه أي صعوبة.', 'أواجه صعوبة خفيفة.', 'أواجه صعوبة كبيرة.', 'لا أستطيع اتخاذ أي قرارات.']},
    {'question': 'أشعر بالقلق من فقدان السيطرة على حياتي:', 'options': ['لا أشعر بالقلق.', 'أشعر بالقلق أحيانًا.', 'أشعر بالقلق غالبًا.', 'أشعر بالقلق دائمًا.']},
    {'question': 'أشعر بعدم الرغبة في المشاركة في الأنشطة الاجتماعية:', 'options': ['لا أشعر بذلك.', 'أشعر بذلك أحيانًا.', 'أشعر بذلك غالبًا.', 'أشعر بذلك دائمًا.']},
    {'question': 'أجد صعوبة في الاسترخاء:', 'options': ['لا أجد أي صعوبة.', 'أجد صعوبة خفيفة.', 'أجد صعوبة كبيرة.', 'لا أستطيع الاسترخاء.']},
    {'question': 'أشعر بأنني عبء على الآخرين:', 'options': ['لا أشعر بذلك.', 'أشعر بذلك أحيانًا.', 'أشعر بذلك غالبًا.', 'أشعر بذلك دائمًا.']},
    {'question': 'أستمر في التفكير في الماضي بشكل مفرط:', 'options': ['لا أستمر في التفكير.', 'أفكر في الماضي أحيانًا.', 'أفكر في الماضي غالبًا.', 'أفكر في الماضي دائمًا.']},
    {'question': 'أشعر بالذنب بسبب أشياء لم أقم بها بشكل جيد:', 'options': ['لا أشعر بالذنب.', 'أشعر بالذنب أحيانًا.', 'أشعر بالذنب غالبًا.', 'أشعر بالذنب دائمًا.']},
    {'question': 'أجد صعوبة في مواجهة التحديات:', 'options': ['لا أجد صعوبة.', 'أجد صعوبة خفيفة.', 'أجد صعوبة كبيرة.', 'لا أستطيع مواجهة أي تحديات.']},
    {'question': 'أفكر في الانتحار:', 'options': ['لا أفكر في الانتحار.', 'أفكر في الانتحار أحيانًا.', 'أفكر في الانتحار كثيرًا.', 'أفكر في الانتحار دائمًا.']},
  ];

  List<int?> responses = List.generate(21, (index) => null);
  List<List<Map<String, dynamic>>> pagedQuestions = [];

  @override
  void initState() {
    super.initState();
    final int questionsPerPage = ((questions.length / 3).ceil());
    pagedQuestions = List.generate(
      3,
      (pageIndex) => questions.sublist(
        pageIndex * questionsPerPage,
        (pageIndex + 1) * questionsPerPage.clamp(0, questions.length),
      ),
    );
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
    if (totalScore <= 9) {
      result = "غير مكتئب";
    } else if (totalScore <= 15) {
      result = "اكتئاب ضعيف";
    } else if (totalScore <= 23) {
      result = "اكتئاب متوسط";
    } else {
      result = "اكتئاب شديد";
    }

    widget.onTestCompleted(totalScore);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentQuestions = pagedQuestions[currentPage];
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text('اختبار مقياس بيك للاكتئاب'),
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
                        'سؤال ${questionIndex + 1}: ${currentQuestions[index]['question']}',
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (currentPage > 0)
                  ElevatedButton(
                    onPressed: prevPage,
                    child: Text('السابق'),
                  ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: currentPage == pagedQuestions.length - 1
                      ? calculateResult
                      : nextPage,
                  child: Text(currentPage == pagedQuestions.length - 1 ? 'إرسال' : 'التالي'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
