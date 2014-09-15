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
    [self.conView addSubview:self.segmentedView];
    
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

- (IBAction)basemapChanged:(UISegmentedControl *)sender {
    
    int basemapURL = 0 ;
    UISegmentedControl* segControl = (UISegmentedControl*)sender;
    switch (segControl.selectedSegmentIndex) {
        case 0: //gray
            basemapURL = TIANDITU_VECTOR_2000;
            break;
        case 1: //oceans
            basemapURL = TIANDITU_IMAGE_2000;
            break;
        default:TIANDITU_VECTOR_2000;
            break;
    }
    
    AGSMapView *cusmapView =[self.esriView mapView];
    NSError* err;
    TianDiTuWMTSLayer* TianDiTuLyr = [[TianDiTuWMTSLayer alloc]initWithLayerType:basemapURL LocalServiceURL:nil error:&err];
    
    [cusmapView removeMapLayerWithName:@"TianDiTu Layer"];
    
    [cusmapView insertMapLayer:TianDiTuLyr withName:@"TianDiTu Layer" atIndex:0];

    
}
@end
