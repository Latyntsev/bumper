#Bumper

Bumper - is command line tool for adding two short lines of text over the icon. It can be useful for iOS developers. When You deliver an application to your customers or QA team, it's better for them to know little bit more about your build, especially when you have more then one environment: dev, live, etc. For example You can put on application's icon version, build number and environment. 


![example](http://cdn.latyntsev.info/github/bumper/transformation.png)

##Install


###Requirements
- OS X 10.9  and later
- [Homebrew](http://brew.sh)



###Install
You can install latest version via homebrew, `brew install bumper`


##Using

```sh
bumper -path ~/Path/to/images/ -text "1.0.4/Dev 98"
```


###options
- ``-path`` Path to a folder with images. All *.png files there will be updated, exept of subfolders
- `-text` The text that should be added on the icon, You can use `\n` as a line separator. You can use maximum 2 lines and no more then 9 characters per line
- `-help --h` Show help information
- `-version --v` Show version number

##License

Code is under the MIT license