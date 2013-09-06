//
//  PRViewController.h
//  Wed
//
//  Created by Rishabh Tayal on 9/5/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PRHomeButtonTypeSchedule = 1,
    PRHomeButtonTypeGallery,
    PRHomeButtonTypeVenues,
    PRHomeButtonTypeFamily,
}PRHomeButtonType;

@interface PRViewController : UIViewController

-(IBAction)buttonClicked:(id)sender;

@end
