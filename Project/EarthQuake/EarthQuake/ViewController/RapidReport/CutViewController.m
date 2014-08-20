//
//  CutViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-24.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "CutViewController.h"

@interface CutViewController ()

@end

@implementation CutViewController

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
	// Do any additional setup after loading the view.
    self.esriView = [[esriView alloc] initWithFrame:self.conView.frame];
    self.esriView.delegate = self;
    [self.esriView addSketchLayer];
    [self.conView addSubview:self.esriView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnBarAct:(id)sender {
    [self.delegate cutViewControllerReturn:self];
}

- (IBAction)saveBarAct:(id)sender {
    [self.delegate cutViewControllerSave:self envelopeData:self.esriView.envelope];
}

@end
