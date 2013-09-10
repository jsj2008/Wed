//
//  PRProgressView.m
//  Wed
//
//  Created by Rishabh Tayal on 9/9/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRProgressView.h"

@implementation PRProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = (PRProgressView*)[[[NSBundle mainBundle] loadNibNamed:@"PRProgressView" owner:self options:nil] objectAtIndex:0];
        [_activityIndicator startAnimating];
    }
    return self;
}


-(void)stop {
    [_activityIndicator stopAnimating];
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
