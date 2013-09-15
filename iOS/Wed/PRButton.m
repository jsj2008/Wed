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
//    if (!originalBackgroundColor) {
//        originalBackgroundColor = self.backgroundColor;
//    }
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    UIFont *font = [UIFont fontWithName:PRFontHelveticaNeueLight size:16.0f];
    self.titleLabel.font = font;
    
    self.layer.cornerRadius = self.frame.size.width/2;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 1.5;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    //Add a translucent layer to uibutton layer. Set color of layer depending on uibutton tag.
    CALayer*  layer = [CALayer layer];
    layer.frame = self.bounds;
    switch (self.tag) {
        case 1:
            layer.backgroundColor = [UIColor colorWithRed:212/255.0 green:76/255.0 blue:193/255.0 alpha:1].CGColor;
            break;
        case 2:
            layer.backgroundColor = [UIColor colorWithRed:26/255.0 green:141/255.0 blue:225/255.0 alpha:1].CGColor;
            break;
        case 3:
            layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:38/255.0 blue:14/255.0 alpha:1].CGColor;
            break;
        case 4:
            layer.backgroundColor = [UIColor colorWithRed:0/255.0 green:212/255.0 blue:35/255.0 alpha:1].CGColor;
            break;
        default:
            break;
    }
    layer.opacity = 0.4;
    [self.layer insertSublayer:layer below:self.layer];
    
    // Drawing code
    [self animate];
}

-(void)animate {
    float randomDelay = ((float)rand() / RAND_MAX);
    [UIView animateWithDuration:3.0 delay:randomDelay options: UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        
        int randomNumX = rand() % (10 - 7) + 7;
//        int randomNumY = rand() % (10 - 7) + 7;
        
        self.center = CGPointMake(self.center.x + randomNumX, self.center.y);
    } completion:nil];
}

-(void)setHighlighted:(BOOL)highlighted
{
//    if (highlighted) {
//        self.backgroundColor = [UIColor grayColor];
//    }
//    else {
//        self.backgroundColor = originalBackgroundColor;
//    }
}

@end
