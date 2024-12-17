import 'package:flutter/material.dart';

class test13 extends StatefulWidget {
  @override
  _Test13State createState() => _Test13State();
}

class _Test13State extends State<test13> {
  bool _isDarkMode = false; // إدارة وضع الظلام

  int currentPage = 0;
  final int questionsPerPage = 6;

  // قائمة الأسئلة وخيارات الإجابة
  List<Map<String, dynamic>> questions = [
    {'question': 'توافر المعلومات حول الخدمات المتاحة للمعاقين في المجتمع', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'توفير برامج إرشادية حول خصائص الأطفال المعاقين واحتياجاتهم', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'أتابع التحقيقات الصحفية والتقارير المتعلقة بالإعاقة في الصحف اليومية', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'توفير معلومات حول المتخصصين في مجال رعاية المعاقين', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'معرفة أساليب مواجهة السلوكيات غير العادية للطفل المعاق', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'معرفة دور أولياء الأمور في برامج التربية الخاصة للأطفال المعاقين', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'توفير معلومات حول كيفية التعرف المبكر على الأطفال المعاقين', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'توفير برامج تدريبية يمكن تطبيقها مع الطفل المعاق في الأسرة', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'معرفة كيفية التعامل مع الطفل المعاق', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'دراسة مقررات متخصصة حول الإعاقة', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'توفير كتيبات ونشرات موجزة حول الإعاقة، بأسلوب يناسب أولياء الأمور', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'توفير الوسائل والألعاب التعليمية المناسبة للأطفال المعاقين', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'تخصيص بعض المميزات للأسر المعاقين مثل المواصلات العامة أو الهاتف أو الكهرباء', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'توفير العلاج الطبي المناسب لأفراد الأسرة عامة والمعاقين منهم خاصة', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'توفير وسائل الترفيه المناسبة للأطفال المعاقين وأسرهم', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'توفير الدعم المالي المناسب لمواجهة احتياجات الطفل المعاق', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'وجود نظام الأسرة الممتدة (الزوج والزوجة مع العائلة الأصلية)', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'وجود استشاري متخصص في مجال الإعاقة يسهل الاتصال به وقت الحاجة', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'وجود برامج دينية تقدم عبر وسائل الإعلام باستمرار لمساعدة أسر المعاقين على تخطي أزماتها', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'توفير برامج إرشادية لمختلف أفراد المجتمع حول كيفية التعامل مع أسر المعاقين', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'وجود جمعيات معينة يمكن أن يلجأ إليها أولياء الأمور للاستفسار عن أي شيء يخص ابنهم المعاق', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'وجود أقارب يساعدون الأسرة في رعاية طفلها المعاق', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'وجود أصدقاء مخلصين يمكن أن يلجأ إليهم ولي الأمر للمشورة والنصح حول كيفية التعامل مع الطفل المعاق', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
    {'question': 'إتاحة الفرصة للالتقاء بأسر المعاقين لتبادل المشورة والنصح والخبرات', 'options': ['غير مهم مطلقا', 'مهم بدرجة قليلة', 'مهم بدرجة متوسطة', 'مهم كثيرا', 'مهم جدا'], 'scores': [0, 1, 2, 3, 4]},
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
    int maxScore = questions.length * 4; // أقصى مجموع ممكن للنقاط

    for (int i = 0; i < responses.length; i++) {
      if (responses[i] != null) {
        totalScore += (questions[i]['scores'][responses[i]!] as int);
      }
    }

    Navigator.pop(context, totalScore);
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (questions.length / questionsPerPage).ceil();
    int start = currentPage * questionsPerPage;
    int end = (start + questionsPerPage > questions.length) ? questions.length : start + questionsPerPage;

    return MaterialApp(
      title: 'مقياس احتياجات أولياء أمور المعاقين',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('مقياس احتياجات أولياء أمور المعاقين'),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isDarkMode ? Colors.black : Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: currentPage == totalPages - 1 ? calculateResult : nextPage,
                    child: Text(currentPage == totalPages - 1 ? 'إنهاء' : 'التالي'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isDarkMode ? Colors.black : Colors.blue,
                      foregroundColor: Colors.white,
                    ),
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
