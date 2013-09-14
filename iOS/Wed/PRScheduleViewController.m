//
//  PRScheduleViewController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/6/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRScheduleViewController.h"
#import "PREventsCell.h"
#import "PRVenuesWithMapViewController.h"
#import "PRAppDelegate.h"

@interface PRScheduleViewController ()
{
    int scrollToSection;
}

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadLocalEventsFiles)];
    [self setNavigationBarLeftButton];
    
    [self loadLocalEventsFiles];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
        self.navigationController.navigationBarHidden = NO;
    UIColor* barColor = [UIColor colorWithRed:212/255.0 green:76/255.0 blue:193/255.0 alpha:1.0];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:barColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:barColor];
    [[LocalyticsSession shared] tagScreen:@"Events Screen"];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
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

-(void) loadLocalEventsFiles {
    _datasource = [[NSMutableArray alloc] initWithContentsOfFile:[PRAppDelegate eventsFilesPath]];
    [_tableView reloadData];
}

#pragma mark - UITableView Datasource

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
    PREventsCell* cell = (PREventsCell*)[tableView dequeueReusableCellWithIdentifier:@"PREventsCell"];
    if (!cell) {
        cell = [[PREventsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PREventsCell"];
    }
    cell.eventName.text = [[[[_datasource objectAtIndex:indexPath.section] objectForKey:@"Events"] objectAtIndex:indexPath.row] objectForKey:@"Event"];
    cell.locationLabel.text = [[[[_datasource objectAtIndex:indexPath.section] objectForKey:@"Events"] objectAtIndex:indexPath.row] objectForKey:@"Location"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PREventsCell* cell = (PREventsCell*) [_tableView cellForRowAtIndexPath:indexPath];
    PRVenuesWithMapViewController* venuesVC = [[PRVenuesWithMapViewController alloc] initWithLocationTitle:cell.locationLabel.text];
    venuesVC.title = @"Venues";
    [self.navigationController pushController:venuesVC];
}

//-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString* currentDateString = [[_datasource objectAtIndex:indexPath.section] objectForKey:@"Date"];
//    NSDateFormatter* df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"MMM dd, yyyy"];
//    NSDate* currentDate = [df dateFromString:currentDateString];
//    NSDate* todaysDate = [NSDate date];
//    if ([currentDate compare:todaysDate] == NSOrderedAscending) {
//        scrollToSection = indexPath.section + 1;
//    }
//
//    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
//        //end of loading
//        //for example [activityIndicator stopAnimating];
//        NSLog(@"Table View Finished Loading");
//        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:scrollToSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    }
//}

@end