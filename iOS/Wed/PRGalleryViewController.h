//
//  PRGalleryViewController.h
//  Wed
//
//  Created by Rishabh Tayal on 9/8/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoView.h"

@interface PRGalleryViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, PhotoViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView* listView;
@property (nonatomic, strong) IBOutlet UILabel* noPhotosLAbel;

-(IBAction)takePhoto:(id)sender;

@end
