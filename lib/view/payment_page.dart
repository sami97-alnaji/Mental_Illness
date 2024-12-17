import 'package:flutter/material.dart';
import 'Doctors.dart';

class PaymentPage extends StatefulWidget {
  final Therapist therapist;
  final DateTime selectedDate;
  final String selectedTime;

  PaymentPage({
    required this.therapist,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = "Visa";
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardExpiryController = TextEditingController();
  final TextEditingController cardCVCController = TextEditingController();
  final TextEditingController zainCashNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Therapist: ${widget.therapist.name}"),
            Text("Date: ${widget.selectedDate.toLocal()}"),
            Text("Time: ${widget.selectedTime}"),
            SizedBox(height: 16),
            Text(
              "Session Rate: ${widget.therapist.sessionRate}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              "Select Payment Method",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text("Visa Card"),
              leading: Radio(
                value: "Visa",
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value.toString();
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Zain Cash"),
              leading: Radio(
                value: "Zain Cash",
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value.toString();
                  });
                },
              ),
            ),
            if (selectedPaymentMethod == "Visa") ...[
              TextField(
                controller: cardNumberController,
                decoration: InputDecoration(
                  labelText: "Card Number",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: cardExpiryController,
                      decoration: InputDecoration(
                        labelText: "Expiry Date (MM/YY)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: cardCVCController,
                      decoration: InputDecoration(
                        labelText: "CVC",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (selectedPaymentMethod == "Zain Cash") ...[
              TextField(
                controller: zainCashNumberController,
                decoration: InputDecoration(
                  labelText: "Zain Cash Number",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
            ],
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // تنفيذ الدفع هنا بناءً على طريقة الدفع المختارة
                String confirmationMessage = "";
                if (selectedPaymentMethod == "Visa") {
                  confirmationMessage = "Payment with Visa completed successfully.";
                } else if (selectedPaymentMethod == "Zain Cash") {
                  confirmationMessage = "Payment with Zain Cash completed successfully.";
                }

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Payment Successful"),
                    content: Text(confirmationMessage),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // إغلاق التنبيه
                          Navigator.pop(context); // العودة إلى القائمة
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: Text("Pay Now"),
            ),
          ],
        ),
      ),
    );
  }
}
