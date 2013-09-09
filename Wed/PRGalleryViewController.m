//
//  PRGalleryViewController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/8/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRGalleryViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "API.h"
#import "PRPhotoScreenViewController.h"

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
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshStream)]];
    [self createUserNameAndLogin];
    
    [self refreshStream];
}

-(void)createUserNameAndLogin {
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"register", @"command", [[UIDevice currentDevice] name], @"username", @"password", @"password", nil];
    [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json) {
//        NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
        NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"login", @"command", [[UIDevice currentDevice] name], @"username", @"password", @"password", nil];
        [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json) {
            NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
            if ([json objectForKey:@"error"]==nil && [[res objectForKey:@"IdUser"] intValue]>0) {
                [[API sharedInstance] setUser:res];
            }
        }];
    }];
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

-(IBAction)takePhoto:(id)sender
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

-(void)refreshStream {
    //just call the "stream" command from the web API
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"stream", @"command", nil] onCompletion:^(NSDictionary *json) {
		//got stream
		[self showStream:[json objectForKey:@"result"]];
	}];
}

-(void)showStream:(NSArray*)stream {
    // 1 remove old photos
    for (UIView* view in _listView.subviews) {
        [view removeFromSuperview];
    }
    // 2 add new photo views
    for (int i=0;i<[stream count];i++) {
        NSDictionary* photo = [stream objectAtIndex:i];
        PhotoView* photoView = [[PhotoView alloc] initWithIndex:i andData:photo];
        photoView.delegate = self;
        [_listView addSubview: photoView];
    }
    // 3 update scroll list's height
    int listHeight = ([stream count]/3 + 1)*(kThumbSide+kPadding);
    [_listView setContentSize:CGSizeMake(320, listHeight)];
    [_listView scrollRectToVisible:CGRectMake(0, 0, 10, 10) animated:YES];
}

-(void)didSelectPhoto:(PhotoView*)sender {
    //photo selected - show it full screen
    NSNumber* tag = [NSNumber numberWithInt:sender.tag];
    PRPhotoScreenViewController* photoScreen = [[PRPhotoScreenViewController alloc] initWithIdPhoto:tag];
//    photoScreen.IdPhoto = [NSNumber numberWithInt:sender.tag];
    [self.navigationController pushController:photoScreen];
}

#pragma mark - UIImagePickerController Delegate

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

        [picker dismissViewControllerAnimated:YES completion:^{
            [self uploadImageToAppikonServer:imageToSave];
        }];
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
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark -

-(void)uploadImageToAppikonServer:(UIImage*)imageToUpload {
    //upload the image and the title to the web service
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"upload", @"command", UIImageJPEGRepresentation(imageToUpload,70), @"file", @"Title", @"title", nil] onCompletion:^(NSDictionary *json) {
		//completion
		if (![json objectForKey:@"error"]) {
			//success
			[[[UIAlertView alloc]initWithTitle:@"Success!" message:@"Your photo is uploaded" delegate:nil cancelButtonTitle:@"Yay!" otherButtonTitles: nil] show];
			
		} else {
			//error, check for expired session and if so - authorize the user
			NSString* errorMsg = [json objectForKey:@"error"];
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:errorMsg
                                       delegate:nil
                              cancelButtonTitle:@"Close"
                              otherButtonTitles: nil] show];
			if ([@"Authorization required" compare:errorMsg]==NSOrderedSame) {
				[self performSegueWithIdentifier:@"ShowLogin" sender:nil];
			}
		}
	}];
}

@end