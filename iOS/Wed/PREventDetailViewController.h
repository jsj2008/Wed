//
//  PREventDetailViewController.h
//  Wed
//
//  Created by Rishabh Tayal on 9/20/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PREventDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextView* textView;
@property (nonatomic, strong) NSString* eventName;

- (id)initWithEvent:(NSString*)event;

@end
