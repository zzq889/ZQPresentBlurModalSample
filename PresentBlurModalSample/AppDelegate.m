//
//  AppDelegate.m
//  PresentBlurModalSample
//
//  Created by Zhang Zeqing on 28/6/13.
//  Copyright (c) 2013 Zhang Zeqing. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[RootViewController alloc] init];
    self.window.rootViewController = self.viewController;

    [self.window makeKeyAndVisible];
    return YES;
}
@end
