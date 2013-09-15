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

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat outerMargin = 7.5f;
    CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);
    drawCurvedGloss(context, outerRect, 180);
}

-(void)animate {
    float randomDelay = ((float)rand() / RAND_MAX);
    [UIView animateWithDuration:3.0 delay:randomDelay options: UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction animations:^{
        
        int randomNumX = rand() % (10 - 7) + 7;
//        int randomNumY = rand() % (10 - 7) + 7;
        
        self.center = CGPointMake(self.center.x + randomNumX, self.center.y);
    } completion:nil];
}

void drawCurvedGloss (CGContextRef context, CGRect rect, CGFloat radius)
{    
    CGColorRef glossStart = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6].CGColor;
    CGColorRef glossEnd = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
    
    CGMutablePathRef glossPath = CGPathCreateMutable();
    
    CGContextSaveGState(context);
    CGPathMoveToPoint(glossPath, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect)-radius+rect.size.height/2);
    CGPathAddArc(glossPath, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect)-radius+rect.size.height/2, radius, 0.75f*M_PI, 0.25f*M_PI, YES);
    CGPathCloseSubpath(glossPath);
    CGContextAddPath(context, glossPath);
    CGContextClip(context);
    CGContextAddPath(context, createRoundedRectForRect(rect, 6.0f));
    CGContextClip(context);
    
    CGRect half = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height/2);
    
    
    drawLinearGradient(context, half, glossStart, glossEnd);
    CGContextRestoreGState(context);
}

CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius) {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), radius);
    CGPathCloseSubpath(path);
    
    return path;
}

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef  endColor) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };

//    NSArray *colors = [NSArray arrayWithObjects:(__bridge id)startColor, (__bridge id)endColor, nil];
    NSArray *colors = [NSArray arrayWithObjects:[UIColor colorWithCGColor:startColor], [UIColor colorWithCGColor:endColor], nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
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
