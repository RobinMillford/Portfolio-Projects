import os
from slack_sdk import WebClient
from slack_sdk.rtm import RTMClient
from datetime import datetime

slack_bot_token = ''
slack_app_token = ''
client = WebClient(token=slack_bot_token)

def calculate_age(input_date):
    today = datetime.today()
    input_date = datetime.strptime(input_date, '%Y-%m-%d')
    age = today.year - input_date.year
    if today.month < input_date.month or (today.month == input_date.month and today.day < input_date.day):
        age -= 1
    return age

@RTMClient.run_on(event='message')
def handle_message(**payload):
    data = payload['data']
    if 'text' in data:
        text = data['text']
        if 'age' in text.lower():
            input_date = text.split('age ')[1]
            age = calculate_age(input_date)
            message = f"Your age is {age}!"
            client.chat_postMessage(channel=data['channel'], text=message)

def start_rtm_client():
    rtm_client = RTMClient(token=slack_app_token)
    rtm_client.start()

if __name__ == '__main__':
    start_rtm_client()
