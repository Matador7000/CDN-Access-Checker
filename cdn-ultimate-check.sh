#!/bin/bash

# Colors
green="\e[32m"
red="\e[31m"
yellow="\e[33m"
reset="\e[0m"

# TCP Ports to check
ports=(80 443 8080 8443 2053 2096 2083 8880)

# CDN entries: "Name|Domain|Representative IP"
cdns=(
  "Cloudflare|cdnjs.cloudflare.com|104.16.132.229"
  "Fastly|global.ssl.fastly.net|151.101.1.57"
  "Akamai|www.akamai.com|23.54.187.158"
  "Google CDN|fonts.googleapis.com|142.250.72.234"
  "CloudFront|d1.awsstatic.com|13.224.121.102"
  "JSDelivr|cdn.jsdelivr.net|104.18.27.180"
  "Azure CDN|az416426.vo.msecnd.net|117.18.232.200"
  "StackPath|stackpath.bootstrapcdn.com|151.139.128.233"
  "BunnyCDN|bunnycdn.com|66.115.175.235"
  "QUIC.cloud|quic.cloud|78.142.29.236"
  "CDN77|cdn77.com|185.229.188.32"
  "KeyCDN|tools.keycdn.com|5.181.161.1"
  "Alibaba CDN|cdn.aliyun.com|47.246.2.233"
  "Verizon Edgecast|edgecastcdn.net|93.184.216.234"
  "Shatel CDN|cdn.shatel.ir|185.105.239.9"
  "Asiatech CDN|cdn.asiatech.ir|185.112.33.20"
  "Abarvan CDN|cdn.abarvan.com|185.143.233.2"
  "Irancell CDN|cdn.irancell.ir|217.219.65.210"
)

# Function to check ICMP (ping)
function icmp_check {
  ping -c 1 -W 2 $1 &>/dev/null
  if [ $? -eq 0 ]; then
    echo -e "${yellow}✅ ICMP Ping: Reachable${reset}"
  else
    echo -e "${red}❌ ICMP Ping: Blocked or Unreachable${reset}"
  fi
}

# Function to check TCP connectivity
function tcp_check {
  ip=$1
  port=$2
  timeout 3 bash -c "</dev/tcp/$ip/$port" &>/dev/null
  if [ $? -eq 0 ]; then
    echo -e "   ${yellow}✓ TCP $port: Open${reset}"
  else
    echo -e "   ${red}✗ TCP $port: Closed or Filtered${reset}"
  fi
}

# Function to check HTTP/HTTPS with curl
function http_check {
  domain=$1
  proto=$2
  status=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "$proto://$domain")

  if [[ "$status" == 200 || "$status" == 301 || "$status" == 302 ]]; then
    echo -e "${yellow}✅ $proto Status: $status (Accessible)${reset}"
  else
    echo -e "${red}❌ $proto Status: $status (Blocked/Failed)${reset}"
  fi
}

# Start scan
echo -e "\n🌐 CDN Access Scan Started..."
echo "==============================================================="

for entry in "${cdns[@]}"; do
  IFS="|" read -r name domain ip <<< "$entry"
  echo -e "\n🔎 Checking: ${yellow}$name${reset}"
  echo "Domain: $domain"
  echo "IP    : $ip"

  echo -n "🔁 ICMP: "; icmp_check "$ip"

  echo "📡 TCP Ports:"
  for port in "${ports[@]}"; do
    tcp_check "$ip" "$port"
  done

  echo "🌍 HTTP Tests:"
  http_check "$domain" "http"
  http_check "$domain" "https"

  echo "---------------------------------------------------------------"
done
