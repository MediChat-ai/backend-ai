from openai import OpenAI
import os

#질문 예시
text = "족저 근막염 재활을 위해 어떤 조치를 취해야 하나요?"
#"두통이 자주 발생하는 이유가 궁금합니다. 스트레스 때문일까요, 아니면 다른 건강 문제일까요? 어떤 상황에서 두통이 심해지는지와 함께 주의할 점을 알고 싶어요."


#RUNPOD_API_KEY 설정 필요
RUNPOD_API_KEY = ""
RUNPOD_ENDPOINT_ID = ""
os.environ["RUNPOD_API_KEY"] = "RUNPOD_API_KEY"

client = OpenAI(
    api_key=os.environ.get("RUNPOD_API_KEY"),
    base_url=f"https://api.runpod.ai/v2/{RUNPOD_ENDPOINT_ID}/openai/v1"
)

MODEL_NAME = "devlim/Korea-HealthCare-RAFT-float16"

# Create a chat completion
response = client.chat.completions.create(
    model=MODEL_NAME,
    messages=[{"role": "user", "content": text}],
    temperature=0,
    max_tokens=512,
)

print(response.choices[0].message.content)