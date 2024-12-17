import 'package:flutter/material.dart';

class test15 extends StatefulWidget {
  final String testId;

  test15({required this.testId});

  @override
  _Test15State createState() => _Test15State();
}

class _Test15State extends State<test15> {
  int currentPage = 0;
  final int questionsPerPage = 6;
  bool _isDarkMode = false;

  // قائمة الأسئلة
    List<Map<String, dynamic>> questions = [
    {'question': 'كثير النشاط ولا يهدأ', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'تسهل استثارته', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'كثير الشغب', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'يقلق راحة زملائه', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'يتشتت انتباهه بسهوله', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'إذا أعطي سؤال يندفع إلى الإجابة دون تفكير', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'لا يستطيع إتمام واجباته المدرسية', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'لا يثبت في مكان واحد لمدة طويلة (10 دقائق مثلا)', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'لا يلتزم بالتعليمات', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'متقلب المزاج', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'يرغب في أن تجاب طلباته في الحال', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'حاد المزاج وسريع الانفعال', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'لا يمكن التنبؤ بسلوكياته', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'يبكي لأبسط الأسباب', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'لا يستطيع متابعة شرح المدرس في الفصل', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'ضيق الصدر ولا يحتمل الآخرين', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'يندفع إلى السلوك دون حساب ما يترتب عليه من نتائج', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'لا يستطيع أن يقضي وقتا طويلا (10 دقائق) في لعبة واحدة', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'عندما يغضب لا يستطيع ضبط نفسه ويتفوه بألفاظ نابية', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'يتحدث بصوت مرتفع فجأة دون مراعاة النظام', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'يصعب عليه تكوين علاقات طيبة مع زملائه', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
    {'question': 'يصعب عليه تكوين علاقات طيبة مع مدرسيه', 'options': ['نهائيا', 'بعض الأحيان', 'كثيرا', 'دائما'], 'scores': [0, 1, 2, 3]},
  ];

  late List<int?> responses;

  @override
  void initState() {
    super.initState();
    responses = List.generate(questions.length, (index) => null);
  }

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

    for (int i = 0; i < responses.length; i++) {
      if (responses[i] != null) {
        var score = questions[i]['scores'][responses[i]!];
        totalScore += (score is int) ? score : (score as num).toInt();
      }
    }

    Navigator.pop(context, totalScore);
  }

  @override
  Widget build(BuildContext context) {
    int start = currentPage * questionsPerPage;
    int end = (start + questionsPerPage > questions.length) ? questions.length : start + questionsPerPage;

    // تحديد ThemeData بناءً على حالة الوضع الداكن
    final ThemeData themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          title: Text('مقياس النشاط الزائد - ${widget.testId}'),
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
                            ...List.generate(4, (optionIndex) {
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (currentPage > 0)
                    ElevatedButton(
                      onPressed: prevPage,
                      child: Text('السابق'),
                    ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: currentPage == (questions.length / questionsPerPage).ceil() - 1 ? calculateResult : nextPage,
                    child: Text(currentPage == (questions.length / questionsPerPage).ceil() - 1 ? 'إنهاء' : 'التالي'),
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
