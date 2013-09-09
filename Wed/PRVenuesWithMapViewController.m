//
//  PRVenuesWithMapViewController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/7/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRVenuesWithMapViewController.h"
#import "PRAnnotation.h"

#define METERS_PER_MILE 1609.344

@interface PRVenuesWithMapViewController ()

@end

@implementation PRVenuesWithMapViewController

- (id)init
{
    self = [super initWithNibName:@"PRVenuesWithMapViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigationBarLeftButton];
    
    CLLocationCoordinate2D location;
    location.latitude = 22.75563;
    location.longitude = 75.90618;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 20*METERS_PER_MILE, 20*METERS_PER_MILE);
    [_mapView setRegion:viewRegion animated:YES];
    
    PRAnnotation* annotation = [[PRAnnotation alloc] initWithTitle:@"Raddison" address:@"12, Scheme No 94 C, Ring Rd, Indore, MP, India" coordinates:location];
    
    [_mapView addAnnotation:annotation];
    
    location.latitude = 22.761062;
    location.longitude = 75.952130;
    annotation = [[PRAnnotation alloc] initWithTitle:@"Jalsa" address:@"1 Jhalaria Road, Nipania, Near Shishukunj School, Hingoniya Rd, County Walk Township, Indore, MP, India" coordinates:location];
    
    [_mapView addAnnotation:annotation];
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
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *annotationView = [views objectAtIndex:0];
	id <MKAnnotation> mp = [annotationView annotation];
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 1500, 1500);
	[_mapView setRegion:region animated:YES];
	[_mapView selectAnnotation:mp animated:YES];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"PRAnnotation";
    if ([annotation isKindOfClass:[PRAnnotation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
//            annotationView.image = [UIImage imageNamed:@"arrest.png"];//here we use a nice image instead of the default pins
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    PRAnnotation *location = (PRAnnotation*)view.annotation;
    
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    
    if ([[UIApplication sharedApplication] canOpenURL:
         [NSURL URLWithString:@"comgooglemaps://"]]) {
        NSLog(@"google maps");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?q=%@&center=%f,%f&zoom=14&views=traffic", location.title, location.coordinate.latitude, location.coordinate.longitude]]];
        return;
    }
    [location.mapItem openInMapsWithLaunchOptions:launchOptions];
}

@end