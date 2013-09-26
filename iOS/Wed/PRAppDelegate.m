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

#pragma mark - iVersionDelegate

+(void)initialize
{
    [iVersion sharedInstance].updateURL = [NSURL URLWithString:AppUpdateURL];
    [iVersion sharedInstance].remoteVersionsPlistURL = VersionCheckPlistURL;
    [iVersion sharedInstance].verboseLogging = true;
    
    [iVersion sharedInstance].remindButtonLabel = @"Remind Later";
    
    [iVersion sharedInstance].checkPeriod = 1/86400;
    [iVersion sharedInstance].remindPeriod = 1/86400;
}

-(BOOL)iVersionShouldOpenAppStore
{
    return false;
}

-(void)iVersionUserDidAttemptToDownloadUpdate:(NSString *)version
{
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:AppUpdateURL]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppUpdateURL]];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[LocalyticsSession shared] startSession:@"dfd759fdfda91377340d12f-bb8a5478-1a55-11e3-1300-004a77f8b47f"];
    [[LocalyticsSession shared] tagEvent:[[UIDevice currentDevice] name]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[PRViewController alloc] initWithNibName:@"PRViewController" bundle:nil];
    UINavigationController* navC = [[UINavigationController alloc] initWithRootViewController:_viewController];
    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeFont: [UIFont fontWithName:PRFontHelveticaNeueRegular size:0.0],
     }];
    self.window.rootViewController = navC;
    [self.window makeKeyAndVisible];
    
    [self downloadAndStoreVenuesFile];
    [self downloadAndStoreEventsFile];
    [self downloadAndStoreFamilyFile];
    
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

-(void)downloadAndStoreVenuesFile {
    NSString* venuesFilePath = [PRAppDelegate venuesFilesPath];
    __block NSMutableArray* tempArray = [NSMutableArray arrayWithContentsOfFile:venuesFilePath];
    if (tempArray.count == 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            tempArray = [[NSMutableArray alloc] initWithContentsOfURL:[NSURL URLWithString:PRDropboxVenuesURL]];
            [tempArray writeToFile:venuesFilePath atomically:YES];
        });
    }
}

+(NSString*)venuesFilesPath {
    return [[PRAppDelegate cacheDirectory] stringByAppendingPathComponent:@"venues.plist"];
}

-(void)downloadAndStoreEventsFile {
    NSString* eventsFilePath = [PRAppDelegate eventsFilesPath];
    __block NSMutableArray* tempArray = [NSMutableArray arrayWithContentsOfFile:eventsFilePath];
    if (tempArray.count == 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            tempArray = [[NSMutableArray alloc] initWithContentsOfURL:[NSURL URLWithString:PRDropboxEventsScheduleURL]];
            [tempArray writeToFile:eventsFilePath atomically:YES];
        });
    }
}

+(NSString*)eventsFilesPath {
    return [[PRAppDelegate cacheDirectory] stringByAppendingPathComponent:@"events.plist"];
}

-(void)downloadAndStoreFamilyFile {
    NSString* thakurFamilyFilePath = [PRAppDelegate thakurFamilyFilePath];
    __block NSMutableArray* tempArray = [NSMutableArray arrayWithContentsOfFile:thakurFamilyFilePath];
    if (tempArray.count == 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            tempArray = [[NSMutableArray alloc] initWithContentsOfURL:[NSURL URLWithString:PRDropboxThakurFamilyURL]];
            [tempArray writeToFile:thakurFamilyFilePath atomically:YES];
        });
    }
    NSString* tayalFamilyPath = [PRAppDelegate tayalFamilyFilePath];
    tempArray = [NSMutableArray arrayWithContentsOfFile:tayalFamilyPath];
    if (tempArray.count == 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            tempArray = [[NSMutableArray alloc] initWithContentsOfURL:[NSURL URLWithString:PRDropboxTayalFamilyURL]];
            [tempArray writeToFile:tayalFamilyPath atomically:YES];
        });
    }
}

+(NSString*)thakurFamilyFilePath {
    return [[PRAppDelegate cacheDirectory] stringByAppendingPathComponent:@"thakur_family.plist"];
}

+(NSString*)tayalFamilyFilePath {
    return [[PRAppDelegate cacheDirectory] stringByAppendingPathComponent:@"tayal_family.plist"];
}

+(NSString*)cacheDirectory {
    NSString* cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return cachePath;
}

+(NSString*)tempDirectory {
    return NSTemporaryDirectory();
}

+(NSString*)documentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    return documentsDirectory;
}

@end