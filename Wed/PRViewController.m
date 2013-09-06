//
//  PRViewController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/5/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRViewController.h"
#import "PRVenuesViewController.h"

@interface PRViewController ()

@end

@implementation PRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonClicked:(id)sender {
    PRVenuesViewController* venuesVC = [[PRVenuesViewController alloc] init];
    venuesVC.title = ((UIButton*)sender).titleLabel.text;
    [self.navigationController pushViewController:venuesVC animated:YES];
}

@end
