//
//  UINavigationController+PRNavigationController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/7/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "UINavigationController+PRNavigationController.h"
#import <QuartzCore/QuartzCore.h>

@implementation UINavigationController (PRNavigationController)

- (void) pushController: (UIViewController*) controller {
//    [UIView beginAnimations:nil context:NULL];
//     [self pushViewController:controller animated:NO];
//     [UIView setAnimationDuration:.5];
//     [UIView setAnimationBeginsFromCurrentState:YES];
//     [UIView setAnimationTransition:transition forView:self.view cache:YES];
//     [UIView commitAnimations];
    
    CATransition* theTransition = [CATransition animation];
    theTransition.duration = 0.6;
    theTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    theTransition.type = kCATransitionFade;//kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
//    theTransition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    theTransition.subtype = kCATransitionFade;
    [self.view.layer addAnimation:theTransition forKey:nil];
    [self pushViewController:controller animated:NO];
}

- (UIViewController *) popControllerWithTransition
{
    /*
     [UIView beginAnimations:nil context:NULL];
     UIViewController *vc = [self popViewControllerAnimated:NO];
     [UIView setAnimationDuration:.5];
     [UIView setAnimationBeginsFromCurrentState:YES];
     [UIView setAnimationTransition:transition forView:self.view cache:YES];
     [UIView commitAnimations];
     */
    
    CATransition* theTransition = [CATransition animation];
    theTransition.duration = 0.6;
    theTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    theTransition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    theTransition.subtype = kCATransitionFade; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.view.layer addAnimation:theTransition forKey:nil];
    UIViewController *vc = [self popViewControllerAnimated:NO];
    return vc;
}

@end