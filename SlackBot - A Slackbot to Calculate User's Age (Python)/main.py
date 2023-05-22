import os
from slack_sdk import WebClient
from slack_sdk.rtm import RTMClient
from datetime import datetime

slack_bot_token = 'xoxb-5314817250849-5326501127008-1WQrCmaI4d5bgqaTjku3mREN'
slack_app_token = 'xapp-1-A058T88BRNH-5326529475120-7813dbd44a68ba3f81cc1180f73fd9f822765533d661892d53ddbe166edb1d9a'
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