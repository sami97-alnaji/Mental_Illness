// backend/routes/auth.js
const express = require('express');
const router = express.Router();
const User = require('../models/User'); // استيراد نموذج المستخدم

// نقطة نهاية لتسجيل مستخدم جديد
router.post('/signup', async (req, res) => {
    const { name, email, password } = req.body;

    try {
        // إنشاء مستخدم جديد
        const newUser = new User({ name, email, password });

        // حفظ المستخدم في قاعدة البيانات
        await newUser.save();

        res.status(201).send({ message: 'User registered successfully!' });
    } catch (err) {
        console.error(err);
        res.status(500).send({ error: 'Failed to register user' });
    }
});

router.get('/users', async (req, res) => {
    try {
        const users = await User.find(); // جلب المستخدمين من قاعدة البيانات
        res.send(users);
    } catch (err) {
        console.error(err);
        res.status(500).send({ error: 'Failed to retrieve users' });
    }
});

module.exports = router;
