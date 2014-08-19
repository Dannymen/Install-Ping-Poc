Install-Ping-Poc
================
#!/bin/sh

# This Bash shell script isntalls both apps for CS and both apps for SIM
# on all USB connected tablets. It scans for android devices via ADB and
# installs the EMKI software on them
#
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
PACKAGES=(emki_host-)

# add file names under gradlew
./gradlew \


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
