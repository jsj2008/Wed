//
//  UINavigationController+PRNavigationController.h
//  Wed
//
//  Created by Rishabh Tayal on 9/7/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (PRNavigationController)

- (void) pushController: (UIViewController*) controller;
- (UIViewController *) popControllerWithTransition;

@end