//
//  PRViewController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/5/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRViewController.h"
#import "PRVenuesViewController.h"
#import "PRFamilyViewController.h"
#import "PRScheduleViewController.h"

@interface PRViewController ()

@property (nonatomic, strong) IBOutlet UILabel* lblDays;
//@property (nonatomic, strong) IBOutlet UILabel* lblHours;
//@property (nonatomic, strong) IBOutlet UILabel* lblMinute;
//@property (nonatomic, strong) IBOutlet UILabel* lblSec;

@property (nonatomic, strong) IBOutlet UIButton* scheduleButton;
@property (nonatomic, strong) IBOutlet UIButton* galleryButton;
@property (nonatomic, strong) IBOutlet UIButton* venuesButton;
@property (nonatomic, strong) IBOutlet UIButton* familyButton;

@property (nonatomic, strong) NSTimer* timer;

@end

@implementation PRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:26/255.0 green:141/255.0 blue:225/255.0 alpha:1.0];
    _timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
    
    [self setButtonTags];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setButtonTags {
    _scheduleButton.tag = PRHomeButtonTypeSchedule;
    _galleryButton.tag = PRHomeButtonTypeGallery;
    _venuesButton.tag = PRHomeButtonTypeVenues;
    _familyButton.tag = PRHomeButtonTypeFamily;
}

-(IBAction)buttonClicked:(id)sender {
    UIButton* button = (UIButton*)sender;
    switch (button.tag) {
        case PRHomeButtonTypeSchedule:{
            PRScheduleViewController* scheduleVC = [[PRScheduleViewController alloc] init];
            scheduleVC.title = ((UIButton*)sender).titleLabel.text;
            [self.navigationController pushViewController:scheduleVC animated:YES];
        }
            break;
        case PRHomeButtonTypeVenues:
        {
            PRVenuesViewController* venuesVC = [[PRVenuesViewController alloc] init];
            venuesVC.title = ((UIButton*)sender).titleLabel.text;
            [self.navigationController pushViewController:venuesVC animated:YES];
        }
            break;
        case PRHomeButtonTypeFamily:
        {
            PRFamilyViewController* familyVC = [[PRFamilyViewController alloc] init];
            familyVC.title = ((UIButton*)sender).titleLabel.text;
            [self.navigationController pushViewController:familyVC animated:YES];
        }
            break;
        default:
            break;
    }
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
    
    
    
    _lblDays.text=[NSString stringWithFormat:@"%02d Days\t%02d Hours\t%02d Min\t%02d Sec",componentsDaysDiff.day, (24 - componentsHours.hour), (60-componentMint.minute), (60-componentSec.second)];
//    _lblHours.text=[NSString stringWithFormat:@"%02d Hours",(24-componentsHours.hour)];
//    _lblMinute.text=[NSString stringWithFormat:@"%02d Min",(60-componentMint.minute)];
//    _lblSec.text=[NSString stringWithFormat:@"%02d Sec",(60-componentSec.second)];
}

@end
