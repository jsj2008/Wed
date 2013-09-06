//
//  PRButton.m
//  Wed
//
//  Created by Rishabh Tayal on 9/6/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation PRButton

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
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    self.layer.cornerRadius = 10; // this value vary as per your desire
    self.clipsToBounds = YES;
    // Drawing code
}


@end
