//
//  DDAAppDelegate.m
//  DeloitteDummyApp
//
//  Created by HUGE | PJ Herring on 4/17/13.
//  Copyright (c) 2013 HUGE | PJ Herring. All rights reserved.
//

#import "DDAAppDelegate.h"
#import "DDAResponseViewController.h"

@interface DDAAppDelegate ()

@property (nonatomic, strong) DDAResponseViewController *responseViewController;

@end

@implementation DDAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = self.responseViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	
	NSString *query = [url.query stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[query dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
	self.responseViewController.request = json;
	return YES;
}


#pragma mark - Lazy Loader


- (DDAResponseViewController *)responseViewController {
	if (!_responseViewController) {
		_responseViewController = [DDAResponseViewController new];
	}
	
	return _responseViewController;
}


@end
