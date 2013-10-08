//
//  PRFamilyViewController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/6/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRFamilyViewController.h"
#import "PRFamilyCell.h"
#import "PRAppDelegate.h"

@interface PRFamilyViewController ()

@end

@implementation PRFamilyViewController

- (id)init
{
    self = [super initWithNibName:@"PRFamilyViewController" bundle:nil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        [self setNavigationBarLeftButton];
//    }
    
    [self familyChanged:_segControl];
    
    _tableView.tableFooterView = _footer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[LocalyticsSession shared] tagScreen:@"Family Screen"];
    self.navigationController.navigationBarHidden = NO;
    UIColor* barColor = [UIColor colorWithRed:0/255.0 green:212/255.0 blue:35/255.0 alpha:1.0];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:barColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void) setNavigationBarLeftButton
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:NAVIGATIONBARBACKBUTTON] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:button]];
}

-(void)back:(id)sender
{
    [self.navigationController popControllerWithTransition];
}

-(IBAction)familyChanged:(PRSegmentControl*)sender {
    if (_segControl.selectedSegmentIndex == 0) {
        _datasource = [NSMutableArray arrayWithContentsOfFile:[PRAppDelegate thakurFamilyFilePath]];
    }
    else
    {
        _datasource = [NSMutableArray arrayWithContentsOfFile:[PRAppDelegate tayalFamilyFilePath]];
    }
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PRFamilyCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PRFamilyCell"];
    if (!cell) {
        cell = [[PRFamilyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PRFamilyCell"];
    }
    cell.nameLabel.text = [[_datasource objectAtIndex:indexPath.row] objectForKey:@"Name"];
    cell.relationShipLabel.text = [[_datasource objectAtIndex:indexPath.row] objectForKey:@"Relation"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
