#!/bin/sh

#  make_firebase.sh
#  
#
#  Created by Bonsung Koo on 28/01/2025.
#  

FILE_PATH=$CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist

echo "<?xml version="1.0" encoding="UTF-8"?>" >> $FILE_PATH
echo "<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">" >> $FILE_PATH
echo "<plist version="1.0">" >> $FILE_PATH
echo "<dict>" >> $FILE_PATH
echo "<key>CLIENT_ID</key>" >> $FILE_PATH
echo "<string>$FIREBASE_CLIENT_ID</string>" >> $FILE_PATH
echo "<key>REVERSED_CLIENT_ID</key>" >> $FILE_PATH
echo "<string>$FIREBASE_REVERSED_CLIENT_ID</string>" >> $FILE_PATH
echo "<key>API_KEY</key>" >> $FILE_PATH
echo "<string>$FIREBASE_API_KEY</string>" >> $FILE_PATH
echo "<key>GCM_SENDER_ID</key>" >> $FILE_PATH
echo "<string>$FIREBASE_GCM_SENDER_ID</string>" >> $FILE_PATH
echo "<key>PLIST_VERSION</key>" >> $FILE_PATH
echo "<string>1</string>" >> $FILE_PATH
echo "<key>BUNDLE_ID</key>" >> $FILE_PATH
echo "<string>nz.surcharges</string>" >> $FILE_PATH
echo "<key>PROJECT_ID</key>" >> $FILE_PATH
echo "<string>surcharges</string>" >> $FILE_PATH
echo "<key>STORAGE_BUCKET</key>" >> $FILE_PATH
echo "<string>$FIREBASE_STORAGE_BUCKET</string>" >> $FILE_PATH
echo "<key>IS_ADS_ENABLED</key>" >> $FILE_PATH
echo "<false></false>" >> $FILE_PATH
echo "<key>IS_ANALYTICS_ENABLED</key>" >> $FILE_PATH
echo "<false></false>" >> $FILE_PATH
echo "<key>IS_APPINVITE_ENABLED</key>" >> $FILE_PATH
echo "<true></true>" >> $FILE_PATH
echo "<key>IS_GCM_ENABLED</key>" >> $FILE_PATH
echo "<true></true>" >> $FILE_PATH
echo "<key>IS_SIGNIN_ENABLED</key>" >> $FILE_PATH
echo "<true></true>" >> $FILE_PATH
echo "<key>GOOGLE_APP_ID</key>" >> $FILE_PATH
echo "<string>$FIREBASE_GOOGLE_APP_ID</string>" >> $FILE_PATH
echo "</dict>" >> $FILE_PATH
echo "</plist>" >> $FILE_PATH