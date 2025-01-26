from groq import Groq, APIConnectionError
from dotenv import load_dotenv
import os

load_dotenv()

# Access the environment variable
key = os.getenv("SAIAH_NII_MENSAH_ACC")




client = Groq(api_key=key)
completion = client.chat.completions.create(
    model="llama-3.3-70b-versatile",
    messages=[
        {
            "role": "user",
            "content": "hello fertilizer teacher"
        },
        {
            "role": "assistant",
            "content": "Hello. I'm glad you're interested in learning about fertilizers. As a knowledgeable assistant, I can provide information on various types of fertilizers, their uses, benefits, and best practices for application.\n\nTo get started, what would you like to know about fertilizers? Are you looking for information on:\n\n1. Types of fertilizers (organic, inorganic, etc.)?\n2. How to choose the right fertilizer for your plants?\n3. The benefits of using fertilizers?\n4. How to apply fertilizers safely and effectively?\n5. Something else?\n\nLet me know, and I'll be happy to help."
        },
        {
            "role": "user",
            "content": "You will teach me about fertilizers."
        },
    ],
    temperature=1,
    max_completion_tokens=1024,
    top_p=1,
    stream=True,
    stop=None,
)

for chunk in completion:
    print(chunk.choices[0].delta.content or "", end="")
