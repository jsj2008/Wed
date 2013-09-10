//
//  PRPhotoScreenViewController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/9/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRPhotoScreenViewController.h"
#import "API.h"
#import "PRProgressView.h"

@interface PRPhotoScreenViewController ()

@end

@implementation PRPhotoScreenViewController

-(id)initWithIdPhoto:(NSNumber*)idPhoto {
    self = [super initWithNibName:@"PRPhotoScreenViewController" bundle:nil];
    if (self) {
        _IdPhoto = idPhoto;
    }
    return self;
}

-(void)viewDidLoad {
    [self setNavigationBarLeftButton];
    
	API* api = [API sharedInstance];
	//load the caption of the selected photo
	[api commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"stream", @"command", _IdPhoto, @"IdPhoto", nil] onCompletion:^(NSDictionary *json) {
		//show the text in the label
		NSArray* list = [json objectForKey:@"result"];
        if (list.count > 0) {
            NSDictionary* photo = [list objectAtIndex:0];
            lblTitle.text = [NSString stringWithFormat:@"Uploaded by: %@", [photo objectForKey:@"username"]];
        }
	}];
	//load the big size photo

   [_activityView startAnimating];
	NSURL* imageURL = [api urlForImageWithId:_IdPhoto isThumb:NO];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_activityView stopAnimating];
//            [photoView setImageWithURL: imageURL];
            [photoView setImage:image];
        });
    });

}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

#pragma mark - UIScrollView Delegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [_scrollView viewWithTag:1];
}

@end
