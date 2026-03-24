const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>Cloud App</title>
      <style>
        body { font-family: monospace; background: #0a0e14; color: #c9d8f0;
               display: flex; align-items: center; justify-content: center;
               height: 100vh; margin: 0; }
        .box { text-align: center; border: 1px solid #1e2d47; padding: 40px; border-radius: 4px; }
        h1 { color: #00e5ff; font-size: 2rem; }
        p { color: #5a7a9a; }
      </style>
    </head>
    <body>
      <div class="box">
        <h1>Hello from the Cloud! ☁️</h1>
        <p>Deployed on AWS EC2 · Ubuntu 22.04 · Node.js ${process.version}</p>
        <p>Server time: ${new Date().toUTCString()}</p>
      </div>
    </body>
    </html>
  `);
});

app.get('/health', (req, res) => {
  res.json({ status: 'ok', uptime: process.uptime() });
});

app.listen(PORT, () => {
  console.log(`✅ Server running on http://localhost:${PORT}`);
});
