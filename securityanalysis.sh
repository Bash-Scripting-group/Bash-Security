#!/bin/bash

# Function to check file permissions
file_permissions_check() {
    clear
    echo -e "\n\033[1;34mPerforming File Permissions Check...\033[0m"
    directories=("C:\\Windows" "C:\\Program Files" "C:\\Users")
    issues_found=false

    for dir in "${directories[@]}"; do
        echo -e "\nChecking directory: \033[1;33m$dir\033[0m"
        world_writable_files=$(powershell.exe -Command "Get-ChildItem -Path '$dir' -Recurse -ErrorAction SilentlyContinue | Where-Object {($_.GetAccessControl().Access | Where-Object { \$_.FileSystemRights -eq 'FullControl' -and \$_.IdentityReference -eq 'Everyone' }).Count -gt 0}")
        
        if [ -n "$world_writable_files" ]; then
            issues_found=true
            echo -e "\033[1;31mWorld-writable files found in $dir:\033[0m"
            echo "$world_writable_files"
        else
            echo -e "\033[1;32mNo world-writable files found in $dir.\033[0m"
        fi
    done

    if [ "$issues_found" = true ]; then
        echo -e "\n\033[1;31mSome files have permissions that are too permissive.\033[0m"
        echo "Recommendation: Modify permissions to restrict write access."
    else
        echo -e "\n\033[1;32mFile Permissions Check passed. No overly permissive files found.\033[0m"
    fi
}

# Function to check installed software versions
installed_software_version_check() {
    clear
    echo -e "\n\033[1;34mPerforming Installed Software Version Check...\033[0m"
    outdated_packages=$(powershell.exe -Command "Get-WmiObject -Class Win32_QuickFixEngineering | Where-Object { \$_.InstalledOn -lt (Get-Date).AddMonths(-3) }")
    
    if [ -n "$outdated_packages" ]; then
        echo -e "\033[1;31mOutdated packages found:\033[0m"
        echo "$outdated_packages"
        echo "Recommendation: Update the packages using Windows Update."
    else
        echo -e "\033[1;32mAll installed software is up-to-date.\033[0m"
    fi
}

