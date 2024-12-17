const express = require('express');
const app = express();
const port = 3000;

app.use(express.json());

// مثال على بيانات المعالجين
const therapists = [
  {
    name: "Hussein Haj Ahmad",
    specialization: "Psychologist",
    rating: 4.78,
    reviews: 1566,
    interests: "Anxiety Disorders, Depression",
    nextAppointment: "Sunday, Oct.20 at 05:00 PM",
    sessionRate: "45 USD / 60 Minutes",
    shortSessionRate: "30 USD / 30 Minutes",
    isAvailableToday: true,
    isAvailableThisWeek: true,
    gender: "Male",
    country: "Jordan",
    isOnline: true,
  },
  {
    name: "Bahaa Mahmoud",
    specialization: "Psychiatrist",
    rating: 4.89,
    reviews: 1215,
    interests: "Stress, Bipolar Disorder",
    nextAppointment: "Monday, Oct.21 at 02:00 PM",
    sessionRate: "50 USD / 60 Minutes",
    shortSessionRate: "35 USD / 30 Minutes",
    isAvailableToday: false,
    isAvailableThisWeek: true,
    gender: "Male",
    country: "Egypt",
    isOnline: false,
  },
];

// نقطة النهاية لجلب بيانات المعالجين
app.get('/therapists', (req, res) => {
  res.json(therapists);
});

// بدء الخادم
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
