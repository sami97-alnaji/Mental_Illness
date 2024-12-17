import 'package:flutter/material.dart';

class test1 extends StatefulWidget {
  @override
  _AggressionTestState createState() => _AggressionTestState();
}

class _AggressionTestState extends State<test1> {
  bool _isDarkMode = false; // متغير لتخزين حالة الوضع الداكن

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار العدوانية',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(), // تغيير الثيم بناءً على حالة الوضع الداكن
      home: AggressionTestPage(
        isDarkMode: _isDarkMode,
        onThemeChanged: (bool value) {
          setState(() {
            _isDarkMode = value; // تحديث حالة الوضع الداكن
          });
        },
        onTestCompleted: (int testResult) {
          Navigator.pop(context, testResult); // إرسال النتيجة إلى الصفحة السابقة
        },
      ),
    );
  }
}

class AggressionTestPage extends StatefulWidget {
  final bool isDarkMode; // إضافة حالة الوضع الداكن
  final ValueChanged<bool> onThemeChanged; // دالة لتحديث حالة الوضع الداكن
  final Function(int) onTestCompleted;

  AggressionTestPage({
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.onTestCompleted,
  });

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
          child: Text('اختبار العدوانية'),
        ),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.brightness_7 : Icons.brightness_2),
            onPressed: () {
              widget.onThemeChanged(!widget.isDarkMode); // تغيير حالة الوضع الداكن
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

void main() => runApp(test1());
