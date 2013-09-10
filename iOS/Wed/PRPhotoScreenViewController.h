//
//  PRPhotoScreenViewController.h
//  Wed
//
//  Created by Rishabh Tayal on 9/9/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRPhotoScreenViewController : UIViewController<UIScrollViewDelegate>
{
    //just the photo view and the photo title
    IBOutlet UIImageView* photoView;
    IBOutlet UILabel* lblTitle;
}

@property (strong, nonatomic) NSNumber* IdPhoto;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView* activityView;
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;

-(id)initWithIdPhoto:(NSNumber*)idPhoto;

@end
