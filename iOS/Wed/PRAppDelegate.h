//
//  PRAppDelegate.h
//  Wed
//
//  Created by Rishabh Tayal on 9/5/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iVersion.h"

@class PRViewController;

@interface PRAppDelegate : UIResponder <UIApplicationDelegate, iVersionDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PRViewController *viewController;

+(NSString*)documentsPath;
+(NSString*)tempDirectory;
+(NSString*)cacheDirectory;
+(NSString*)venuesFilesPath;
+(NSString*)eventsFilesPath;
+(NSString*)thakurFamilyFilePath;
+(NSString*)tayalFamilyFilePath;

@end
