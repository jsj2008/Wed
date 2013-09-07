//
//  PRFamilyViewController.h
//  Wed
//
//  Created by Rishabh Tayal on 9/6/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRSegmentControl.h"

@interface PRFamilyViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* datasource;
@property (nonatomic, strong) IBOutlet UIView* footer;
@property (nonatomic, strong) IBOutlet PRSegmentControl* segControl;

-(IBAction)familyChanged:(PRSegmentControl*)sender;

@end
