airomo-ios-sdk
===============

iOS library to integrate Airomo Search API into iOS project. The library uses ARC and requires at least iOS 6.0.



## Requirements

* Xcode 6+
* iOS 6+ target deployment
* armv7, armv7s, arm64 devices and the simulator (not armv6)
* iPhone and iPad of all sizes and resolutions


##Getting Started

Follow steps described below to install AiromoSDK library:

1. Register your application on [Airomo API website](http://www.airomo.com/apps/). Make sure you got your 'clientId', 'clientKey' and application 'id'.

2. Download latest version of AiromoSDK from [Airomo iOS SDK repository](http://www.airomo.com/apps/).

3. Drag&Drop "AiromoSDK.framework" (containing libAiromoSDK.a and Headers) into your project's "Frameworks" section.

4. Drag&Drop "AiromoSDK.bundle" (containing resources) into your project's.

5. Select application Target in 'Targets' section. Search for "library search" and then add the '$(srcroot)AiromoSDK' into "Library Search Path". 

6. Import the <AiromoSDK/AiromoSDK.h> into application delegate (usually called AppDelegate.m) and configure Airomo SDK with your 'clientId', 'clientKey':

``` objective-c
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions 
{
	// set the Airomo clientId and apiKey. You need to register your app here: http://www.airomo.com/apps/
	[AIManager setupWithClientId:@"YOUR_CLIENT_ID" apiKey:@"YOUR_API_KEY"];
	
	//your application specific code
    
    return YES;	
}
```
7. To call API and show results import <AiromoSDK/AiromoSDK.h> and use code:

``` objective-c
	AIManager *manager = [AIManager sharedManager];
	
	//set query or metakeywords and/or url or tags for  contextual search 
	manager.query = @"angry birds";
	
	manager.metaKeywords = @"arcade game,shooter game";
	
	manager.url = @"http://some.url";
	
	manager.tags = [NSArray arrayWithObjects:@"game",@"birds",nil];
	
	manager.price = AIPricePaid;// AIPricePaid - for paid applications, AIPriceFree - for free applications, don't set this property for both paid and free applications
	
	//MY_PARTNER_ID and MY_CHANNEL_ID must be replaced with your own values
	[manager showApplicationsWithPartnerId:MY_PARTNER_ID
                                 withChannelId:MY_CHANNEL_ID
                                    withOffset:0
                                      withSize:10
                         withCompletionHandler:^(NSError *error)
         {
             if (error) 
             {
                 [[[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
             }
     }];
```    
8. Congratulations! You are done.