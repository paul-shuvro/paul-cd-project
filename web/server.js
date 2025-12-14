const express = require('express');
const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

const app = express();
app.use(express.json());
app.use(express.static(__dirname)); // serve index.html & index.js

const PORT = 3000;

// POST /run endpoint
app.post('/run', (req, res) => {
    const code = req.body.code;
    if (!code) return res.send('No code received!');

    // Save temporary C file
    const tmpFile = path.join(__dirname, 'temp.c');
    fs.writeFileSync(tmpFile, code);

    // Full path to your compiled tokenizer
    const ctokenizerPath = path.join(__dirname, '..', 'ctokenizer.exe');

    // Execute tokenizer
    exec(`"${ctokenizerPath}" "${tmpFile}"`, (error, stdout, stderr) => {
        fs.unlinkSync(tmpFile); // remove temp file

        if (error) {
            res.send(stderr || error.message);
        } else {
            res.send(stdout);
        }
    });
});

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
