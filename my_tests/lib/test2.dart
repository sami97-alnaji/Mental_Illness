import 'package:flutter/material.dart';
class test2 extends StatefulWidget {
  @override
  _AggressionTestState createState() => _AggressionTestState();
}

class _AggressionTestState extends State<test2> {
  // إضافة المتغير result هنا
  int result = 0; // افترض أن هذه هي النتيجة المحسوبة.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار الغضب',
      theme: ThemeData.light(),
      home: AggressionTestPage(
        onTestCompleted: (int testResult) {
          Navigator.pop(context, testResult); // إرسال النتيجة إلى الصفحة السابقة
        },
      ),
    );
  }
}

class AggressionTestPage extends StatefulWidget {
  final Function(int) onTestCompleted;

  AggressionTestPage({required this.onTestCompleted});

  @override
  _AggressionTestPageState createState() => _AggressionTestPageState();
}

class _AggressionTestPageState extends State<AggressionTestPage> {
  int currentPage = 0;

  List<Map<String, dynamic>> questions = [
    {'question': 'أنا عصبي', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'أشعر بالغضب', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'احترق بالغيظ', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'أشعر وكأن أحد أثارني أو هيجني', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'أشعر بالإحباط', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'أشعر وكأن أحد أغضبني', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'أشعر كما لو كنت على وشك الانفجار', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'أشعر بحاجة الى الضرب على منضدة بعنف', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'أشعر بالرغبة في الصراخ في وجه شخص ما', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'أشعر بالرغبة في السب أو الشتم', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'أشعر كما لو كنت صاحبت أو هاجمت', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'أشعر بالرغبة في ضرب شخص ما', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'أشعر بالرغبة في تكسير الأشياء', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'أشعر بالضيق', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
    {'question': 'أشعر أنني سريع الاشتعال', 'options': ['إطلاقًا', 'أحيانًا', 'بدرجة معتدلة', 'كثيرًا']},
  ];

  List<int?> responses = List.generate(15, (index) => null);
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

  // احسب النتيجة بشكل عددي
  int result;
  if (totalScore <= 9) {
    result = 1; // منخفض
  } else if (totalScore <= 15) {
    result = 2; // معتدل
  } else if (totalScore <= 23) {
    result = 3; // طبيعي
  } else if (totalScore <= 30) {
    result = 4; // فوق الطبيعي
  } else {
    result = 5; // عالي
  }

  widget.onTestCompleted(result);
  Navigator.of(context).pop();
}


  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentQuestions = pagedQuestions[currentPage];
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text('اختبار مقياس الغضب كحالة  '),
        ),
        actions: [

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
