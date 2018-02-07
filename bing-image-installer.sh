#!/bin/bash
# AUTHOR
# 	andreevela@gmail.com

# Configuration
PLIST_NAME='com.miami.utils.BingDailyImage.plist';
PLIST_DIR='/Library/LaunchAgents/';
SCRIPT_NAME='com.miami.utils.BingDailyImage.sh';
SCRIPT_DIR='/Library/Application Scripts/';

echo 'Installing launchd angent file.'

echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
	<dict>
		<key>Label</key>
		<string>com.miami.utils.BingDailyImage-1.0</string>

		<key>ProgramArguments</key>
		<array>
			<string>'$HOME$SCRIPT_DIR$SCRIPT_NAME'</string>
			<string>Pictures/Bing</string>
		</array>

		<key>StandardOutPath</key>
		<string>/tmp/bingDailyImage.stdout</string>

		<key>StandardErrorPath</key>
		<string>/tmp/bingDailyImage.stderr</string>

		<key>RunAtLoad</key>
		<true/>

		<key>StartInterval</key>
		<integer>3600</integer>
	</dict>
</plist>' > "$HOME$PLIST_DIR$PLIST_NAME";

echo 'Angent file installed.';
echo 'Installing bash script.';

# mv "./$SCRIPT_NAME" "$HOME$SCRIPT_DIR$SCRIPT_NAME"
echo "# andreevela@gmail.com
#
# NAME
# 		bing-image - Downloads and saves the bing daily image
#
# SYNOPSIS
# 		bing-image directory
#
# DESCRIPTION
# 		The bing image utility downloads the daily image of the
# 		bing search main page and saves it to the specified
# 		directory.
#
# 		The directory argument is relative to the user HOME, so
# 		not necesary to prepend the ~ character.
#
# 		This utility is ideal to use with a agent to automatically
# 		download the image every day.
#

# http://dailyraisin.com/read-json-value-in-bash/
function readJson {
	UNAMESTR=\`uname\`
	if [[ \"\$UNAMESTR\" == 'Linux' ]]; then
		SED_EXTENDED='-r'
	elif [[ \"\$UNAMESTR\" == 'Darwin' ]]; then
		SED_EXTENDED='-E'
	fi;

	VALUE=\`grep -m 1 \"\\\"\${2}\\\"\" \${1} | sed \${SED_EXTENDED} 's/^ *//;s/.*: *\"//;s/\",?//'\`

	if [ ! \"\$VALUE\" ]; then
		echo \"Error: Cannot find \\\"\${2}\\\" in \${1}\" >&2;
		exit 1;
	else
		echo \$VALUE ;
	fi;
}

IMG_WS='https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1';
TMP_FILE='bing-image.json';
IMG_DIR='/'\${1:-'Pictures/Bing/'};
BING_DOMAIN='https://www.bing.com/'

mkdir -p \$HOME\$IMG_DIR; # creates the directory structure
cd \$HOME\$IMG_DIR; # move to specified folder
curl -X GET \$IMG_WS | # download the data from bing
sed -e 's/,/\'$'\n/g' > \$TMP_FILE; # split the response in several lines
URI=\`readJson \$TMP_FILE url\` || exit 1; # parse lines to find the image uri
curl -O -X GET \$BING_DOMAIN\$URI; # download the image
rm \$TMP_FILE; # delete temp file
" > "$HOME$SCRIPT_DIR$SCRIPT_NAME";
chmod +x "$HOME$SCRIPT_DIR$SCRIPT_NAME";
launchctl load -w "$HOME$PLIST_DIR$PLIST_NAME";

echo 'Bash script installed';
echo 'Installation completed successfully.'