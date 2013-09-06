//
//  PRScheduleViewController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/6/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRScheduleViewController.h"

@interface PRScheduleViewController ()

@end

@implementation PRScheduleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadRemoteData)];
    [self setNavigationBarLeftButton];
    _datasource = [[NSMutableArray alloc] initWithContentsOfURL:[NSURL URLWithString:PRDropboxEventsScheduleURL]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)reloadRemoteData {
    _datasource = [[NSMutableArray alloc] initWithContentsOfURL:[NSURL URLWithString:PRDropboxEventsScheduleURL]];
    [_tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _datasource.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[_datasource objectAtIndex:section] objectForKey:@"Date"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[_datasource objectAtIndex:section] objectForKey:@"Events"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [[[[_datasource objectAtIndex:indexPath.section] objectForKey:@"Events"] objectAtIndex:indexPath.row] objectForKey:@"Event"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end