#!/bin/sh

#  make_firebase.sh
#  
#
#  Created by Bonsung Koo on 28/01/2025.
#  

echo "<?xml version="1.0" encoding="UTF-8"?>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<plist version="1.0">" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<dict>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>CLIENT_ID</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<string>$FIREBASE_CLIENT_ID</string>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>REVERSED_CLIENT_ID</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<string>$FIREBASE_REVERSED_CLIENT_ID</string>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>API_KEY</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<string>$FIREBASE_API_KEY</string>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>GCM_SENDER_ID</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<string>$FIREBASE_GCM_SENDER_ID</string>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>PLIST_VERSION</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<string>1</string>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>BUNDLE_ID</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<string>nz.surcharges</string>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>PROJECT_ID</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<string>surcharges</string>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>STORAGE_BUCKET</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<string>$FIREBASE_STORAGE_BUCKET</string>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>IS_ADS_ENABLED</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<false></false>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>IS_ANALYTICS_ENABLED</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<false></false>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>IS_APPINVITE_ENABLED</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<true></true>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>IS_GCM_ENABLED</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<true></true>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>IS_SIGNIN_ENABLED</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<true></true>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<key>GOOGLE_APP_ID</key>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "<string>$FIREBASE_GOOGLE_APP_ID</string>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "</dict>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist
echo "</plist>" >> $CI_PRIMARY_REPOSITORY_PATH/Surcharges/Applications/Resources/Prod/GoogleService-Info.plist