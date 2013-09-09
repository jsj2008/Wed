//
//  PRVenuesWithMapViewController.h
//  Wed
//
//  Created by Rishabh Tayal on 9/7/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface PRVenuesWithMapViewController : UIViewController<MKMapViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) IBOutlet MKMapView* mapView;

@property (nonatomic, assign) CLLocationCoordinate2D* coordinates;
@property (nonatomic, strong) NSMutableArray* venuesArray;

@end
