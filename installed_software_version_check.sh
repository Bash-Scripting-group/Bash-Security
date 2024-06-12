#!/bin/bash

# Function to check installed software versions
installed_software_version_check() {
    echo -e "\n\033[1;34mPerforming Installed Software Version Check...\033[0m"
    
    # Using single quotes for the PowerShell command to avoid escaping $
    outdated_packages=$(powershell.exe -Command 'Get-WmiObject -Class Win32_QuickFixEngineering | Where-Object { $_.InstalledOn -lt (Get-Date).AddMonths(-3) }')
    
    if [ -n "$outdated_packages" ]; then
        echo -e "\033[1;31mOutdated packages found:\033[0m"
        echo "$outdated_packages"
        echo "Recommendation: Update the packages using Windows Update."
    else
        echo -e "\033[1;32mAll installed software is up-to-date.\033[0m"
    fi
}

# Call the function to check installed software versions
installed_software_version_check
