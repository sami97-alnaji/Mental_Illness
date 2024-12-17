import 'package:flutter/material.dart';

class test12 extends StatefulWidget {
  final String testId;

  test12({required this.testId});

  @override
  _Test12State createState() => _Test12State();
}

class _Test12State extends State<test12> {
  bool _isDarkMode = false; // إدارة وضع الظلام

  int currentPage = 0;
  final int questionsPerPage = 9;

  List<Map<String, dynamic>> questions = [
    {'question': 'إنني غير اجتماعي الأمر الذي يلزم تكوين علاقات حديثة بالآخرين', 'options': ['أبداً', 'قليلاً', 'توسط', 'كثيراً', 'دائماً'], 'scores': [1, 2, 3, 4, 5]},
    {'question': 'لا أجد صعوبة في مبادرة الحديث مع الغرباء من الناس', 'options': ['أبداً', 'قليلاً', 'توسط', 'كثيراً', 'دائماً'], 'scores': [1, 2, 3, 4, 5]},
    {'question': 'أشعر بالتوتر حينما أتواجد في مجموعة من الناس لا أعرفهم', 'options': ['أبداً', 'قليلاً', 'توسط', 'كثيراً', 'دائماً'], 'scores': [1, 2, 3, 4, 5]},
    {'question': 'ينتابني الشعور بالقلق أثناء المحادثة خشية من قول شيء يدل على الغباء', 'options': ['أبداً', 'قليلاً', 'توسط', 'كثيراً', 'دائماً'], 'scores': [1, 2, 3, 4, 5]},
    {'question': 'أشعر بالقلق عندما أتحدث إلى شخص ذي سلطة أو نفوذ', 'options': ['أبداً', 'قليلاً', 'توسط', 'كثيراً', 'دائماً'], 'scores': [1, 2, 3, 4, 5]},
    {'question': 'ينتابني الشعور بعدم الراحة والضيق في الحفلات والنوادي الاجتماعية الأخرى', 'options': ['أبداً', 'قليلاً', 'توسط', 'كثيراً', 'دائماً'], 'scores': [1, 2, 3, 4, 5]},
    {'question': 'أشعر بأنني مقمع أو مكبت في المواقف والنواحي الاجتماعية', 'options': ['أبداً', 'قليلاً', 'توسط', 'كثيراً', 'دائماً'], 'scores': [1, 2, 3, 4, 5]},
    {'question': 'أشعر بصعوبة النظر أو التحديق في مرمى بصر شخص ما', 'options': ['أبداً', 'قليلاً', 'توسط', 'كثيراً', 'دائماً'], 'scores': [1, 2, 3, 4, 5]},
    {'question': 'إنني أكثر خجلاً مع أفراد الجنس الآخر عن أفراد جنسي', 'options': ['أبداً', 'قليلاً', 'توسط', 'كثيراً', 'دائماً'], 'scores': [1, 2, 3, 4, 5]},
  ];

  List<int?> responses = List.generate(9, (index) => null);

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
    int maxScore = questions.length * 5; // أقصى مجموع ممكن للنقاط

    for (int i = 0; i < responses.length; i++) {
      if (responses[i] != null) {
        totalScore += (questions[i]['scores'][responses[i]!] as int);
      }
    }

    int result = (totalScore / maxScore * 100).toInt();

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (questions.length / questionsPerPage).ceil();
    int start = currentPage * questionsPerPage;
    int end = (start + questionsPerPage > questions.length) ? questions.length : start + questionsPerPage;

    return MaterialApp(
      title: 'اختبار الخجل',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('اختبار الخجل'),
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
                end - start,
                (index) {
                  int questionIndex = start + index;
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
                                Radio<int?>(
                                  value: optIndex,
                                  groupValue: responses[questionIndex],
                                  onChanged: (value) {
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
                    child: Text(currentPage == totalPages - 1 ? 'إنهاء' : 'التالي'),
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
