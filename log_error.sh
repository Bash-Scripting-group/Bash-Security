# Function to log errors
log_error() {
  local message=$1
  echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: $message" >> "/var/log/security_audit.log"
}