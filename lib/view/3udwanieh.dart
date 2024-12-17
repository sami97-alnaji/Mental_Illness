import 'package:flutter/material.dart';

class Aggression extends StatefulWidget {
  const Aggression({super.key});

  @override
  _AggressionTestState createState() => _AggressionTestState();
}

class _AggressionTestState extends State<Aggression> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار العدوانية',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: AggressionTestPage(
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

class AggressionTestPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  AggressionTestPage({super.key, required this.isDarkMode, required this.onThemeChanged});

  @override
  _AggressionTestPageState createState() => _AggressionTestPageState();
}

class _AggressionTestPageState extends State<AggressionTestPage> {
  int currentPage = 0;

  List<Map<String, dynamic>> questions = [
    {'question': 'يسبب الأذى للآخرين بطريقة غير مباشرة', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يبصق على الآخرين', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يدفع أو يخمش أو يقرص الآخرين', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يشد شعر الآخرين أو آذانهم', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يضرب الآخرين', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يرفس أو يضرب أو يصفع الآخرين', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يحاول خنق الآخرين', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يرمي الأشياء على الآخرين', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يستعمل أشياء حادة ضد الآخرين', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يمزق أو يشد أو يمضغ ملابسه', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يلوث ممتلكاته', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يمزق دفاتره أو كتبه', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يمزق دفاتر أو كتب الآخرين', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يمزق أو يشد أو يمضغ ملابس الآخرين', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يلوث ملابس الآخرين', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يمزق المجلات والكتب أو الممتلكات العامة', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يتعامل بخشونة مفرطة مع الأثاث', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يكسر الشبابيك', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يبكي ويصرخ', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يضرب الأشياء بقدميه وهو يصرخ', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يرمى بنفسه على الأرض ويصرخ', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
    {'question': 'يضرب بقدميه أو يغلق الأبواب بعنف', 'options': ['لا يحدث', 'أحياناً', 'باستمرار']},
  ];

  List<int?> responses = List.generate(22, (index) => null);
  List<List<Map<String, dynamic>>> pagedQuestions = [];

  @override
  void initState() {
    super.initState();
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
        const SnackBar(content: Text('يرجى الإجابة على جميع الأسئلة قبل الانتقال إلى الصفحة التالية.')),
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
        const SnackBar(content: Text('يرجى الإجابة على جميع الأسئلة قبل إرسال النموذج.')),
      );
      return;
    }

    int totalScore = responses.where((r) => r != null).cast<int>().fold(0, (sum, value) => sum + value);

    String result;
    if (totalScore >= 18) {
      result = "مستوى عالي من العدوانية";
    } else {
      result = "مستوى منخفض من العدوانية";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('نتيجة الاختبار'),
          content: Text('الدرجة الكلية: $totalScore\nالحالة: $result'),
          actions: [
            TextButton(
              child: const Text('موافق'),
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
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text('اختبار العدوانية'),
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16.0),
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
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage < pagedQuestions.length - 1)
                  ElevatedButton(
                    onPressed: nextPage,
                    child: const Text('الصفحة التالية'),
                  ),
                if (currentPage == pagedQuestions.length - 1)
                  ElevatedButton(
                    onPressed: calculateResult,
                    child: const Text('عرض النتيجة'),
                  ),
                if (currentPage > 0)
                  ElevatedButton(
                    onPressed: prevPage,
                    child: const Text('الصفحة السابقة'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(const Aggression());