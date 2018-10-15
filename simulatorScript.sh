
#!/usr/bin/env bash

#show available iOS runtimes
xcrun simctl list runtimes -j > runtimes.json
runtimes=$(node -pe "JSON.parse(process.argv[1]).runtimes.map(x => x.name)" "$(cat runtimes.json)")
echo "Available iOS versions:\n $runtimes \n"

#get user input of iosVersion
defaultiOS='iOS 10.2'
echo "Enter iOS version, default is $defaultiOS - "
read version
iosVersion=${version:-$defaultiOS}
echo "Selected version - $iosVersion \n\n"

#show available device types
xcrun simctl list devices -j > devices.json
deviceTypes=$(node -pe "JSON.parse(process.argv[1]).devices['$iosVersion'].map(x => x.name)" "$(cat devices.json)")
echo "Available device types:\n $deviceTypes \n"

#get user input of deviceType
defaultDevice='iPhone 6s'
echo "Enter device, default is $defaultDevice - "
read deviceType
device=${deviceType:-$defaultDevice}
echo "Selected device - $device \n\n"

#Getting udid for specific ios device
udid=$(node -pe "JSON.parse(process.argv[1]).devices['$iosVersion'].find(x => x.name === '$device').udid" "$(cat devices.json)")

xcrun simctl boot $udid

defaultURL='http://localhost:3000'
echo "Enter url to open in simulator, default - $defaultURL "
read url
finalURL=${url:-$defaultURL}
xcrun simctl openurl $udid $finalURL

#Show booted devices
echo "Booted devices:\n "
xcrun simctl list devices | egrep '(Booted)'
echo "\n To shutdown devices run in terminal 'xcrun simctl shutdown all':\n "





