![Vuxiz Connectivity](https://d5zmsof142f36.cloudfront.net/images/vuzix-logo.png)

Vuzix Connectivity framework allows iOS apps to share the BLE connnection to communicate with apps that are running on the Vuzix Blade.  There is no need to pair the BLE connection, as the framework uses the same BLE connection established and setup in the Vuzix Companion App.  There is also no need to define a protocol model as we have already done that.  You can send simple messages between Blade and your iPhone app seemlessly.    Apps running on the Vuzix Blade will need to utilize the Vuzix Android Connectivity library.   Since messages are sent as BLE messages, it is best to send smaller messages as throughput is limited when using BLE.


## Requirements

- Blade OS 2.10 or higher
- Latest version of Vuzix Companion app running on iPhone [App Store](https://apps.apple.com/us/app/id1383316233)
- App running on Blade must use the [Android Connectivity SDK](https://www.vuzix.com/Developer/KnowledgeBase/Detail/1098)
- Blade and Companion app must be linked.


## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Vuzix Connectivity into your Xcode project using CocoaPods, specify it in your `Podfile`:

```swift
pod 'VuzixConnectivity'
```

### Manually

If you prefer to not use Cocoapods, then you can integrate the Vuzix Connectivity framework into your project manually. 

Simply download the framework from [Vuzix's github page](https://github.com/Vuzix/VuzixConnectivity): and follow the steps below:
* Unzip framework
* Drag the VuzixConnectivity.framework into your project.  
* Go to General pane of the application target in your project. Add VuzixConnectivity.framework to the Embedded Binaries section. 
* Import VuzixConnectivity in your Swift file and use in your code.

## Documentation
Documentation of the API, along with examples can be found at [Vuzix's Developer portal]( https://www.vuzix.com/Developer/knowledgebase/Detail/1099).   Also see the docs located at [https://vuzix.github.io/VuzixConnectivity/](https://vuzix.github.io/VuzixConnectivity/)
