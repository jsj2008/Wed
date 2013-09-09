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
    
    CLLocationCoordinate2D location;
    location.latitude = 22.75563;
    location.longitude = 75.90618;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 20*METERS_PER_MILE, 20*METERS_PER_MILE);
    [_mapView setRegion:viewRegion animated:YES];
    
    PRAnnotation* annotation = [[PRAnnotation alloc] initWithTitle:@"Raddison Blu" coordinatioes:location];
    
    [_mapView addAnnotation:annotation];
    
    location.latitude = 22.761062;
    location.longitude = 75.952130;
    annotation = [[PRAnnotation alloc] initWithTitle:@"Jalsa Garden" coordinatioes:location];
    
    [_mapView addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *annotationView = [views objectAtIndex:0];
	id <MKAnnotation> mp = [annotationView annotation];
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 1500, 1500);
	[_mapView setRegion:region animated:YES];
	[_mapView selectAnnotation:mp animated:YES];
}

@end
