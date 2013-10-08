//
//  PRAnnotation.h
//  Wed
//
//  Created by Rishabh Tayal on 9/7/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PRAnnotation : NSObject<MKAnnotation>

@property (nonatomic, copy) NSString* title;
@property (nonatomic, strong) NSString* address;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

-(MKMapItem*) mapItem;

-(id)initWithTitle:(NSString*)title address:(NSString*)address coordinates:(CLLocationCoordinate2D)coordinate;
@end
