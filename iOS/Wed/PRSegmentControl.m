//
//  PRSegmentControl.m
//  Wed
//
//  Created by Rishabh Tayal on 9/6/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRSegmentControl.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+CustomImage.h"

@implementation PRSegmentControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self setBackgroundImage:[UIImage imageNamed:@"tab-on.png"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[UIImage imageNamed:@"tab-off.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self setDividerImage:[UIImage imageFromColor:[UIColor blackColor]] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:[UIImage imageFromColor:[UIColor blackColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setDividerImage:[UIImage imageFromColor:[UIColor blackColor]] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIFont *font = [UIFont fontWithName:PRFontHelveticaNeueRegular size:13.0f];
    NSDictionary *normalStateAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, font, UITextAttributeFont, nil];

    NSDictionary* selectedStateAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], UITextAttributeTextColor, font, UITextAttributeFont, nil];
    
    [self setTitleTextAttributes:selectedStateAttributes forState:UIControlStateSelected];
    [self setTitleTextAttributes:normalStateAttributes forState:UIControlStateNormal];
    
    [self.layer setCornerRadius:4.0];
    [self.layer setMasksToBounds:YES];
    [self setNeedsLayout];
}

@end