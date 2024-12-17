import 'package:flutter/material.dart';


class test22 extends StatefulWidget {
  @override
  _test2State createState() => _test2State();
}

class _test2State extends State<test22> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مقياس الغضب كسمة وكحالة',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: AngerScaleTest(
        isDarkMode: _isDarkMode,
        onThemeChanged: (bool value) {
          setState(() {
            _isDarkMode = value;
          });
        },
      ),
    );
  }
}

class AngerScaleTest extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  AngerScaleTest({required this.isDarkMode, required this.onThemeChanged});

  @override
  _AngerScaleTestState createState() => _AngerScaleTestState();
}

class _AngerScaleTestState extends State<AngerScaleTest> {
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

    //int totalScore = responses.where((r) => r != null).cast<int>().fold(0, (sum, value) =>

int totalScore = responses.where((r) => r != null).cast<int>().fold(0, (sum, value) => sum + value);

    String result;
    if (totalScore <= 9) {
      result = "يبدوا انك تتحكم بغضبك بشكل جيد ولا تعاني من السرعة في الغضب ";
    } else if (totalScore <= 15) {
      result = "يبدوا انك تتحكم بغضبك بشكل جيد الى حد ما  ";
    } else if (totalScore <= 23) {
      result = "يبدوا انك تتمتلك الحد الطبيعي للغضب  ";
    } else if (totalScore <= 30) {
      result = "يبدوا انك تتمتلك أعلى من الحد الطبيعي للغضب  ";
    }else {
      result = "يبدوا انك لا تتحكم بغضبك بشكل جيد و تعاني من السرعة في الغضب ";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('نتيجة الاختبار'),
          content: Text('درجة التحكم بالغضب: $totalScore\nالحالة: $result'),
          actions: [
            TextButton(
              child: Text('موافق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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