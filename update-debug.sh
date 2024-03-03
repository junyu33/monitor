#!/bin/bash

# Static first argument
configFile="analysis.conf"

# Second argument controlled by the user input
debugValue="$1"

if [ -z "$debugValue" ]; then
    echo "Usage: $0 <debugValue>"
    exit 1
fi

# Example function to update the config file
updateConfig() {
    # Assuming you're setting a debug level or similar in the config
    # Adjust the command according to how you actually need to update the file
    sed -i "/^debug = /s/=.*/= $debugValue/" "$configFile"
}

# Call the update function
updateConfig

echo "Config updated with debug=$debugValue"

