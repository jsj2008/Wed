//
//  PRScheduleViewController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/6/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRScheduleViewController.h"
#import "PREventsCell.h"

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadRemoteData)];
    [self setNavigationBarLeftButton];
    
    [self reloadRemoteData];
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
    [self.navigationController popControllerWithTransition];
}

-(void)reloadRemoteData {
    PRProgressView* progressView = [[PRProgressView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:progressView];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        _datasource = [[NSMutableArray alloc] initWithContentsOfURL:[NSURL URLWithString:PRDropboxEventsScheduleURL]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView transitionWithView:_tableView duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
                [_tableView reloadData];
                [progressView stop];
            } completion:NULL];
        });
    });
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
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
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