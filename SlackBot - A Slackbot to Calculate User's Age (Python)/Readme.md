# SlackBot - A Slackbot to Calculate User's Age (Python)

Description:

AgeBot is a Slack bot built with Python that calculates the age based on the provided date input.
It integrates with the Slack platform to receive messages, parse the input dates, perform age calculations, and respond with the calculated ages.

Features:

    Real-time interaction: AgeBot listens for incoming messages in Slack and responds with the calculated age.
    Date parsing: It parses the input date using the datetime.strptime function.
    Age calculation: It calculates the age based on the parsed input date and the current date.
    Slack integration: AgeBot uses the Slack API and the slack_sdk library to communicate with Slack and send messages.

Setup Instructions:

    Create a Slack workspace and set up a new Slack app.
    Obtain the Bot User OAuth Access Token and App-Level Token from the Slack app's settings.
    Clone the AgeBot repository from GitHub.
    Update the code with the obtained tokens in the slack_bot_token and slack_app_token variables.
    Install the necessary dependencies, including the slack_sdk library.
    Run the code using Python to start the AgeBot.
    Add the AgeBot to your Slack workspace and configure its permissions.
    Interact with the AgeBot by sending messages containing the keyword "age" followed by a date in the format "YYYY-MM-DD".

Folder Structure:

    main.py: The main Python script containing the AgeBot logic.
    README.md: Detailed instructions and information about the AgeBot project.

Contributing:

    Fork the repository, make changes, and submit a pull request for review.
    Report any issues or bugs by opening an issue on the GitHub repository.
