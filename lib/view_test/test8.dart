import 'package:flutter/material.dart';

void main() => runApp(test8());

class test8 extends StatefulWidget {
  @override
  _Test8State createState() => _Test8State();
}

class _Test8State extends State<test8> {
  bool _isDarkMode = false;
  int _testResult = 0; // لتخزين النتيجة

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار الإحباط',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: DepressionTestPage(
        isDarkMode: _isDarkMode,
        onThemeChanged: (bool value) {
          setState(() {
            _isDarkMode = value;
          });
        },
        onTestCompleted: (int yesCount) {
          setState(() {
            _testResult = yesCount; // تخزين النتيجة
          });
          Navigator.pop(context, yesCount); // العودة إلى الصفحة السابقة مع النتيجة
        },
      ),
    );
  }
}

class DepressionTestPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final Function(int) onTestCompleted;

  DepressionTestPage({
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.onTestCompleted,
  });

  @override
  _DepressionTestPageState createState() => _DepressionTestPageState();
}

class _DepressionTestPageState extends State<DepressionTestPage> {
  int currentPage = 0;

  List<Map<String, dynamic>> questions = [
    {'question': 'أشعر بروح جيدة.', 'options': ['نعم', 'لا']},
    {'question': 'أشعر برغبة في البكاء.', 'options': ['نعم', 'لا']},
    {'question': 'حالتي لا أمل فيها.', 'options': ['نعم', 'لا']},
    {'question': 'هناك ماسى تنتظرني في المستقبل.', 'options': ['نعم', 'لا']},
    {'question': 'أعتقد بأنني إنسان جيد كالآخرين.', 'options': ['نعم', 'لا']},
    {'question': 'أشعر بالخجل من نفسي.', 'options': ['نعم', 'لا']},
    {'question': 'الأشياء التي أقدم عليها تزعجني.', 'options': ['نعم', 'لا']},
    {'question': 'أنا أعاقب على أمر سيء منحت به في الماضي.', 'options': ['نعم', 'لا']},
    {'question': 'أعتقد أن الحياة ما زالت بها ما يستحق العيش.', 'options': ['نعم', 'لا']},
    {'question': 'أتمنى لم أنني ميت.', 'options': ['نعم', 'لا']},
    {'question': 'أفكر بقتل نفسي.', 'options': ['نعم', 'لا']},
    {'question': 'الموت هو الحل الأمثل بالنسبة لي.', 'options': ['نعم', 'لا']},
    {'question': 'أستغرق وقتا أطول من السابق قبل أن أنام.', 'options': ['نعم', 'لا']},
    {'question': 'يتطلب مني نصف ساعة قبل أن أخلد إلى النوم.', 'options': ['نعم', 'لا']},
    {'question': 'لا أرتاح في النوم ونومي مزعج.', 'options': ['نعم', 'لا']},
    {'question': 'أستيقظ دائماً في منتصف الليل.', 'options': ['نعم', 'لا']},
    {'question': 'أستيقظ قبل الوقت المحدد عادة.', 'options': ['نعم', 'لا']},
    {'question': 'أستيقظ أبكر مما أريد.', 'options': ['نعم', 'لا']},
    {'question': 'أنا أشعر بالسعادة والفرح والراحة مما أقوم به.', 'options': ['نعم', 'لا']},
    {'question': 'أرغب بالخروج ومقابلة الأشخاص.', 'options': ['نعم', 'لا']},
    {'question': 'لقد مللت الكثير من نشاطاتي واهتماماتي.', 'options': ['نعم', 'لا']},
    {'question': 'أنا قادر على متابعة العمل المطلوب مني.', 'options': ['نعم', 'لا']},
    {'question': 'أن عقلي سريع وذكي كالعادة.', 'options': ['نعم', 'لا']},
    {'question': 'صوتي يبدو ليس صوتي.', 'options': ['نعم', 'لا']},
    {'question': 'لقد قمت بجميع الأشياء بصعوبة في الآونة الأخيرة.', 'options': ['نعم', 'لا']},
    {'question': 'أنا بطيء جداً وبحاجة إلى المساعدة في اللبس.', 'options': ['نعم', 'لا']},
    {'question': 'أعتقد أني أستعد بالارتياح خارج المنزل.', 'options': ['نعم', 'لا']},
    {'question': 'لا أشعر بالارتياح.', 'options': ['نعم', 'لا']},
    {'question': 'يجب أن يكون بشكل واضح إلى الأمر مقلق.', 'options': ['نعم', 'لا']},
    {'question': 'يجب أن أحاول الابتعاد عن القلق.', 'options': ['نعم', 'لا']},
    {'question': 'أجد التركيز سهلاً عند قراءة ورقة ما.', 'options': ['نعم', 'لا']},
    {'question': 'أشعر بأنني منزعج ومجروح.', 'options': ['نعم', 'لا']},
    {'question': 'معظم الوقت أكون خائفاً ولا أعرف السبب.', 'options': ['نعم', 'لا']},
    {'question': 'أشعر بالرعب والخوف الشديد.', 'options': ['نعم', 'لا']},
    {'question': 'لدى مشاكل في الهضم.', 'options': ['نعم', 'لا']},
    {'question': 'أن قلبي ينبض أسرع من العادة.', 'options': ['نعم', 'لا']},
    {'question': 'لدى الأم عام في جسدي.', 'options': ['نعم', 'لا']},
    {'question': 'أن يداي تهتزان بحيث أن الناس يلاحظون ذلك.', 'options': ['نعم', 'لا']},
    {'question': 'أنا أحب وجباتي كالعادة.', 'options': ['نعم', 'لا']},
    {'question': 'أنا أجبر نفسي على تناول الطعام.', 'options': ['نعم', 'لا']},
    {'question': 'أشعر بحيوية وطاقة كما في السابق.', 'options': ['نعم', 'لا']},
    {'question': 'أنا مرهق أغلب الأحيان.', 'options': ['نعم', 'لا']},
    {'question': 'اهتماماتي الجنسية كما هي في السابق.', 'options': ['نعم', 'لا']},
    {'question': 'منذ بداية مرضي فقدت رغبتي الجنسية.', 'options': ['نعم', 'لا']},
    {'question': 'أنا قلق جداً حول أعراض جسمي.', 'options': ['نعم', 'لا']},
    {'question': 'أنا لست متأكد من أداء جسدي لوظائفه كاملة.', 'options': ['نعم', 'لا']},
    {'question': 'أن مشكلتي مع المرض بدأت منذ شعوري بأمراض من جسدي.', 'options': ['نعم', 'لا']},
    {'question': 'أن جسدي سيء وليس معافى.', 'options': ['نعم', 'لا']},
    {'question': 'أن كل ما أحتاجه هو الراحة لأعود بصحة وعافية كالسابق.', 'options': ['نعم', 'لا']},
    {'question': 'لقد مرضت بسبب الطقس السيئ الموجود الآن.', 'options': ['نعم', 'لا']},
    {'question': 'يمكنني القول بأنني فقدت الكثير من وزني.', 'options': ['نعم', 'لا']},
  ];

  List<int?> responses = List.generate(51, (index) => null);
  List<List<Map<String, dynamic>>> pagedQuestions = [];

  @override
  void initState() {
    super.initState();
    final int questionsPerPage = 10; // عدد الأسئلة في كل صفحة
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
      int questionIndex = currentPage * 10 + i;
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

    int yesCount = responses.where((r) => r == 0).length;

    // حساب النتيجة وتخزينها
    widget.onTestCompleted(yesCount);

    // العودة إلى الصفحة السابقة دون عرض النتيجة مباشرة
    Navigator.pop(context, yesCount);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentQuestions = pagedQuestions[currentPage];
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text('اختبار الإحباط'),
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
                int questionIndex = currentPage * 10 + index;
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
                    child: Text('السابق'),
                  ),
                if (currentPage < pagedQuestions.length - 1)
                  ElevatedButton(
                    onPressed: nextPage,
                    child: Text('التالي'),
                  ),
                if (currentPage == pagedQuestions.length - 1)
                  ElevatedButton(
                    onPressed: calculateResult,
                    child: Text('إرسال'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
