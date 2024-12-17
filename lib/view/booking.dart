import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Doctors.dart'; // استبدل بمسار ملف تعريف `Therapist` الخاص بك
import 'payment_page.dart';// استبدل بمسار صفحة الدفع الخاصة بك
class BookingPage extends StatefulWidget {
  final Therapist therapist;

  BookingPage({required this.therapist});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  String? selectedTime;

  // التحقق إذا كان اليوم متاحًا
  bool isDayAvailable(DateTime day) {
    return widget.therapist.availableDays.contains(day.weekday - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book a Session with ${widget.therapist.name}"),
      ),
      body: Column(
        children: [
          // التقويم لاختيار التاريخ
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(Duration(days: 30)),
            focusedDay: selectedDate ?? DateTime.now(),
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(selectedDate, day),
            onDaySelected: (selectedDay, _) {
              if (isDayAvailable(selectedDay)) {
                setState(() {
                  selectedDate = selectedDay;
                  selectedTime = null; // إعادة ضبط الوقت عند تغيير التاريخ
                });
              }
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (!isDayAvailable(day)) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(color: Colors.grey), // تعيين لون رمادي للأيام غير المتاحة
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          Divider(),
          // عرض الأوقات المتاحة
          if (selectedDate != null)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available Times on ${selectedDate!.toLocal()}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: widget.therapist.availableTimes.map((time) {
                      return ChoiceChip(
                        label: Text(time),
                        selected: selectedTime == time,
                        onSelected: (selected) {
                          setState(() {
                            selectedTime = selected ? time : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          Spacer(),
          // زر المتابعة للدفع
          if (selectedDate != null && selectedTime != null)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      therapist: widget.therapist,
                      selectedDate: selectedDate!,
                      selectedTime: selectedTime!,
                    ),
                  ),
                );
              },
              child: Text("Proceed to Payment"),
            ),
        ],
      ),
    );
  }
}
