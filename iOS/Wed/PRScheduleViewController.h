//
//  PRScheduleViewController.h
//  Wed
//
//  Created by Rishabh Tayal on 9/6/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRScheduleViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray* datasource;
@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end
