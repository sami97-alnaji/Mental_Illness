const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const authRoutes = require('./routes/auth');

dotenv.config(); // لتحميل المتغيرات من ملف .env

const app = express();
const PORT = process.env.PORT || 3000; // تأكد من أنك تستخدم 3000 هنا

// Middleware
app.use(express.json()); // لتحليل JSON من طلبات POST

// إعداد الاتصال بقاعدة البيانات MongoDB
mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Connected to MongoDB'))
    .catch(err => {
        console.error('Could not connect to MongoDB:', err.message);
        process.exit(1); // إنهاء العملية إذا فشل الاتصال
    });

// إعداد المسارات
app.use('/api/auth', authRoutes); // تأكد من أن المسار صحيح

// بدء تشغيل الخادم
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
