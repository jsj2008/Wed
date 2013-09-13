//
//  PRAppDelegate.h
//  Wed
//
//  Created by Rishabh Tayal on 9/5/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRViewController;

@interface PRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PRViewController *viewController;

//+(NSString*)documentsPath;
+(NSString*)tempDirectory;

@end
