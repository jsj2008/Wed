//
//  PRViewController.h
//  Wed
//
//  Created by Rishabh Tayal on 9/5/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel* lblDays;
@property (nonatomic, strong) IBOutlet UILabel* lblHours;
@property (nonatomic, strong) IBOutlet UILabel* lblMinute;
@property (nonatomic, strong) IBOutlet UILabel* lblSec;

-(IBAction)buttonClicked:(id)sender;

@end
