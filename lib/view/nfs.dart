import 'package:flutter/material.dart';

class test55 extends StatefulWidget {
  @override
  _Test5State createState() => _Test5State();
}

class _Test5State extends State<test55> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مقياس تقدير الذات',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: SelfEsteemTest(
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

class SelfEsteemTest extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  SelfEsteemTest({required this.isDarkMode, required this.onThemeChanged});

  @override
  _SelfEsteemTestState createState() => _SelfEsteemTestState();
}

class _SelfEsteemTestState extends State<SelfEsteemTest> {
  int currentPage = 0;

   final List<Map<String, dynamic>> questions = [
    {'question': 'لدي القدرة الاجتماعية على الحديث مع الغرباء في المواقف المختلفة', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أحاول سعياً للتعبير عن وجهة نظري', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'لا أعرف ما أقوله للأشخاص الذين يعجبونني', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أتقبل النقد والاعتذار عندما يكون مناسباً للموقف', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أتردد في إجراء مكالمات هاتفية لأي غرض من الأغراض حتى لا أحرج الآخرين', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'لا أتردد في التعبير عن مشاعري السلبية وبطريقة مناسبة إذا وجه أحدهم لي إهانة أو تحقير', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أغضب بشكل مبالغ فيه عند حديثي مع الآخرين', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أتجنب النقاش حول الأسعار مع البائعين حرصاً على مشاعرهم أو خوفاً من الإحراج', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أفصح عن هويتي وأعرف عن نفسي بجرأة', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'عندما أقدم تحية للآخرين أتحدث بصوت خافت جداً', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أستطيع إنهاء العلاقة مع الأفراد الآخرين إذا شعرت أنها مؤذية', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أتواصل بصرياً مع الآخرين الذين أتحدث معهم بشكل مناسب', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أحرص على تجنب إيذاء مشاعر الآخرين حتى عندما أشعر بأنه قد جرح مشاعري', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'إذا ضايقني قريب أو صديق أو زميل، فإنني أفضل أن أخفي مشاعري بدلاً من أن أعبر عن ضيقي منه', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'عندما أكون في موقف جديد أستطيع التعبير عن احتياجاتي وبالشكل المناسب', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'إذا كنت في نقاش مع مجموعة من الأفراد فإنني لا أستطيع التعبير عن وجهة نظري بطريقة لبقة', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'إذا كنت في موقف تعليمي فإنني أتردد في سؤال المعلم عما لا أفهمه', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أتعامل مع المواقف المحرجة بطريقة عدوانية', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'إذا مدحني شخص ما فإنني أشكره بالطريقة المناسبة', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'إذا أعجبت بشيء ما أو شخص ما فإنني أختار الوقت المناسب للتعبير عن مشاعري', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أشعر بالكره والرغبة في التهجم على الآخرين', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'ليس لدي القدرة في تقديم المديح للآخرين بالشكل المناسب', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أستطيع تقديم الشكوى للآخرين عندما يسببوا لي الإزعاج والإيذاء بالشكل المناسب', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'إذا كان بجانبي اثنان يتحدثان بصوت عالٍ وأريد الإنصات أطلب منهما الالتزام بالهدوء أو إتمام محادثتهما فيما بعد', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أتردد في دعوة الآخرين لزيارتي أو تناول الطعام عندي بسبب خجلي', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أجد إحراجاً في إعادة شيء اكتشفت أنه غير مناسب وكنت قد اشتريته', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أكون لطيفاً مع الآخرين ولو على حساب مصلحتي الذاتية', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أعبر عن مشاعري بصراحة ووضوح', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أعرف متى أقول: نعم ومتى أقول: لا', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أتردد في المطالبة بحقوقي عندما تكون قليلة جداً وغير مهمة كباقي أجرة', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أعطي الآخرين حقوقهم بطريقة لبقة ومؤدبة ولا أعمل على تأجيلها', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'إذا وجه لي شخص ما انتقاداً فإنني أعرف كيف أتعامل معه بشكل مناسب', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'أجد صعوبة في الحديث أمام المسؤولين عن موضوع يخصني وعندها قد يبدو علي تردد وحشرجة في الصوت', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'ألجأ إلى كبت مشاعري بدلاً من إظهارها حتى لا أزعج الآخرين', 'options': ['أوافق', 'لا أوافق']},
    {'question': 'لدي ثقة بقدرتي على التعبير عما يجول في خاطري', 'options': ['أوافق', 'لا أوافق']},
  ];
 

  late List<List<Map<String, dynamic>>> pagedQuestions;
  late List<int?> responses;

  @override
  void initState() {
    super.initState();
    final int questionsPerPage = (questions.length / 3).ceil();
    pagedQuestions = List.generate(
      (questions.length / questionsPerPage).ceil(),
      (pageIndex) {
        final start = pageIndex * questionsPerPage;
        final end = (pageIndex + 1) * questionsPerPage;
        return questions.sublist(
          start,
          end > questions.length ? questions.length : end,
        );
      },
    );
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
    int totalScore = 0;

    for (int i = 0; i < questions.length; i++) {
      if (responses[i] != null) {
        int response = responses[i]!;
        if (positiveItems.contains(i)) {
          totalScore += response == 0 ? 1 : 0;
        } else if (negativeItems.contains(i)) {
          totalScore += response == 1 ? 1 : 0;
        }
      }
    }

    String result;
    if (totalScore <= 35) {
      result = "تقدير الذات مرتفع";
    } else if (totalScore <= 70) {
      result = "تقدير الذات متوسط";
    } else {
      result = "تقدير الذات منخفض";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('نتيجة الاختبار'),
          content: Text('درجة تقدير الذات: $totalScore\nالحالة: $result'),
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
          child: Text('مقياس تقدير الذات'),
        ),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.brightness_7 : Icons.brightness_3),
            onPressed: () {
              widget.onThemeChanged(!widget.isDarkMode);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'صفحة ${currentPage + 1} من ${pagedQuestions.length}',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestions.length,
                itemBuilder: (context, index) {
                  int questionIndex = currentPage * ((questions.length / 3).ceil()) + index;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'السؤال ${questionIndex + 1} ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        currentQuestions[index]['question'],
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: (currentQuestions[index]['options'] as List<String>)
                            .asMap()
                            .entries
                            .map((entry) {
                          int optionIndex = entry.key;
                          String option = entry.value;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                option,
                                style: TextStyle(
                                  fontSize: 16.0,
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
                        }).toList(),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: prevPage,
                  child: Text('السابق'),
                ),
                ElevatedButton(
                  onPressed: currentPage == pagedQuestions.length - 1
                      ? calculateResult
                      : nextPage,
                  child: Text(
                    currentPage == pagedQuestions.length - 1 ? 'إرسال' : 'التالي',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final List<int> positiveItems = [
    0, 1, 3, 4, 5, 6, 7, 8, 9, 11, 13, 14, 15, 16, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33, 34
  ];

  final List<int> negativeItems = [
    2, 10, 12, 17, 28
  ];
}
