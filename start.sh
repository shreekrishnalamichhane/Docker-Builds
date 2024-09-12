#!/bin/bash

# Get the directory where the script is located
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Navigate to each directory within the base folder
for dir in "$BASE_DIR"/*/; do
    if [ -d "$dir" ]; then
        echo "=================================================="
        echo -e "\e[36mService : $dir\e[0m"
        echo "=================================================="
        cd "$dir"

        # Check if a docker-compose.yml file exists
        if [ -f "docker-compose.yml" ]; then

            # Start services in detached mode
            docker-compose up -d
            if [ $? -eq 0 ]; then
                echo -e "\e[32mSuccessfully started containers\e[0m"  # Green text
            else
                echo -e "\e[31mFailed to start containers\e[0m"  # Red text
            fi

        else
        echo -e "\e[31mNo docker-compose.yml found in $dir, skipping...\e[0m"
        fi
        
        # Return to the base directory before going to the next folder
        cd "$BASE_DIR"
    fi
done
