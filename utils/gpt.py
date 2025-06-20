import aiohttp

async def get_gpt_response(messages, api_key, mode="proxy"):
    url = "https://api.aiproxy.io/v1/chat/completions" if mode == "proxy" else "https://api.openai.com/v1/chat/completions"

    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {api_key}"
    }

    payload = {
        "model": "gpt-3.5-turbo",
        "messages": messages
    }

    try:
        async with aiohttp.ClientSession() as session:
            async with session.post(url, headers=headers, json=payload) as resp:
                data = await resp.json()
                return data["choices"][0]["message"]["content"].strip()
    except Exception as e:
        return f"⚠️ Maaf, ada error: `{str(e)}`"
