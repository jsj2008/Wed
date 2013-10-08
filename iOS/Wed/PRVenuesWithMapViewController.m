//
//  PRVenuesWithMapViewController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/7/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRVenuesWithMapViewController.h"
#import "PRAnnotation.h"
#import "PRAppDelegate.h"

#define METERS_PER_MILE 1609.344

@interface PRVenuesWithMapViewController ()
{
    PRAnnotation* selectedLocation;
}

@property (nonatomic, strong) NSString* locationTitle;

@end

@implementation PRVenuesWithMapViewController

- (id)init
{
    self = [super initWithNibName:@"PRVenuesWithMapViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

-(id)initWithLocationTitle:(NSString*)locationTitle {
    self = [self init];
    if (self) {
        _locationTitle = locationTitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        [self setNavigationBarLeftButton];
//    }
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(plotMapAnnotations)]];
    _venuesArray = [NSArray arrayWithContentsOfFile:[PRAppDelegate venuesFilesPath]];
    [self plotMapAnnotations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[LocalyticsSession shared] tagScreen:@"Venues Screen"];
    self.navigationController.navigationBarHidden = NO;
    UIColor* barColor = [UIColor colorWithRed:255/255.0 green:38/255.0 blue:14/255.0 alpha:1.0];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:barColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void) setNavigationBarLeftButton
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    UIImage* image = [UIImage imageNamed:NAVIGATIONBARBACKBUTTON];
    [button setImage:image forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:button]];
}

-(void)back:(id)sender
{
    [self.navigationController popControllerWithTransition];
}

-(void)plotMapAnnotations {
    for (PRAnnotation* annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    for (NSDictionary* venue in _venuesArray) {
        if (_locationTitle != nil && [[_venuesArray valueForKey:@"Title"] containsObject:_locationTitle] ) {
            if ([_locationTitle isEqualToString:[venue objectForKey:@"Title"]]) {
                CLLocationCoordinate2D location;
                location.latitude = [[venue objectForKey:@"Latitude"] floatValue];
                location.longitude = [[venue objectForKey:@"Longitude"] floatValue];
                PRAnnotation* annotation = [[PRAnnotation alloc] initWithTitle:[venue objectForKey:@"Title"] address:[venue objectForKey:@"Address"] coordinates:location];
                [_mapView addAnnotation:annotation];
            }
        }
        else
        {
            CLLocationCoordinate2D location;
            location.latitude = [[venue objectForKey:@"Latitude"] floatValue];
            location.longitude = [[venue objectForKey:@"Longitude"] floatValue];
            PRAnnotation* annotation = [[PRAnnotation alloc] initWithTitle:[venue objectForKey:@"Title"] address:[venue objectForKey:@"Address"] coordinates:location];
            [_mapView addAnnotation:annotation];
        }
    }
}

#pragma mark - MKMapView Delegate

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *annotationView = [views objectAtIndex:0];
	id <MKAnnotation> mp = [annotationView annotation];
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 20*METERS_PER_MILE, 20*METERS_PER_MILE);
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
            annotationView.image = [UIImage imageNamed:@"pin.png"];//here we use a nice image instead of the default pins
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
    
    selectedLocation = location;
    if ([[UIApplication sharedApplication] canOpenURL:
         [NSURL URLWithString:@"comgooglemaps://"]]) {
        
        UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Open in..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Google Maps", @"Apple Maps", nil];
        [actionSheet showInView:self.view.window];
        
    }
    else
        [location.mapItem openInMapsWithLaunchOptions:launchOptions];
}

#pragma mark -

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //Google Maps
        NSString* locationTitleWithAddedPlusSigns = [selectedLocation.title stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?q=%@&center=%f,%f&zoom=14&views=traffic", locationTitleWithAddedPlusSigns, selectedLocation.coordinate.latitude, selectedLocation.coordinate.longitude]]];
    }
    if (buttonIndex == 1) {
        //Apple Maps
        [selectedLocation.mapItem openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving}];
    }
}

@end