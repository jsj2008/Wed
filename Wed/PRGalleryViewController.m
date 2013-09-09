//
//  PRGalleryViewController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/8/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRGalleryViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface PRGalleryViewController ()

@end

@implementation PRGalleryViewController

- (id)init
{
    self = [super initWithNibName:@"PRGalleryViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarLeftButton];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicture)]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setNavigationBarLeftButton
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:NAVIGATIONBARBACKBUTTON] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:button]];
}

-(void)back:(id)sender
{
    [self.navigationController popControllerWithTransition];
}

-(void)takePicture
{
    NSLog(@"Take Picture");
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = self;
    
    [self.navigationController presentViewController:cameraUI animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        
        // Save the new image (original or edited) to the Camera Roll
//        UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
        
        [self uploadImageToDropbox:imageToSave];
    }
    
    // Handle a movie capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        
        NSString *moviePath = [[info objectForKey:
                                UIImagePickerControllerMediaURL] path];
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum (
                                                 moviePath, nil, nil, nil);
        }
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)uploadImageToDropbox:(UIImage*)imageToUpload {

//    [self.restClient createFolder:@"Wed Photos"];
    
    NSString *fileName = @"myImage.png";
    NSString *tempDir = NSTemporaryDirectory();
    NSString *imagePath = [tempDir stringByAppendingPathComponent:fileName];
    
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(imageToUpload)];
    [imageData writeToFile:imagePath atomically:YES];

//    [_restClient loadSharableLinkForFile:imagePath];
    
    [self.restClient uploadFile:[imagePath lastPathComponent] toPath:@"https://www.dropbox.com/sh/xn1ie3sh7zcbml7/IDe1E7Uf6a" withParentRev:nil fromPath:imagePath];
}
-(void)restClient:(DBRestClient *)restClient loadedSharableLink:(NSString *)link forFile:(NSString *)path
{
    NSLog(@"a");
}

- (DBRestClient *)restClient {
    if (!_restClient) {
        _restClient =
        [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        _restClient.delegate = self;
    }
    return _restClient;
}

@end