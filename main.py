from aiogram import Bot, Dispatcher, types, executor
from config import BOT_TOKEN, OPENAI_API_KEY
from utils.gpt import get_gpt_response

bot = Bot(token=BOT_TOKEN)
dp = Dispatcher(bot)

user_context = {}  # Simpan percakapan per user (sesi lokal)

@dp.message_handler(commands=['start'])
async def start(msg: types.Message):
    await msg.reply("👋 Hai! Aku aesGPTbot. Kirim pertanyaan apa pun, dan aku akan jawab menggunakan ChatGPT.\n\nKetik /reset untuk mulai ulang.")

@dp.message_handler(commands=['reset'])
async def reset(msg: types.Message):
    user_context[msg.from_user.id] = []
    await msg.reply("✅ Context percakapan telah direset.")

@dp.message_handler()
async def chat(msg: types.Message):
    uid = msg.from_user.id
    user_context.setdefault(uid, [])
    user_context[uid].append({"role": "user", "content": msg.text})

    reply = await get_gpt_response(user_context[uid], OPENAI_API_KEY)
    user_context[uid].append({"role": "assistant", "content": reply})

    await msg.reply(reply)

if __name__ == '__main__':
    executor.start_polling(dp, skip_updates=True)
