#Bumper

Bumper - is command-line tool for adding two short lines of text over the icon. It can be useful for iOS developers. When You deliver an application to your customers or QA team, it's better for them to know little bit more about your build, especially when you have more then one environment: dev, live, etc. For example You can put on application's icon version, build number and environment. 


![example](http://cdn.latyntsev.info/github/bumper/transformation.png)
![example](http://cdn.latyntsev.info/github/bumper/demo.gif)

##Install


###Requirements
- OS X 10.9 and later
- Xcode 7 and later


###Install
You can build and install the latest version by running command in the terminal app

```sh
bash <(curl -s http://cdn.latyntsev.info/github/bumper/install.sh)
```

*i have been trying add bumper to homebrew, but this is impossible because the repository is not enough old :)*


##Using

```sh
bumper -path ~/Path/to/images/ -text "1.0.4/Dev 98"
```
 

###options
- `-path` Path to a folder with images. All *.png files there will be updated, except of subfolders
- `-text` The text that should be added on the icon, You can use `\n` as a line separator. You can use maximum 2 lines and no more then 9 characters per line
- `-help --h` Show help information
- `-version --v` Show version number



##integration

###Xcode 

To display application version and build number on the icon all you have to do, just add run script build phase.

Open your project, go to **Project Target > Build Phases > Add New Runs Script Phase** 


```sh
INFO_PLIST=${CODESIGNING_FOLDER_PATH}/../${INFOPLIST_PATH}
BUILD_NUMBER=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" $INFO_PLIST)
APPLICATION_VERSION=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $INFO_PLIST)

BUMPER=true
if [ $BUMPER == true ]; then
bumper -path ${CODESIGNING_FOLDER_PATH} -text "${APPLICATION_VERSION}\n${BUILD_NUMBER}"
fi

touch ${PROJECT_DIR}/ **(path icon to assets)** /Assets.xcassets/AppIcon.appiconset/*
```

Also in **Example** folder You can find an example how to integrate bumper with multiple environments 

###fastlane
Work in progress

##License

Code is under the MIT license