//
//  PRGalleryViewController.h
//  Wed
//
//  Created by Rishabh Tayal on 9/8/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoView.h"
#import "MWPhotoBrowser.h"

@interface PRGalleryViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, PhotoViewDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView* listView;
@property (nonatomic, strong) IBOutlet UILabel* noPhotosLAbel;

@property (nonatomic, strong) NSMutableArray* stream;
@property (nonatomic, strong) NSMutableArray* mwPhotosArray;

-(IBAction)takePhoto:(id)sender;

@end
