//
//  PRProgressView.h
//  Wed
//
//  Created by Rishabh Tayal on 9/9/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRProgressView : UIView

@property (nonatomic,strong) IBOutlet UIActivityIndicatorView* activityIndicator;

-(void) stop;

@end
