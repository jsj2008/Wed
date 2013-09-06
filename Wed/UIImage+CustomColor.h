//
//  UIColor+image.h
//  WM Sales
//
//  Created by Rishabh Tayal on 10/19/12.
//  Copyright (c) 2012 Rishabh Tayal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CustomColor)

+ (UIImage *)imageFromRed:(float)red Green:(float)green Blue:(float)blue;
+ (UIImage*)imageFromColor:(UIColor*)color;
+ (UIColor *)colorWithHex:(UInt32)col;

@end
