import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'booking.dart';

class Therapist {
  final String name;
  final String specialization;
  final double rating;
  final int reviews;
  final String interests;
  final String nextAppointment;
  final String sessionRate;
  final String shortSessionRate;
  final bool isAvailableToday;
  final bool isAvailableThisWeek;
  final String gender;
  final String country;
  final bool isOnline;
  final List<String> availableTimes; // المواعيد المتاحة لكل معالج
  final List<int> availableDays; // الأيام المتاحة (0: الأحد، 1: الإثنين، ...)

  Therapist({
    required this.name,
    required this.specialization,
    required this.rating,
    required this.reviews,
    required this.interests,
    required this.nextAppointment,
    required this.sessionRate,
    required this.shortSessionRate,
    required this.isAvailableToday,
    required this.isAvailableThisWeek,
    required this.gender,
    required this.country,
    required this.isOnline,
    required this.availableTimes,
    required this.availableDays, // إضافة الأيام هنا
  });
}



class TherapistList extends StatefulWidget {
  @override
  _TherapistListState createState() => _TherapistListState();
}

class _TherapistListState extends State<TherapistList> {
  List<Therapist> therapists = [];
  String selectedSort = 'Top Rated';
  bool filterOnline = false;
  bool filterToday = false;
  bool filterThisWeek = false;
  String selectedGender = 'All';
  double minRating = 0.0;

  @override
  void initState() {
    super.initState();
    _loadSampleTherapists(); // استدعاء دالة تحميل بيانات العينة
  }

  /// بيانات معالجين مثال
  void _loadSampleTherapists() {
    setState(() {
      therapists = [
        Therapist(
          name: "Dr. John Smith",
          specialization: "Psychologist",
          rating: 4.5,
          reviews: 150,
          interests: "Stress, Anxiety, Depression",
          nextAppointment: "Dec 14, 2024",
          sessionRate: "\$10/hour",
          shortSessionRate: "\$6/30min",
          isAvailableToday: true,
          isAvailableThisWeek: true,
          gender: "Male",
          country: "USA",
          isOnline: true,
           availableTimes: ["10:00 AM", "1:00 PM", "3:00 PM"],
  availableDays: [1, 3, 5], // يعمل يومي الإثنين، الأربعاء، والجمعة
        ),
        Therapist(
          name: "Dr. Emily Brown",
          specialization: "Child Therapist",
          rating: 4.8,
          reviews: 200,
          interests: "Child Behavior, Autism, ADHD",
          nextAppointment: "Dec 16, 2024",
          sessionRate: "\$12/hour",
          shortSessionRate: "\$7/30min",
          isAvailableToday: false,
          isAvailableThisWeek: true,
          gender: "Female",
          country: "UK",
          isOnline: false,
           availableTimes: ["10:00 AM", "1:00 PM", "3:00 PM"],
  availableDays: [1, 3, 5], // يعمل يومي الإثنين، الأربعاء، والجمعة
        ),
        Therapist(
          name: "Dr. Ahmed Ali",
          specialization: "Family Counselor",
          rating: 4.3,
          reviews: 110,
          interests: "Family Issues, Divorce, Parenting",
          nextAppointment: "Dec 15, 2024",
          sessionRate: "\$9/hour",
          shortSessionRate: "\$5/30min",
          isAvailableToday: true,
          isAvailableThisWeek: false,
          gender: "Male",
          country: "Egypt",
          isOnline: true,
           availableTimes: ["10:00 AM", "1:00 PM", "3:00 PM"],
  availableDays: [1, 3, 5], // يعمل يومي الإثنين، الأربعاء، والجمعة
        ),
        Therapist(
          name: "Dr. Sarah Johnson",
          specialization: "Mental Health Specialist",
          rating: 5.0,
          reviews: 250,
          interests: "Trauma, PTSD, Bipolar Disorder",
          nextAppointment: "Dec 13, 2024",
          sessionRate: "\$11/hour",
          shortSessionRate: "\$8/30min",
          isAvailableToday: false,
          isAvailableThisWeek: true,
          gender: "Female",
          country: "Canada",
          isOnline: true,
           availableTimes: ["10:00 AM", "1:00 PM", "3:00 PM"],
  availableDays: [1, 3, 5], // يعمل يومي الإثنين، الأربعاء، والجمعة
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Therapists"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () => _showSortDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: therapists.length,
        itemBuilder: (context, index) {
          final therapist = therapists[index];

          // تطبيق الفلاتر
          if (filterOnline && !therapist.isOnline) return SizedBox();
          if (filterToday && !therapist.isAvailableToday) return SizedBox();
          if (filterThisWeek && !therapist.isAvailableThisWeek) return SizedBox();
          if (selectedGender != 'All' && therapist.gender != selectedGender) return SizedBox();
          if (therapist.rating < minRating) return SizedBox();

          // تصميم بطاقة المعالج
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/therapist.jpg'), // تأكد من وجود الصورة
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            therapist.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(therapist.specialization),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              Text(
                                "${therapist.rating} (${therapist.reviews} reviews)",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text("Interests: ${therapist.interests}"),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16),
                      SizedBox(width: 4),
                      Text("Nearest Appointment: ${therapist.nextAppointment}"),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.attach_money, size: 16),
                      SizedBox(width: 4),
                      Text(therapist.sessionRate),
                      SizedBox(width: 16),
                      Text(therapist.shortSessionRate),
                    ],
                  ),
                  SizedBox(height: 16),
               ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingPage(therapist: therapist),
      ),
    );
  },
  child: Text("Book Now"),
),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Sort by'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  selectedSort = 'Top Rated';
                  therapists.sort((a, b) => b.rating.compareTo(a.rating));
                });
                Navigator.pop(context);
              },
              child: Text('Top Rated'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  selectedSort = 'Most Reviews';
                  therapists.sort((a, b) => b.reviews.compareTo(a.reviews));
                });
                Navigator.pop(context);
              },
              child: Text('Most Reviews'),
            ),
          ],
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context)
{
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Filters'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxListTile(
                      title: Text("Available Online"),
                      value: filterOnline,
                      onChanged: (value) {
                        setState(() {
                          filterOnline = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text("Available Today"),
                      value: filterToday,
                      onChanged: (value) {
                        setState(() {
                          filterToday = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text("Available This Week"),
                      value: filterThisWeek,
                      onChanged: (value) {
                        setState(() {
                          filterThisWeek = value!;
                        });
                      },
                    ),
                    DropdownButton<String>(
                      value: selectedGender,
                      items: ['All', 'Male', 'Female']
                          .map((label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                    Slider(
                      value: minRating,
                      min: 0.0,
                      max: 5.0,
                      divisions: 5,
                      label: "$minRating stars",
                      onChanged: (value) {
                        setState(() {
                          minRating = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Apply"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}


