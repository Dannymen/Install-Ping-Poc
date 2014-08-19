Install-Ping-Poc
================
#!/bin/sh

# This Bash shell script isntalls the Ping Poc app to run in conjuction with IP test
# just does it on a large scale
# Danny Mendoza <danny.mendoza@controlgroup.com>
# Adapted from a script written by
# Chris Ross <chris.ross@controlgroup.com>
# Dan Meltz <dan.meltz@controlgroup.com>

if [ $# -eq 0 ]
  then
    echo "No <interface> argument detected. Please specify one such as 'wlan0'"
    exit
fi

interface=$1 # the first argument should be the interface name
APK_PATH="emki_host/build/apk"

# here go the actual apps.. the path for the apks is right above here so I guess place apk there
PACKAGES=(emki_host-app-release-unsigned.apk)

# add file names under gradlew
./gradlew \
assemblePingPocApp


scanDevices() {
  echo "scanning for devices...\n"
  devices=$(adb devices | awk 'BEGIN{
    FS="\t";
    OFS=" ";
  }
  {
    if (NR != 1) {
      print $1
    }
  }
  END{

  }')
}

installinate() {
for CURRENT_DEVICE in "${devicesArr[@]}"
do
  for CURRENT_PKG in "${PACKAGES[@]}"
  do
    #NOW="$APK_PATH/${PACKAGES[1]}"
    echo "\n---Deleting old data from $CURRENT_PKG from $CURRENT_DEVICE"
    adb -s $CURRENT_DEVICE uninstall $CURRENT_PKG
    echo "\n+++Installing new instance of $CURRENT_PKG on $CURRENT_DEVICE"
    adb -s $CURRENT_DEVICE install "$APK_PATH/$CURRENT_PKG"
  done
done
}

scanDevices
declare -a devicesArr=($devices)
installinate
