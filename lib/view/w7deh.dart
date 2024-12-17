import 'package:flutter/material.dart';

class test77 extends StatefulWidget {
  @override
  _PsychologicalLonelinessScaleState createState() => _PsychologicalLonelinessScaleState();
}

class _PsychologicalLonelinessScaleState extends State<test77> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مقياس الوحدة النفسية',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: LonelinessScalePage(
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

class LonelinessScalePage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  LonelinessScalePage({required this.isDarkMode, required this.onThemeChanged});

  @override
  _LonelinessScalePageState createState() => _LonelinessScalePageState();
}

class _LonelinessScalePageState extends State<LonelinessScalePage> {
  int currentPage = 0;

  List<Map<String, dynamic>> questions = [
    {'question': 'أشعر أنني منسجم مع من حولي من الناس', 'options': {'إطلاقاً': 5, 'نادراً': 4, 'بدرجة متوسطة': 3, 'معظم الأحيان': 2, 'دائماً': 1}},
    {'question': 'أشعر أنني محتاج لأصدقاء', 'options': {'إطلاقاً': 1, 'نادراً': 2, 'بدرجة متوسطة': 3, 'معظم الأحيان': 4, 'دائماً': 5}},
    {'question': 'أشعر أنه لا يوجد من ألجأ إليه من الناس', 'options': {'إطلاقاً': 1, 'نادراً': 2, 'بدرجة متوسطة': 3, 'معظم الأحيان': 4, 'دائماً': 5}},
    {'question': 'يغلب على الشعور بالوحدة', 'options': {'إطلاقاً': 1, 'نادراً': 2, 'بدرجة متوسطة': 3, 'معظم الأحيان': 4, 'دائماً': 5}},
    {'question': 'أشعر بأنني جزء من مجموعة من الأصدقاء', 'options': {'إطلاقاً': 5, 'نادراً': 4, 'بدرجة متوسطة': 3, 'معظم الأحيان': 2, 'دائماً': 1}},
    {'question': 'أشترك في كثير من الأشياء مع الناس المحيطين بي', 'options': {'إطلاقاً': 5, 'نادراً': 4, 'بدرجة متوسطة': 3, 'معظم الأحيان': 2, 'دائماً': 1}},
    {'question': 'أشعر بأنني لم أعد قريبا من أي شخص', 'options': {'إطلاقاً': 1, 'نادراً': 2, 'بدرجة متوسطة': 3, 'معظم الأحيان': 4, 'دائماً': 5}},
    {'question': 'أشعر بأن اهتماماتي وأفكاري لا يشاركني فيها أحد', 'options': {'إطلاقاً': 1, 'نادراً': 2, 'بدرجة متوسطة': 3, 'معظم الأحيان': 4, 'دائماً': 5}},
    {'question': 'أشعر بالود والصداقة مع الآخرين', 'options': {'إطلاقاً': 5, 'نادراً': 4, 'بدرجة متوسطة': 3, 'معظم الأحيان': 2, 'دائماً': 1}},
    {'question': 'أشعر بأن الآخرين يمهلونني', 'options': {'إطلاقاً': 5, 'نادراً': 4, 'بدرجة متوسطة': 3, 'معظم الأحيان': 2, 'دائماً': 1}},
    {'question': 'أشعر بأنني قريب من الناس', 'options': {'إطلاقاً': 5, 'نادراً': 4, 'بدرجة متوسطة': 3, 'معظم الأحيان': 2, 'دائماً': 1}},
    {'question': 'أشعر بأن علاقتي مع الآخرين ليس لها قيمة', 'options': {'إطلاقاً': 1, 'نادراً': 2, 'بدرجة متوسطة': 3, 'معظم الأحيان': 4, 'دائماً': 5}},
    {'question': 'أشعر بأنه لا يوجد شخص يفهمني جيداً', 'options': {'إطلاقاً': 1, 'نادراً': 2, 'بدرجة متوسطة': 3, 'معظم الأحيان': 4, 'دائماً': 5}},
    {'question': 'أشعر بأنني منعزل عن الآخرين', 'options': {'إطلاقاً': 1, 'نادراً': 2, 'بدرجة متوسطة': 3, 'معظم الأحيان': 4, 'دائماً': 5}},
    {'question': 'أشعر بأنني أستطيع أن أعثر على الأصدقاء عندما أحتاج إليهم', 'options': {'إطلاقاً': 5, 'نادراً': 4, 'بدرجة متوسطة': 3, 'معظم الأحيان': 2, 'دائماً': 1}},
    {'question': 'أشعر بأنه يوجد أناس يفهمونني جيداً', 'options': {'إطلاقاً': 5, 'نادراً': 4, 'بدرجة متوسطة': 3, 'معظم الأحيان': 2, 'دائماً': 1}},
  ];

  List<int?> responses = List.generate(16, (index) => null);
  List<List<Map<String, dynamic>>> pagedQuestions = [];

  @override
  void initState() {
    super.initState();
    final int questionsPerPage = (questions.length / 4).ceil();
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
      int questionIndex = currentPage * ((questions.length / 4).ceil()) + i;
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

    int emotionalLoneliness = responses[2]! + responses[3]! + responses[6]! + responses[7]! + responses[8]! + responses[9]! + responses[12]! + responses[15]!;
    int socialLoneliness = responses[0]! + responses[1]! + responses[4]! + responses[5]! + responses[10]! + responses[11]! + responses[13]! + responses[14]!;

    String result;
    double totalScore = emotionalLoneliness + socialLoneliness.toDouble();
    double averageScore = totalScore / 16;

    if (averageScore > 3) {
      result = "تشير النتائج إلى شعور بالوحدة النفسية.";
    } else {
      result = "تشير النتائج إلى شعور منخفض بالوحدة النفسية.";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('نتيجة الاختبار'),
          content: Text('النتيجة العاطفية: $emotionalLoneliness\nالنتيجة الاجتماعية: $socialLoneliness\nالتقييم العام: $result'),
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
          child: Text('مقياس الوحدة النفسية'),
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
                int questionIndex = currentPage * ((questions.length / 4).ceil()) + index;
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
                      ...currentQuestions[index]['options'].entries.map(
                        (option) {
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  option.key,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Radio<int>(
                                value: option.value,
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
                      ).toList(),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                if (currentPage > 0)
                  ElevatedButton(
                    onPressed: prevPage,
                    child: Text('الصفحة السابقة'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(test77());
