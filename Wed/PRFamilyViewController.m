//
//  PRFamilyViewController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/6/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRFamilyViewController.h"
#import "PRFamilyCell.h"

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
    _datasource = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Thakurs Family" ofType:@"plist"]];
    _tableView.tableFooterView = _footer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)familyChanged:(id)sender {
    UISegmentedControl* segControl = (UISegmentedControl*)sender;
    if (segControl.selectedSegmentIndex == 0) {
        _datasource = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle ] pathForResource:@"Thakurs Family" ofType:@"plist"]];
    }
    else{
        _datasource = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle ] pathForResource:@"Tayals Family" ofType:@"plist"]];
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
