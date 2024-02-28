#!/bin/bash

# The directory to monitor
DIRECTORY_TO_MONITOR="./"

# Function to run when changes are detected
on_change() {
    echo "Change detected, running run.sh..."
    ./run.sh
}

# Monitor changes in the directory
inotifywait -m -e modify,create,delete -r "$DIRECTORY_TO_MONITOR" --format '%w%f' | while read FILE
do
    if [[ $FILE =~ \.c$ ]] || [[ $FILE =~ \.h$ ]]; then
        on_change
    fi
done

