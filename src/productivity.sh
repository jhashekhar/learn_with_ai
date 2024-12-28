#!/bin/bash

# Source the .env file
source "$(dirname "$0")/../config/.env.production"

check_dependencies() {
    # Check for required dependencies
    if ! command -v jq &> /dev/null; then
        echo "Error: jq is not installed. Please install jq to use this script."
        exit 1
    fi

    if ! command -v curl &> /dev/null; then
        echo "Error: curl is not installed. Please install curl to use this script."
        exit 1
    fi
}

chat() {
    while true; do
        echo "Hello, Shekhar, Enter your question"
        read user_question

        # Check if the user wants to exit
        if [ "$user_question" == "exit" ]; then
            echo "Goodbye!"
            break
        fi

        curl https://api.anthropic.com/v1/messages \
            --header "x-api-key: $ANTHROPIC_API_KEY" \
            --header "anthropic-version: 2023-06-01" \
            --header "content-type: application/json" \
            --data \
        '{
            "model": "claude-3-5-sonnet-20241022",
            "max_tokens": 1024,
            "messages": [
                {"role": "user", "content": "'"$user_question"'"}
            ]
        }' | jq -r '.content[0].text' | echo -e "$(cat -)"
    done
}


check_dependencies
chat
