
#!/usr/bin/env bash

CYAN='\033[1;36m'
GREEN='\033[0;32m'
WHITE='\033[1;37m'

#show available iOS runtimes
runtimes=$(node -pe "JSON.parse(process.argv[1]).runtimes.map(x => x.name)" "$(xcrun simctl list runtimes -j)")
echo "${GREEN}Available iOS versions:\n $runtimes \n"

#get user input of iosVersion
defaultiOS='iOS 10.2'
echo "${CYAN}Enter iOS version, default is $defaultiOS - ${WHITE}"
read version
iosVersion=${version:-$defaultiOS}
echo "${GREEN}Selected version - $iosVersion \n\n"

#show available device types
deviceTypes=$(node -pe "JSON.parse(process.argv[1]).devices['$iosVersion'].map(x => x.name)" "$(xcrun simctl list devices -j)")
echo "${GREEN}Available device types:\n $deviceTypes \n"

#get user input of deviceType
defaultDevice='iPhone 6s'
echo "${CYAN}Enter device, default is $defaultDevice - ${WHITE}"
read deviceType
device=${deviceType:-$defaultDevice}
echo "${GREEN}Selected device - $device \n\n"

#Getting udid for specific ios device
udid=$(node -pe "JSON.parse(process.argv[1]).devices['$iosVersion'].find(x => x.name === '$device').udid" "$(xcrun simctl list devices -j)")

xcrun simctl boot $udid

defaultURL='http://localhost:3000'
echo "${CYAN}Enter url to open in simulator, default - $defaultURL ${WHITE}"
read url
finalURL=${url:-$defaultURL}
xcrun simctl openurl $udid $finalURL

#Show booted devices
echo "${GREEN}Booted devices:\n "
xcrun simctl list devices | egrep '(Booted)'
echo "${CYAN}\n To shutdown devices run in terminal ${GREEN}'xcrun simctl shutdown all'\n "





