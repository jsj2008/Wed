//
//  PRGalleryViewController.h
//  Wed
//
//  Created by Rishabh Tayal on 9/8/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface PRGalleryViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, DBRestClientDelegate>

@property (nonatomic, strong) DBRestClient* restClient;

@end
