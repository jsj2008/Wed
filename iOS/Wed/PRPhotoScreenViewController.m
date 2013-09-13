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
{
    int currentPhotoRefernceNumber;
}

@end

@implementation PRPhotoScreenViewController

-(id)initWithPhotoIds:(NSArray *)photoIds currentPhotoId:(NSNumber *)currentPhotoID
{
    self = [super initWithNibName:@"PRPhotoScreenViewController" bundle:nil];
    if (self) {
        _photoIds = photoIds;
        _currentPhotoId = currentPhotoID;
    }
    return self;
}

-(void)viewDidLoad {
    [self setNavigationBarLeftButton];
    
    
	API* api = [API sharedInstance];
	//load the caption of the selected photo
	[api commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"stream", @"command", _currentPhotoId, @"IdPhoto", nil] onCompletion:^(NSDictionary *json) {
		//show the text in the label
		NSArray* list = [json objectForKey:@"result"];
        if (list.count > 0) {
            NSDictionary* photo = [list objectAtIndex:0];
            lblTitle.text = [NSString stringWithFormat:@"Uploaded by: %@", [photo objectForKey:@"username"]];
        }
	}];
    
    for (int i = 0; i < [[_photoIds valueForKey:@"IdPhoto"] count]; i++) {
        NSString* photoID = [[_photoIds valueForKey:@"IdPhoto"] objectAtIndex:i];
        if ([photoID isEqualToString:_currentPhotoId]) {
            currentPhotoRefernceNumber = i;
        }
    }
    [self loadBigSizePhoto:currentPhotoRefernceNumber];
    _outerScrollView.contentSize = CGSizeMake(_outerScrollView.frame.size.width*_photoIds.count, _outerScrollView.contentSize.height);
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

-(void)loadBigSizePhoto:(int) idReference {
    //load the big size photo
    currentPhotoRefernceNumber = idReference;
    [_activityView startAnimating];
    API* api = [API sharedInstance];
	NSURL* imageURL = [api urlForImageWithId:[[_photoIds objectAtIndex:idReference] valueForKey:@"IdPhoto"] isThumb:NO];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_activityView stopAnimating];
            //            [photoView setImageWithURL: imageURL];
            [photoView setImage:image];
        });
    });
}

#pragma mark - UIScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _outerScrollView) {
        if (currentPhotoRefernceNumber != _photoIds.count - 1) {
            [self loadBigSizePhoto:currentPhotoRefernceNumber + 1];
        }
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [_scrollView viewWithTag:1];
}

@end