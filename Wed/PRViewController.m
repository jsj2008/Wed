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

@property (nonatomic, strong) NSTimer* timer;

@end

@implementation PRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    _countdownLabel.text = [NSString stringWithFormat:@"%d", [self numberOfDays]];
    _timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
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

-(void) updateCountdown
{
    
    NSString *dateString = @"07-12-2013";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    
    NSDateComponents *componentsHours = [calendar components:NSHourCalendarUnit fromDate:now];
    NSDateComponents *componentMint = [calendar components:NSMinuteCalendarUnit fromDate:now];
    NSDateComponents *componentSec = [calendar components:NSSecondCalendarUnit fromDate:now];
    
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *componentsDaysDiff = [gregorianCalendar components:NSDayCalendarUnit
                                                                fromDate:now
                                                                  toDate:dateFromString
                                                                 options:0];
    
    
    
    _lblDays.text=[NSString stringWithFormat:@"%02d",componentsDaysDiff.day];
    _lblHours.text=[NSString stringWithFormat:@"%02d",(24-componentsHours.hour)];
    _lblMinute.text=[NSString stringWithFormat:@"%02d",(60-componentMint.minute)];
    _lblSec.text=[NSString stringWithFormat:@"%02d",(60-componentSec.second)];
}

@end
