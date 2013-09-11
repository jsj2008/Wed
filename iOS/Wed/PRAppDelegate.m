//
//  PRAppDelegate.m
//  Wed
//
//  Created by Rishabh Tayal on 9/5/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRAppDelegate.h"
#import "PRViewController.h"
#import "LocalyticsSession.h"

@implementation PRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[LocalyticsSession shared] startSession:@"dfd759fdfda91377340d12f-bb8a5478-1a55-11e3-1300-004a77f8b47f"];
    [[LocalyticsSession shared] tagEvent:[[UIDevice currentDevice] name]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[PRViewController alloc] initWithNibName:@"PRViewController" bundle:nil];
    } else {
        self.viewController = [[PRViewController alloc] initWithNibName:@"PRViewController_iPad" bundle:nil];
    }
    UINavigationController* navC = [[UINavigationController alloc] initWithRootViewController:_viewController];
    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeFont: [UIFont fontWithName:PRFontHelveticaNeueRegular size:0.0],
     }];
    self.window.rootViewController = navC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [[LocalyticsSession shared] close];
    [[LocalyticsSession shared] upload];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[LocalyticsSession shared] close];
    [[LocalyticsSession shared] upload];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[LocalyticsSession shared] resume];
    [[LocalyticsSession shared] upload];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[LocalyticsSession shared] resume];
    [[LocalyticsSession shared] upload];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[LocalyticsSession shared] close];
    [[LocalyticsSession shared] upload];
}

@end
