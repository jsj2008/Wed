//
//  PREventDetailViewController.m
//  Wed
//
//  Created by Rishabh Tayal on 9/20/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PREventDetailViewController.h"

@interface PREventDetailViewController ()

@end

@implementation PREventDetailViewController

- (id)initWithEvent:(NSString*)event
{
    self = [super init];
    if (self) {
        _eventName = event;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarLeftButton];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString* eventDetailString = [[NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:PRDropboxEventDetailURL]] objectForKey:_eventName];
        dispatch_async(dispatch_get_main_queue(), ^{
            _textView.text = eventDetailString;
        });
    });
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

@end
