#!/bin/bash

# Function to fetch and display undetected URLs for a domain
fetch_undetected_urls() {
  local domain=$1
  local api_key_index=$2
  local api_key

  case $api_key_index in
    1) api_key="key-1" ;;
    2) api_key="key-2" ;;
    3) api_key="key-3" ;;
    4) api_key="key-4" ;;
    5) api_key="key-5" ;;
    6) api_key="key-6" ;;
    7) api_key="key-7" ;;
    8) api_key="key-8" ;;
    # 9) api_key="key-9" ;;   # Commented out
    # 10) api_key="key-10" ;; # Commented out
    *) api_key="key-1" ;;
  esac

  local URL="https://www.virustotal.com/vtapi/v2/domain/report?apikey=$api_key&domain=$domain"

  echo -e "\nFetching data for domain: \033[1;34m$domain\033[0m (using API key $api_key_index)"
  response=$(curl -s "$URL")
  if [[ $? -ne 0 ]]; then
    echo -e "\033[1;31mError fetching data for domain: $domain\033[0m"
    return
  fi

  undetected_urls=$(echo "$response" | jq -r '.undetected_urls[][0]')
  if [[ -z "$undetected_urls" ]]; then
    echo -e "\033[1;33mNo undetected URLs found for domain: $domain\033[0m"
  else
    echo -e "\033[1;32mUndetected URLs for domain: $domain\033[0m"
    echo "$undetected_urls"
  fi
}

# Function to display a countdown
countdown() {
  local seconds=$1
  while [ $seconds -gt 0 ]; do
    echo -ne "\033[1;36mWaiting for $seconds seconds...\033[0m\r"
    sleep 1
    : $((seconds--))
  done
  echo -ne "\033[0K"  # Clear the countdown line
}

# Check if an argument is provided
if [ -z "$1" ]; then
  echo -e "\033[1;31mUsage: $0 <domain or file_with_domains>\033[0m"
  exit 1
fi

# Initialize variables for API key rotation
api_key_index=1
request_count=0
max_keys=8  # Only 8 keys active (2 commented out)

# Check if the argument is a file
if [ -f "$1" ]; then
  while IFS= read -r domain; do
    # Remove the scheme (http:// or https://) if present
    domain=$(echo "$domain" | sed 's|https\?://||')
    fetch_undetected_urls "$domain" $api_key_index
    countdown 20

    # Increment the request count and switch API key if needed
    request_count=$((request_count + 1))
    if [ $request_count -ge 5 ]; then
      request_count=0
      api_key_index=$((api_key_index + 1))
      if [ $api_key_index -gt $max_keys ]; then
        api_key_index=1
      fi
    fi
  done < "$1"
else
  # Argument is not a file, treat it as a single domain
  domain=$(echo "$1" | sed 's|https\?://||')
  fetch_undetected_urls "$domain" $api_key_index
fi

echo -e "\033[1;32mAll done!\033[0m"
