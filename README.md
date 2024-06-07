 Security Analysis System

This script is designed to perform various security checks on a Windows system using Bash scripting with PowerShell commands. It provides functionality to check file permissions, installed software versions, password policies, firewall status, antivirus/malware protection, and gather basic system information.

 Requirements

- Operating System: Windows (tested on Windows 10)
- Software: PowerShell must be installed and accessible from the command line.
- Permissions: The user running the script should have sufficient permissions to execute PowerShell commands.

 Usage

1. Clone or download the repository to your local machine.
2. Open a terminal or command prompt.
3. Navigate to the directory containing the script (`security_analysis_system.sh`).
4. Run the script by executing the following command:
   ```bash
   ./securityanalysis.sh
   ```
5. Follow the on-screen instructions to select the security checks you want to perform.

 Security Checks

1. File Permissions Check: Checks for world-writable files in specified directories.
2. Installed Software Version Check: Checks for outdated software packages installed on the system.
3. Password Policy Check: Evaluates the strength of a user-entered password based on certain criteria.
4. Firewall Status Check: Checks the status of firewall profiles and provides recommendations.
5. Antivirus/Malware Protection Check: Verifies the presence and status of antivirus/malware protection.
6. Basic Information Gathering: Retrieves basic system information such as OS version, hostname, uptime, logged-in user, and running processes.

 Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to open an issue or create a pull request on GitHub.

 License

This project is licensed under the [MIT License](LICENSE).

---

