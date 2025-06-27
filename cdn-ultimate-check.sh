#!/bin/bash

# Safe and robust CDN access checker

# Color codes
YELLOW="\033[1;33m"
RED="\033[1;31m"
NC="\033[0m"

# Timeout duration
TIMEOUT=5

# CDN list: name, domain, IP
CDN_LIST=(
  "Cloudflare,cloudflare.com,104.16.132.229"
  "Fastly,fastly.com,151.101.1.57"
  "Akamai,akamai.com,23.48.139.7"
  "Google CDN,google.com,172.217.16.206"
  "Amazon CloudFront,cloudfront.net,13.224.161.43"
  "BunnyCDN,bunnycdn.com,92.223.66.43"
  "Shatel CDN,cdn.shatel.ir,185.105.239.2"
  "Asiatech CDN,cdn.asiatech.ir,185.49.85.2"
  "MihanWeb CDN,mcdn.ir,185.143.233.2"
  "ArvanCloud,arvancloud.com,185.143.233.7"
  "CDN77,cdn77.com,185.136.96.96"
  "KeyCDN,keycdn.com,5.9.88.169"
  "StackPath,stackpath.com,151.139.128.10"
  "Tencent CDN,cdn.tencent.com,183.3.226.35"
  "Netlify,netlify.com,75.2.60.5"
  "Gcore CDN,gcdn.co,92.223.64.52"
  "Quic.cloud,quic.cloud,172.66.0.90"
  "Microsoft Azure CDN,azureedge.net,72.21.81.200"
)

# Ports to test
PORTS=(80 443 8080 2053)

# Function to test TCP connection
check_tcp() {
  local ip=$1
  local port=$2
  timeout 3 bash -c "echo > /dev/tcp/$ip/$port" 2>/dev/null
  return $?
}

# Function to test curl HTTP(S)
check_http() {
  local domain=$1
  timeout $TIMEOUT curl -s --connect-timeout 3 -m $TIMEOUT -I http://$domain >/dev/null
  return $?
}

echo -e "${YELLOW}Starting CDN check...${NC}"

for cdn in "${CDN_LIST[@]}"; do
  IFS=',' read -r name domain ip <<< "$cdn"
  echo -e "\nChecking ${name} (${domain} | ${ip})"

  # Ping test
  if timeout 3 ping -c 1 -W 2 "$domain" >/dev/null 2>&1; then
    echo -e "${YELLOW}ICMP ping to $domain: OK${NC}"
  else
    echo -e "${RED}ICMP ping to $domain: FAILED${NC}"
  fi

  # TCP port tests
  for port in "${PORTS[@]}"; do
    if check_tcp "$ip" "$port"; then
      echo -e "${YELLOW}TCP port $port to $ip: OPEN${NC}"
    else
      echo -e "${RED}TCP port $port to $ip: BLOCKED${NC}"
    fi
  done

  # HTTP(S) test
  if check_http "$domain"; then
    echo -e "${YELLOW}HTTP/HTTPS to $domain: SUCCESS${NC}"
  else
    echo -e "${RED}HTTP/HTTPS to $domain: FAILED${NC}"
  fi
done

echo -e "\n${YELLOW}CDN check completed.${NC}"
