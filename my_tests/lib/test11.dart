import 'package:flutter/material.dart';

class test11 extends StatefulWidget {
  final String testId; // إضافة معامل testId

  test11({required this.testId}); // التعديل في الكائن

  @override
  _Test11State createState() => _Test11State();
}

class _Test11State extends State<test11> {
  int currentPage = 0;
  final int questionsPerPage = 7;
  bool _isDarkMode = false;

  List<Map<String, dynamic>> questions = [
    {'question': 'أجلس أمام الانترنت لفترات طويلة في اليوم الواحد تصل إلى عشر ساعات أو أكثر', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'أشعر أن علاقاتي الاجتماعية مع أصحابي ومعارفي أصبحت ضعيفة.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'أعتقد أني مدمن انترنت ... أقاربي وأصدقائي يقولون ذلك عنى.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'التفكير في الانترنت قليلا ما يفارق خيالي حين أتواجد في عملي أو بين أصحابي وأهلي.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'يصيبني الإجهاد والتعب في يدي أو في ظهري من كثرة الجلوس أمام الكمبيوتر.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'أشعر بالرغبة في الحديث عن مغامراتي في الانترنت مع معارفي وأصدقائي.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'تتملكني الرغبة حين أغلق الكمبيوتر بالعودة إليه بعد قليل.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'أشعر أني أجد احتراما واهتماما على شبكة الانترنت أكثر مما في غيره.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'جلوسي على الانترنت يؤخرني دوما عن مواعيد الغداء والعشاء أو لقيا الأصحاب أو النوم.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'غلق جهاز الكمبيوتر هو ما افعله قبل النوم، وفتح الجهاز هو أول شيء أفعله بعد الاستيقاظ.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'أشعر من كثرة جلوسي أمام الكمبيوتر أن حياتي المهنية الاستذكار بالنسبة للطلاب متعثرة.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'أستمر في الجلوس أمام الانترنت حتى لو شعرت ببعض التعب، أو النعاس.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'أشعر بالندم حين أجلس لفترات طويلة أمام الانترنت.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'جلوسي طويلا أمام الانترنت أصابني بالكسل.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
    {'question': 'ينتابني ضيق شديد عند انقطاع النت عنى لسبب ما من الأسباب.', 'options': ['نعم', 'أحياناً', 'لا'], 'scores': [2, 1, 0]},
  ];

  List<int?> responses = List.generate(15, (index) => null);

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
    int maxScore = questions.length * 2; // أقصى مجموع ممكن للنقاط

    for (int i = 0; i < responses.length; i++) {
      if (responses[i] != null) {
        // تحويل القيم من نوع num إلى int
        totalScore += (questions[i]['scores'][responses[i]!] as int);
      }
    }

    int result = (totalScore / maxScore * 100).toInt();

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    int start = currentPage * questionsPerPage;
    int end = (start + questionsPerPage > questions.length) ? questions.length : start + questionsPerPage;

    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('اختبار ${widget.testId}'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.brightness_7 : Icons.brightness_2),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'الصفحة ${currentPage + 1} من ${(questions.length / questionsPerPage).ceil()}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: end - start,
                  itemBuilder: (context, index) {
                    int questionIndex = start + index;
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'سؤال ${questionIndex + 1}: ${questions[questionIndex]['question']}',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.right,
                            ),
                            ...List.generate(3, (optionIndex) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      questions[questionIndex]['options'][optionIndex],
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Radio<int?>(
                                    value: optionIndex,
                                    groupValue: responses[questionIndex],
                                    onChanged: (value) {
                                      setState(() {
                                        responses[questionIndex] = value;
                                      });
                                    },
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentPage > 0)
                    ElevatedButton(
                      onPressed: prevPage,
                      child: Text('الصفحة السابقة'),
                    ),
                  if (currentPage < (questions.length / questionsPerPage).ceil() - 1)
                    ElevatedButton(
                      onPressed: nextPage,
                      child: Text('الصفحة التالية'),
                    ),
                  if (currentPage == (questions.length / questionsPerPage).ceil() - 1)
                    ElevatedButton(
                      onPressed: calculateResult,
                      child: Text('عرض النتيجة'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
