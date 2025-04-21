# Required changed before deploy
declare ZONE="Your record's zone"
declare API_KEY="Your personal Hostinger API key"
declare DOMAIN="Your domain"
# Options changed before deploy
declare HOST="https://developers.hostinger.com"
declare API_VERSION="/api/dns/v1/zones"
declare LAST_IP_FILE="/tmp/dns_last_ip_$DOMAIN"
