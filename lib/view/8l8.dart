import 'package:flutter/material.dart';

class test66 extends StatefulWidget {
  const test66({super.key});

  @override
  _AnxietyTestAppState createState() => _AnxietyTestAppState();
}

class _AnxietyTestAppState extends State<test66> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار مقياس القلق',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: AnxietyTest(
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

class AnxietyTest extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  AnxietyTest({super.key, required this.isDarkMode, required this.onThemeChanged});

  @override
  _AnxietyTestState createState() => _AnxietyTestState();
}

class _AnxietyTestState extends State<AnxietyTest> {
  int currentPage = 0;
  final int questionsPerPage = 7;

  List<Map<String, dynamic>> questions = [
    {'question': 'أشعر بالتوتر:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالقلق تجاه المستقبل:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أجد صعوبة في الاسترخاء:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالتوتر في المواقف الاجتماعية:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالخوف غير المبرر:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أعاني من تسارع ضربات القلب:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بصعوبة في التنفس:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أعاني من صداع مستمر:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بعدم الراحة في المعدة:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالخوف من الأماكن المفتوحة:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالخوف من المواقف غير المتوقعة:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالتوتر عندما أكون وحدي:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالتوتر في الأماكن المزدحمة:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالخوف من فقدان السيطرة:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالقلق من المستقبل:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالتوتر عند التحدث أمام الآخرين:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالقلق تجاه الأداء في العمل أو الدراسة:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالخوف من الفشل:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالقلق بشأن علاقاتي الاجتماعية:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالقلق من المستقبل المالي:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
    {'question': 'أشعر بالتوتر تجاه الأمور الصحية:', 'options': ['أبدًا', 'بعض الأحيان', 'كثيرًا', 'طوال الوقت']},
  ];

  List<int?> responses = List.generate(21, (index) => null);

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
    int totalScore = responses.where((response) => response != null).map((response) => response!).reduce((a, b) => a + b);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('النتيجة'),
        content: Text('مجموع نقاط القلق لديك هو: $totalScore'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (questions.length / questionsPerPage).ceil();
    int startIndex = currentPage * questionsPerPage;
    int endIndex = (startIndex + questionsPerPage).clamp(0, questions.length);

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text('اختبار مقياس القلق'),
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16.0),
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
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (currentPage > 0)
                  ElevatedButton(
                    onPressed: prevPage,
                    child: const Text('السابق'),
                  ),
                const SizedBox(width: 16.0),
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
