//
//  FeelViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-6-5.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "FeelViewController.h"

@interface FeelViewController ()

@end

@implementation FeelViewController

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
    self.esriView               = [[esriView alloc] initWithFrame:self.conView.frame];
    self.esriView.delegate      = self;
    
    [self.conView addSubview:self.esriView];
    [self.esriView locationAct:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"mapTofeelcollect"]){
        self.feelColViewController = [segue destinationViewController];
        self.feelColViewController.delegate =self;
        self.feelColViewController.locationGP   = self.esriView.locationGrp;
        
    }
}

-(void)feelColViewControllerReturn:(FeelColViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)addFeelCol:(id)sender {
    [self performSegueWithIdentifier:@"mapTofeelcollect" sender:nil];
}

- (IBAction)returnToHome:(id)sender {
    [self.delegate feelViewControllerReturn:self];
}
@end
