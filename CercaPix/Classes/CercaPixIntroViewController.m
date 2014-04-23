//
//  CercaPixIntroViewController.m
//  CercaPix
//
//  Created by kramden.com on 4/23/14.
//  Copyright (c) 2014 kramden.com. All rights reserved.
//

#import "CercaPixIntroViewController.h"

@interface CercaPixIntroViewController ()

@end

@implementation CercaPixIntroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =  YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
