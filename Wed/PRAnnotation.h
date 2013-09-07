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

@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

-(id)initWithTitle:(NSString*)title coordinatioes:(CLLocationCoordinate2D)coordinate;
@end
