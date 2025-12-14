const runBtn = document.getElementById('runBtn');
const clearBtn = document.getElementById('clearBtn');
const outputEl = document.getElementById('output');
const codeEl = document.getElementById('code');

runBtn.addEventListener('click', async () => {
    const code = codeEl.value.trim();
    if (!code) {
        outputEl.textContent = "কোনো কোড পাওয়া যায়নি!";
        return;
    }

    outputEl.textContent = "Processing...\n";

    try {
        const res = await fetch('/run', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({ code })
        });
        const result = await res.text();
        outputEl.textContent = result;
    } catch (err) {
        outputEl.textContent = "Error: " + err.message;
    }
});

clearBtn.addEventListener('click', () => {
    codeEl.value = '';
    outputEl.textContent = '';
});
