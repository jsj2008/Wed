//
//  PRAnnotation.m
//  Wed
//
//  Created by Rishabh Tayal on 9/7/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRAnnotation.h"

@implementation PRAnnotation

-(id)initWithTitle:(NSString*)title coordinatioes:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self) {
        _title = title;
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

@end