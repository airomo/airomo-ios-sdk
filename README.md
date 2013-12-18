airomo-ios-sdk
===============

iOS library to integrate Airomo Search API into iOS project. The library uses ARC and requires at least iOS 5.0.



## Requirements

* Xcode 5+
* iOS 5+ target deployment
* armv7, armv7s, and arm64 devices and the simulator (not armv6)
* iPhone and iPad of all sizes and resolutions


##Getting Started

Follow steps described below to install AiromoSDK library:

1. Register your application on [Airomo API website](http://www.airomo.com/apps/). Make sure you got your 'clientId', 'clientKey' and application 'id'.

2. Download latest version of AiromoSDK from [Airomo iOS SDK repository](http://www.airomo.com/apps/).

3. Drag&Drop "AiromoSDK.framework" (containing libAiromoSDK.a and Headers) into your project's "Frameworks' section.

4. Import the <AiromoSDK/AiromoSDK.h> into application delegate (usually called AppDelegate.m) and configure Airomo SDK with your 'clientId', 'clientKey':


``` objective-c
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions 
{
	// set the Airomo clientId and apiKey. You need to register your app here: http://www.airomo.com/apps/
	[AIManager setupWithClientId:@"YOUR_CLIENT_ID" apiKey:@"YOUR_API_KEY"];
	
	//your application specific code
    
    return YES;	
}

5. To call API and show results use:


6. Congratulations! You are done.