//
//  PRButton.m
//  Wed
//
//  Created by Rishabh Tayal on 9/6/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRButton.h"
#import <QuartzCore/QuartzCore.h>

@interface PRButton()
{
    UIColor* originalBackgroundColor;
}
@end

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
    if (!originalBackgroundColor) {
        originalBackgroundColor = self.backgroundColor;
    }
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    
    UIFont *font = [UIFont fontWithName:PRFontHelveticaNeueLight size:16.0f];
    self.titleLabel.font = font;    
    
    self.layer.cornerRadius = self.frame.size.width/2;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 1.5;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    // Drawing code
}

-(void)setHighlighted:(BOOL)highlighted
{
    if (highlighted) {
        self.backgroundColor = [UIColor grayColor];
    }
    else {
        self.backgroundColor = originalBackgroundColor;
    }
}

@end
