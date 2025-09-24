# virustotalx for endpoints 
# virustotalx for IPs (V2)
# Installation 


```
git clone https://github.com/Ankitspandey07/virustotalx_Automation.git
```

```
cd virustotalx
```


create a 3 accounts [https://www.virustotal.com/gui/join-us](https://www.virustotal.com/gui/join-us) and copy the 3 api keys ===>

```
nano orwa_3_Api_key.sh
```
&

👉 Create **10 VirusTotal accounts** [https://www.virustotal.com/gui/join-us](https://www.virustotal.com/gui/join-us) and copy the API keys.  
(You can also use fewer keys, but 10 allows better rotation and avoids hitting the rate limit.)

Edit the scripts to insert your keys:  

```
nano orwa_10_Api_key.sh
```
&

```
nano orwaV2.sh
```

paste 3 api keys here ....


```
  if [ $api_key_index -eq 1 ]; then
    api_key="key-1"
  elif [ $api_key_index -eq 2 ]; then
    api_key="key-2"
  else
    api_key="key-3"
  fi
```

**Ex**

```
  if [ $api_key_index -eq 1 ]; then
    api_key="XXXXXXXXXXXXXX1"
  elif [ $api_key_index -eq 2 ]; then
    api_key="XXXXXXXXXXXXXX2"
  else
    api_key="XXXXXXXXXXXXXX3"
  fi
```

For 10 API's Paste your API keys in the rotation section:

```bash
case $api_key_index in
  1) api_key="XXXXXXXXXXXXXX1" ;;
  2) api_key="XXXXXXXXXXXXXX2" ;;
  3) api_key="XXXXXXXXXXXXXX3" ;;
  4) api_key="XXXXXXXXXXXXXX4" ;;
  5) api_key="XXXXXXXXXXXXXX5" ;;
  6) api_key="XXXXXXXXXXXXXX6" ;;
  7) api_key="XXXXXXXXXXXXXX7" ;;
  8) api_key="XXXXXXXXXXXXXX8" ;;
  # 9) api_key="XXXXXXXXXXXXXX9" ;;   # Commented out
  # 10) api_key="XXXXXXXXXXXXXX10" ;; # Commented out
  *) api_key="XXXXXXXXXXXXXX1" ;;
esac
```
👉 You can comment/uncomment keys depending on how many you want to use.
👉 By default, 8 keys are active and 2 are commented out for future use.
```
**next step**
```
`chmod +x orwa_3_Api_key.sh` 
&
`chmod +x orwa_10_Api_key.sh` 
&
`chmod +x orwaV2.sh` 

# Usage orwa_3_Api key.sh for endpoints 

Create sub domain file `EX` ===> `subdomain.txt`  ===> `wihtout http/s` 

**===>**


```
./orwa_3_Api_key.sh subdomain.txt | tee results.txt 
```
```
./orwa_10_Api_key.sh subdomain.txt | tee results10.txt
```

**===>**


```
cat results.txt | egrep 'http|https' > endpoints.txt
```
```
cat results10.txt | egrep 'http|https' > endpoints.txt
```

# Usage orwaV2.sh for IPs (V2) 

Create IPs file `EX` ===> `all-IP-range.txt`  ===> `wihtout http/s` 

**===>**


```
./orwaV2.sh all-IP-range.txt | tee endpointsV2.txt 
```

**===>**


```
cat endpointsV2.txt | httpx -sc -title
```


