#!/bin/bash
# password_strength.bash - check the strength of a bash script
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

    # Check whether the password has enough figures
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
     echo -e "\033[1;32mStrong: You have a strong password\033[0m"
}

# Prompt the user for input
echo -e "\033[1;36mPlease enter a password: \033[0m"
read -s password
echo

# Call the function to check password strength
check_password_strength "$password"
}
}
