import 'package:flutter/material.dart';

class test6 extends StatefulWidget {
  @override
  _Test6State createState() => _Test6State();
}

class _Test6State extends State<test6> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار مقياس القلق',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: AggressionTestPage(
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

class AggressionTestPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final Function(int) onTestCompleted;

  AggressionTestPage({required this.isDarkMode, required this.onThemeChanged, required this.onTestCompleted});

  @override
  _AggressionTestPageState createState() => _AggressionTestPageState();
}

class _AggressionTestPageState extends State<AggressionTestPage> {
  int currentPage = 0;
  List<Map<String, dynamic>> questions = [];
  List<int?> responses = [];
  List<List<Map<String, dynamic>>> pagedQuestions = [];

  @override
  void initState() {
    super.initState();

    // تعريف الأسئلة
    questions = [
     {'question': 'تنتابني مشاعر التوتر من بعض الأشياء الغير واضحة لدي', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أخاف من العتمة في الليل', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'عندما اتعرض لمشكلة اشعر بألم في بطني', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر بالخوف', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر بالخوف عندما أكون بمفردي بالبيت', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر بالرهبة عند ذهابي للإمتحان', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر بالخوف عند استخدامي للحمام خارج البيت', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر بالضيق عندما أكون بعيدا عن والدي', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر بالخوف من أن ابدو غبيا أمام الآخرين', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أتوتر عند عدم قيامي بواجبي المدرسي على أكمل وجه', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أنا محبوب بين زملائي في نفس عمري', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'تراودني أفكار ان هناك شيء سيء سيحدث في عائلتي', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أصاب بنوبات من ضيق التنفس بدون سبب واضح', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'استمر في تفقد الأشياء التي أعملها عدة مرات (مثل التأكد من أن النور مطفئ، باب البيت مقفل)', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر بالخوف عندما أنام لوحدي', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أجد صعوبة في الذهاب إلى المدرسة في الصباح لأنني أشعر بالخوف والتوتر', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أنا جيد في الرياضة', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أخاف من الكلاب والقطط', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'لا استطيع التغلب على بعض الأفكار السخيفة أو السيئة التي في رأسي', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'عندما أقع في مشكلة يخفق قلبي بشدة', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أصاب فجأة بالرعشة في كل جسمي بدون سبب', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر بأن أشياء سيئة سوف تحدث لي', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أخاف من الذهاب إلى طبيب الأسنان أو الطبيب العام', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر بالرعشة عندما أكون في مشكلة', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أخاف من الأماكن العالية ومن ركوب المصعد', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أنا شخصية جيدة', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'لإيقاف أشياء سيئة قد تحدث لي أفكر في أشياء مثل بعض الأرقام والكلمات', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أخاف من السفر في السيارة أو الباص', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر بالتوتر بما يظنه الناس بي', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أخاف من الأماكن المزدحمة', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر بالسعادة', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر فجأة بالخوف الشديد بدون سبب', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أخاف من الحشرات', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أصاب فجأة بالدوار والدوخة بدون سبب', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أخشى من الوقوف في الفصل والتحدث أمام زملائي', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'يبدأ قلبي بالخفقان بسرعة بدون سبب', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر بالرهبة من أشياء غير موجودة', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أحب نفسي', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أخاف من الأماكن الضيقة مثل الغرف الصغيرة', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أقوم بعمل أشياء عدة مرات مثل غسل اليدين - التنظيف -ترتيب الأشياء بطريقة معينة', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أصاب بالتوتر من الأفكار والصور السخيفة والسيئة التي تدور في رأسي', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أفعل أشياء صحيحة لكي اتجنب أشياء سيئة قد تحدث لي', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أفخر بعملي المدرسي', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
    {'question': 'أشعر بالرهبة في الليل عندما أكون خارج البيت', 'options': ['لا', 'أحياناً', 'عادة', 'دائماً']},
  ];
    // تحديد عدد الأسئلة في كل صفحة
    final int questionsPerPage = (questions.length / 3).ceil();

    // تقسيم الأسئلة على الصفحات
    pagedQuestions = List.generate(
      ((questions.length / questionsPerPage).ceil()), 
      (pageIndex) => questions.sublist(
        pageIndex * questionsPerPage,
        (pageIndex + 1) * questionsPerPage < questions.length 
            ? (pageIndex + 1) * questionsPerPage 
            : questions.length,
      ),
    );

    // تهيئة responses بعد تقسيم الأسئلة
    responses = List.generate(questions.length, (index) => null);
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
                    child: Text('الصفحة السابقة'),
                  ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: currentPage == pagedQuestions.length - 1
                      ? calculateResult
                      : nextPage,
                  child: Text(currentPage == pagedQuestions.length - 1 ? 'عرض النتيجة' : 'الصفحة التالية'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(test6());
