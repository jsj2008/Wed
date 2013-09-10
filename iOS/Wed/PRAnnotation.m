//
//  PRAnnotation.m
//  Wed
//
//  Created by Rishabh Tayal on 9/7/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRAnnotation.h"
#import <AddressBook/AddressBook.h>

@implementation PRAnnotation

-(id)initWithTitle:(NSString*)title address:(NSString *)address coordinates:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self) {
        _title = title;
        _address = address;
        _coordinate = coordinate;
    }
    return self;
}

-(NSString *)title
{
    return _title;
}

-(CLLocationCoordinate2D)coordinate
{
    return _coordinate;
}

- (MKMapItem*)mapItem {
    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : _address};
    
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}

@end