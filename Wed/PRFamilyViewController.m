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
    [self setNavigationBarLeftButton];

    [self familyChanged:_segControl];

    _tableView.tableFooterView = _footer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _datasource = [NSMutableArray new];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    PRProgressView* progressView = [[PRProgressView alloc] initWithFrame:_tableView.frame];
    [_tableView addSubview:progressView];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if (_segControl.selectedSegmentIndex == 0) {
            _datasource = [[NSMutableArray alloc] initWithContentsOfURL:[NSURL URLWithString:PRDropboxThakurFamilyURL]];
        }
        else{
            _datasource = [[NSMutableArray alloc] initWithContentsOfURL:[NSURL URLWithString:PRDropboxTayalFamilyURL]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            [progressView stop];
        });
    });
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
