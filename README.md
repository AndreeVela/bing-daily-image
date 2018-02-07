Bing Daily Image
=================================
This is an installable MacOS service that download the bing image of the day and save it in a local folder. This is intented to be used along with the configuration of dynamic wallpaper to have a daily gorgeous wallpaper in your macbook.

I come from a windows enviroment and I really love the spotlight and bing photographs, they are really gorgeous. But in Mac I cound't find an easy way to get any of that photos and usit as wallpapers so ... I made this service.

Any comments are welcome.

Install
---------------------------------
Use the file bing-image-installer.sh to install the service. Could be necesary to set execution permissions:

```
cd /path/to/file
chmod +x bing-image-installer.sh
./bing-image-installer.sh
```

Config
---------------------------------
To configure the service you have to edit the file `~/Library/LaunchAgents/com.miami.utils.BingDailyImage.plist`.

### Destination Folder
To change the destination folder for the downloaded images change this lines:

```
<key>ProgramArguments</key>
<array>
	<string>'$HOME$SCRIPT_DIR$SCRIPT_NAME'</string>
	<string>Pictures/Bing</string>
</array>
```

By default the images are saved in `Pictures/Bing`. You can use any path relative to your user home folder.

### Start Interval
To change how frequently fetch for new images change this lines:

```
<key>StartInterval</key>
<integer>3600</integer>
```

The integer value represents the seconds to wait to check again for a new image. The default value is 1 hour. You can set any seconds you want.

__Note:__  Bing changes the image just once per day, but the service checks every hour in case it fails to get the image due to internet connection issues or any other problem. If the image already exists, this will be overrided so, don't worry for duplicated.

Uninstall
---------------------------------
Use the file bing-image-uninstaller.sh to remove the service. Could be necesary to set execution permissions:

```
cd /path/to/file
chmod +x bing-image-uninstaller.sh
./bing-unimage-installer.sh
```
