#!/bin/bash

# Configuration
PLIST_NAME='com.miami.utils.BingDailyImage.plist';
PLIST_DIR='/Library/LaunchAgents/';
SCRIPT_NAME='com.miami.utils.BingDailyImage.sh';
SCRIPT_DIR='/Library/Application Scripts/';

rm "$HOME$SCRIPT_DIR$SCRIPT_NAME";
launchctl unload "$HOME$PLIST_DIR$PLIST_NAME";
rm "$HOME$PLIST_DIR$PLIST_NAME";

echo 'Uninstalled successfully';