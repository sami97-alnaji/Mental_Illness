import 'package:flutter/material.dart';

class test14 extends StatefulWidget {
  @override
  _Test14State createState() => _Test14State();
}

class _Test14State extends State<test14> {
  bool _isDarkMode = false; // إدارة وضع الظلام
  int currentPage = 0;
  final int questionsPerPage = 6;

  // قائمة الأسئلة
  final List<String> questions = [
    'إذا قدم لي شيء وكان غير مناسب فإني أحاول التعبير عن عدم تقبلي لذلك الشيء علناً',
    'أشعر بالاستياء ممن هم في موقع السلطة عندما يحاولون الطلب مني بالقيام بعمل ما',
    'غالباً لا أثق بمن هم موجودون في موقع السلطة أو المسؤولية',
    'أستمتع برؤية شخص ما وهو يقوم بعمل شيء مسيء للآخرين',
    'أحاول مقاومة من يعمل على التقليل من شخصيتي',
    'أشعر بسعادة بالغة كلما سمحت لي الفرصة بدفع غير الراغبين بعمل لا يرغبون به',
    'أكون من الأفضل أن أملك شيء مجانا غالباً بدلاً من أداء عمله',
    'أستمتع كثيراً بالجدال مع الآخرين',
    'أشعر أنني لا أقتنع بسهوله بما يطرحه الآخرون من نقاشات عامة',
    'إذا طلب مني القيام بعمل شيء غالباً ما أقوم بعكس ما يطلب مني',
    'لا أخاف من مخالفتي للآخرين في أدائهم',
    'أشعر بالضيق عندما أرى أن شرطي المرور صاحب سلطة يجبر الآخرين على القيام بعمل ما',
    'لا يزعجني تغيير خططي عندما يريد أحد أفراد مجموعتي عمل شيء مغاير',
    'لا أمانع في ما إذا طلب مني الآخرون القيام بأي عمل',
    'لا شيء يثيرني كما تثيرني المجادلات السليمة',
    'إذا طلب أحد معروف أتروى وأنفذه',
    'لا أحتمل محاولات الآخرين في إقناعي',
    'غالباً لا أتبع نصائح الآخرين واقتراحاتهم',
    'أنا متعند في رأيي',
    'أرى أنه من المهم أن أكون في موقع قوة بالنسبة للآخرين',
    'أنا غير منفتح لتقبل حلول مختلفة من قبل الآخرين',
    'أستمتع بالوقوف ضد من يعتقد أنه على حق',
    'أعتبر نفسي منافساً لا متعاوناً',
    'أحب مساعدة الآخرين حتى دون أن أعرف لماذا أساعدهم',
    'غالباً لا أميل إلى الأخذ بنصائح الآخرين',
    'أنا عنيد جداً في أسلوبي',
    'أنه من غير المهم لي أن أجعل العلاقة جيدة مع الذين أعمل معهم',
  ];

  List<int?> responses = List.filled(27, null);

  int calculateTotalScore() {
    return responses.where((response) => response != null).fold(0, (total, value) => total + (value ?? 0));
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

  void finishQuiz() {
    int totalScore = calculateTotalScore();
    
    // بدلاً من عرض النتيجة، نرجعها إلى الشاشة السابقة باستخدام Navigator
    Navigator.pop(context, totalScore);
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (questions.length / questionsPerPage).ceil();
    int start = currentPage * questionsPerPage;
    int end = (start + questionsPerPage > questions.length) ? questions.length : start + questionsPerPage;

    return MaterialApp(
      title: 'اختبار التمرد',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('مقياس التمرد'),
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
                          'سؤال ${questionIndex + 1}: ${questions[questionIndex]}',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ...List.generate(
                          4, // عدد الخيارات
                          (optIndex) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    ['لا أوافق بشدة', 'لا أوافق', 'أوافق', 'أوافق بشدة'][optIndex],
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Radio<int?>(
                                  value: optIndex + 1,
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
                    onPressed: currentPage == totalPages - 1 ? finishQuiz : nextPage,
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
