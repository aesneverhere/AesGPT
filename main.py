from aiogram import Bot, Dispatcher, types, executor
from config import BOT_TOKEN, OPENAI_API_KEY, MODE
from utils.gpt import get_gpt_response

bot = Bot(token=BOT_TOKEN, parse_mode="Markdown")
dp = Dispatcher(bot)

# Simpan percakapan per user (context memory lokal)
user_context = {}

@dp.message_handler(commands=['start'])
async def start(msg: types.Message):
    name = msg.from_user.first_name or "teman"
    text = (
        f"👋 Hai *{name}*!\n\n"
        "Aku *aesGPTbot*, versi mini dari ChatGPT yang bisa kamu ajak ngobrol langsung di sini.\n"
        "Cukup kirim aja pertanyaan atau cerita kamu, dan aku bakal bantu sebisaku.\n\n"
        "_Gunakan perintah /reset kalau mau mulai percakapan baru ya!_"
    )
    await msg.reply(text)

@dp.message_handler(commands=['reset'])
async def reset(msg: types.Message):
    user_context[msg.from_user.id] = []
    await msg.reply("✅ Context obrolan kamu udah aku reset ya. Yuk mulai ngobrol dari awal!")

@dp.message_handler()
async def handle_message(msg: types.Message):
    uid = msg.from_user.id
    user_context.setdefault(uid, [])
    user_context[uid].append({"role": "user", "content": msg.text})

    reply = await get_gpt_response(user_context[uid], OPENAI_API_KEY, MODE)
    user_context[uid].append({"role": "assistant", "content": reply})

    await msg.reply(reply)
