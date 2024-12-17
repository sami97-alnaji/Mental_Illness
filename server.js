const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors());

let messages = [];

app.get('/messages', (req, res) => {
    res.json(messages);
});

app.post('/messages', (req, res) => {
    const { text, sender, timestamp } = req.body;

    if (!text || !sender || !timestamp) {
        return res.status(400).json({ error: 'Invalid message format' });
    }

    const message = { text, sender, timestamp };
    messages.push(message);
    res.status(200).json({ message: 'Message received' });
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