# Function to check password policy by evaluating user-entered password strength
password_policy_check() {
    clear
    echo -e "\n\033[1;34mPerforming Password Policy Check...\033[0m"

    # Function to check password strength
    check_password_strength(){
        password="$1"

        # Check password length
        if [ ${#password} -lt 8 ]; then
            echo -e "\033[1;31mWeak: Password is too short (less than 8 characters)\033[0m"
            return
        fi

        # Check for the presence of numbers
        if ! [[ "$password" =~ [0-9] ]]; then
            echo -e "\033[1;31mWeak: Password must contain at least one number\033[0m"
            return
        fi

        # Check for the presence of special characters
        if ! [[ "$password" =~ [!@#\$%^*] ]]; then
            echo -e "\033[1;31mWeak: Password must contain at least one special character (!@#\$%^&*)\033[0m"
            return
        fi

        # Check for uppercase and lowercase letters
        if ! [[ "$password" =~ [a-z] && "$password" =~ [A-Z] ]]; then
            echo -e "\033[1;31mWeak: Password must contain both uppercase and lowercase letters\033[0m"
            return
        fi

        # If none of the above conditions are met, the password is strong
        echo -e "\033[1;32mStrong: Password meets cybersecurity criteria\033[0m"
    }

    # Prompt the user for input
    echo -e "\033[1;36mPlease enter a password: \033[0m"
    read -s password
    echo

    # Call the function to check password strength
    check_password_strength "$password"
}

# Function to check firewall status
firewall_status_check() {
    clear
    echo -e "\n\033[1;34mPerforming Firewall Status Check...\033[0m"
    firewall_status=$(powershell.exe -Command "Get-NetFirewallProfile -Profile Domain,Public,Private | Select-Object -Property Name,Enabled")
    
    echo -e "\033[1;36mFirewall Status:\033[0m"
    echo "$firewall_status"

    if [[ "$firewall_status" == *"False"* ]]; then
        echo -e "\033[1;31mSome firewall profiles are disabled.\033[0m"
        echo "Recommendation: Ensure that all firewall profiles are enabled."
    else
        echo -e "\033[1;32mAll firewall profiles are enabled.\033[0m"
    fi
}

# Function to check antivirus/malware protection
antivirus_malware_check() {
    clear
    echo -e "\n\033[1;34mPerforming Antivirus/Malware Protection Check...\033[0m"
    av_status=$(powershell.exe -Command "Get-MpComputerStatus")
    if [ -n "$av_status" ]; then
        echo -e "\033[1;32mAntivirus/Malware protection is installed and running.\033[0m"
        echo "Details:"
        echo "$av_status"
        echo "Recommendation: Ensure antivirus definitions are up to date."
    else
        echo -e "\033[1;31mNo Antivirus/Malware protection found.\033[0m"
        echo "Recommendation: Install and configure antivirus/malware protection software."
    fi
}

# Function to gather basic system information
basic_info_gathering() {
    clear
    echo -e "\n\033[1;34mGathering Basic System Information...\033[0m"
    os_version=$(powershell.exe -Command "(Get-WmiObject -Class Win32_OperatingSystem).Version")
    hostname=$(powershell.exe -Command "hostname")
    boot_time=$(powershell.exe -Command "(Get-WmiObject -Class Win32_OperatingSystem).LastBootUpTime")
    logged_in_user=$(powershell.exe -Command "whoami")
    running_processes=$(powershell.exe -Command "Get-Process | Select-Object -First 10")

    # Calculate the system uptime in a readable format
    current_time=$(powershell.exe -Command "Get-Date -Format 'yyyy-MM-ddTHH:mm:ss'")
    boot_time=$(powershell.exe -Command "(Get-WmiObject -Class Win32_OperatingSystem).ConvertToDateTime((Get-WmiObject -Class Win32_OperatingSystem).LastBootUpTime)")

    # Convert times to Unix timestamps
    current_time_unix=$(date -d "$current_time" +%s)
    boot_time_unix=$(date -d "$boot_time" +%s)

    # Calculate uptime in seconds
    uptime_seconds=$((current_time_unix - boot_time_unix))
    uptime=$(printf '%d days %02d hours %02d minutes %02d seconds\n' $(($uptime_seconds/86400)) $(($uptime_seconds%86400/3600)) $(($uptime_seconds%3600/60)) $(($uptime_seconds%60)))

    echo -e "\033[1;36mOperating System Version:\033[0m $os_version"
    echo -e "\033[1;36mHostname:\033[0m $hostname"
    echo -e "\033[1;36mSystem Uptime:\033[0m $uptime"
    echo -e "\033[1;36mLogged-in User:\033[0m $logged_in_user"
    echo -e "\033[1;36mRunning Processes (First 10):\033[0m"
    echo "$running_processes"
}

# Function to return to main menu
return_to_menu() {
    read -p "Press Enter to return to the main menu..."
}

# Main script loop
while true; do
    clear
    # Welcome message
    echo -e "\033[1;35mWelcome to the SECURITY ANALYSIS SYSTEM!\033[0m"

    # Menu of security checks
    echo -e "\n\033[1;36mPlease select which security checks you would like to perform:\033[0m"
    echo -e "1. File Permissions Check"
    echo -e "2. Installed Software Version Check"
    echo -e "3. Password Policy Check"
    echo -e "4. Firewall Status Check"
    echo -e "5. Antivirus/Malware Protection Check"
    echo -e "6. Basic Information Gathering"
    echo -e "7. Perform All Checks"
    echo -e "8. Exit"

    # User input prompt
    read -p "Enter the number of the check you want to perform: " selection

    # Execute selected check
    case $selection in
        1) file_permissions_check; return_to_menu ;;
        2) installed_software_version_check; return_to_menu ;;
        3) password_policy_check; return_to_menu ;;
        4) firewall_status_check; return_to_menu ;;
        5) antivirus_malware_check; return_to_menu ;;
        6) basic_info_gathering; return_to_menu ;;
        7) 
            file_permissions_check; return_to_menu
            installed_software_version_check; return_to_menu
            password_policy_check; return_to_menu
            firewall_status_check; return_to_menu
            antivirus_malware_check; return_to_menu
            basic_info_gathering; return_to_menu
            ;;
        8) echo "Exiting the script. Goodbye!"; exit 0 ;;
        *) echo -e "\033[1;31mInvalid selection: $selection\033[0m"; return_to_menu ;;
    esac
done
