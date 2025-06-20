# AesGPT 🤖

Bot Telegram ringan & santai powered by GPT-3.5 (via proxy). Ngobrol langsung kayak ChatGPT, tanpa bayar dan bisa jalan di Replit/Render.

---

## ✨ Fitur

- 🧠 ChatGPT langsung di Telegram
- 🗣️ Gaya bahasa asik dan santai
- 🧼 Markdown support
- 🧠 Simpan context per user
- 🚀 Siap deploy

---

## 🚀 Cara Deploy

### Replit

1. Import repo ini ke [Replit](https://replit.com/)
2. Buka tab Secrets → Tambahkan:
   - `BOT_TOKEN` → token dari [@BotFather](https://t.me/botfather)
   - `OPENAI_API_KEY` → bebas, contoh: `aesgpt-free-key`
   - `MODE` → `proxy`
3. Run!

### Lokal
```bash
git clone https://github.com/aesneverhere/AesGPT
cd AesGPT
pip install -r requirements.txt
python main.py
