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
{
    PRAnnotation* selectedLocation;
}
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
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(getRemoteVenues)]];
    [self getRemoteVenues];
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

-(void)getRemoteVenues{
    for (PRAnnotation* annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    _venuesArray = [NSMutableArray new];
    PRProgressView* progressView = [[PRProgressView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:progressView];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        _venuesArray = [[NSMutableArray alloc] initWithContentsOfURL:[NSURL URLWithString:PRDropboxVenuesURL]];
        dispatch_async(dispatch_get_main_queue(), ^{
            for (NSDictionary* venue in _venuesArray) {
                CLLocationCoordinate2D location;
                location.latitude = [[venue objectForKey:@"Latitude"] floatValue];
                location.longitude = [[venue objectForKey:@"Longitude"] floatValue];
                PRAnnotation* annotation = [[PRAnnotation alloc] initWithTitle:[venue objectForKey:@"Title"] address:[venue objectForKey:@"Address"] coordinates:location];
                [_mapView addAnnotation:annotation];
            }
            [progressView stop];
        });
    });
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