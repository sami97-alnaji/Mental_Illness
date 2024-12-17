import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


void main() {
  runApp(evaluation());
}

class evaluation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('تقدمك الشخصي'),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تقدمك الشخصي عبر الوقت:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              
              // الرسوم البيانية باستخدام syncfusion_flutter_charts
              Container(
                height: 200.0,
                child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(),
                  series: <CartesianSeries>[
                    LineSeries<TimeSeriesSales, DateTime>(
                      dataSource: _createSampleData(),
                      xValueMapper: (TimeSeriesSales sales, _) => sales.time,
                      yValueMapper: (TimeSeriesSales sales, _) => sales.sales,
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.0),

              Text(
                'ملخص الجلسات السابقة:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 8.0),

              // قائمة الجلسات السابقة
              Expanded(
                child: ListView(
                  children: [
                    SessionCard(
                      date: '2024-09-01',
                      summary: 'جلسة علاج سلوكي.',
                      onTap: () {
                        // وظيفة لعرض تفاصيل الجلسة
                      },
                    ),
                    SessionCard(
                      date: '2024-09-10',
                      summary: 'جلسة تحليل نفسي.',
                      onTap: () {
                        // وظيفة لعرض تفاصيل الجلسة
                      },
                    ),
                    // يمكن إضافة المزيد من الجلسات هنا
                  ],
                ),
              ),
              SizedBox(height: 16.0),

              Text(
                'نصائح مخصصة:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 8.0),

              // نصائح مخصصة بناءً على التقدم
              Text(
                'استمر في الالتزام بجدول الجلسات وحاول التركيز على الاسترخاء والتنفس العميق.',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // إنشاء بيانات عينة للمخطط
  List<TimeSeriesSales> _createSampleData() {
    return [
      TimeSeriesSales(DateTime(2024, 9, 1), 1),
      TimeSeriesSales(DateTime(2024, 9, 2), 1.5),
      TimeSeriesSales(DateTime(2024, 9, 3), 1.4),
      TimeSeriesSales(DateTime(2024, 9, 4), 3.4),
      TimeSeriesSales(DateTime(2024, 9, 5), 2.0),
    ];
  }
}

// بطاقة الجلسة
class SessionCard extends StatelessWidget {
  final String date;
  final String summary;
  final VoidCallback onTap;

  SessionCard({
    required this.date,
    required this.summary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(date, style: TextStyle(fontSize: 18.0)),
        subtitle: Text(summary),
        onTap: onTap,
      ),
    );
  }
}

// نموذج بيانات للمخطط
class TimeSeriesSales {
  final DateTime time;
  final double sales;

  TimeSeriesSales(this.time, this.sales);
}
