
#!/usr/bin/env bash

defaultiOS='iOS 10.2'
echo "Enter iOS version, default is $defaultiOS - "
read version
iosVersion=${version:-$defaultiOS}
echo $iosVersion


defaultDevice='iPhone 6s'
echo "Enter device, default is $defaultDevice - "
read deviceType
device=${deviceType:-$defaultDevice}
echo $device

#Getting udid for specific ios device
xcrun simctl list devices -j > devices.json
udid=$(node -pe "JSON.parse(process.argv[1]).devices['$iosVersion'].find(x => x.name === '$device').udid" "$(cat devices.json)")

xcrun simctl boot $udid

defaultURL='http://localhost:3000'
echo "Enter url to open in simulator, default - $defaultURL "
read url
finalURL=${url:-$defaultURL}
xcrun simctl openurl $udid $finalURL





