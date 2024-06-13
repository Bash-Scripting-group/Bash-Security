SECURITY ANALYSIS SYSTEM
Overview
The SECURITY ANALYSIS SYSTEM script is designed to perform various security checks on a Windows system through a Bash interface. This script leverages PowerShell commands to gather and evaluate critical system information. The checks include service status, software versions, password strength, firewall status, antivirus/malware status, basic system information, disk usage, and file encryption/decryption.

Requirements
Windows Operating System
Bash Shell (e.g., Git Bash)
PowerShell
gpg for file encryption/decryption
Basic understanding of Bash scripting and Windows PowerShell commands
Installation
Ensure that you have Git Bash or any Bash shell installed on your Windows system.
Ensure gpg (GNU Privacy Guard) is installed for file encryption and decryption tasks.
Save the script to a file, for example, security_analysis_system.sh.
Usage
Open your Bash shell.
Navigate to the directory where security_analysis_system.sh is located.
Run the script with the command:
bash
Copy code
./security_analysis_system.sh
Features
The script provides the following options in the main menu:

Critical Services Check

Checks the status of critical services: wuauserv, BITS, CryptSvc, MSIServer.
Provides recommendations if any service is not running.
Installed Software Version Check

Lists outdated packages based on their installation date.
Recommends updating the packages via Windows Update.
Password Policy Check

Evaluates user-entered password strength based on length, presence of numbers, special characters, and case sensitivity.
Provides feedback on password strength.
Firewall Status Check

Checks the status of firewall profiles: Domain, Public, and Private.
Recommends enabling any disabled firewall profiles.
Antivirus/Malware Protection Check

Checks if antivirus/malware protection is installed and running.
Provides antivirus status details and recommendations.
Basic Information Gathering

Collects and displays system information such as OS version, hostname, uptime, logged-in user, and the first 10 running processes.
Disk Usage Check

Checks disk usage of the C drive.
Alerts if the disk usage exceeds 95%.
File Encryption/Decryption

Provides options to encrypt or decrypt files on the user's Desktop.
Requires the user to select a file and confirm the operation.
Uses gpg for encryption and decryption.
Perform All Checks

Executes all the above checks sequentially.
Exit

Exits the script.
Example
Upon running the script, you will see the main menu with the above options. Select an option by entering its corresponding number. For example, to perform a Critical Services Check, enter 1 and press Enter.

bash
Copy code
Welcome to the SECURITY ANALYSIS SYSTEM!

Please select which security checks you would like to perform:
1. Critical Services Check
2. Installed Software Version Check
3. Password Policy Check
4. Firewall Status Check
5. Antivirus/Malware Protection Check
6. Basic Information Gathering
7. Disk Usage Check
8. File Encryption/Decryption
9. Perform All Checks
10. Exit

Enter the number of the check you want to perform: 1
The script will then perform the selected check and display the results.

Notes
Ensure you have the necessary permissions to run PowerShell commands and access the specified directories.
The script is designed to run in a Windows environment with a Bash shell.
Modify the MAX and DRIVE variables in the disk_usage_check function to check different drives or change the usage threshold.
License
This script is provided "as-is" without any warranties or guarantees. Use it at your own risk.
