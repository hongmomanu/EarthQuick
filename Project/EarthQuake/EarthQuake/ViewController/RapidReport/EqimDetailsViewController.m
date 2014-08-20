//
//  EqimDetailsViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-16.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "EqimDetailsViewController.h"

@interface EqimDetailsViewController ()

@end

@implementation EqimDetailsViewController

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
    self.titleNav.title = [self disTitle:self.typeTitle];
    self.mLab.text = [self.agsGraphic attributeAsStringForKey:@"M"];
    self.locationCNameLab.text = [self.agsGraphic attributeAsStringForKey:@"LocationCname"];
    self.oTimeLab.text = [self.agsGraphic attributeAsStringForKey:@"OTime"];
    self.depthLab.text = [self.agsGraphic attributeAsStringForKey:@"Depth"];
    self.lonLab.text = [self.agsGraphic attributeAsStringForKey:@"Lon"];
    self.latLab.text = [self.agsGraphic attributeAsStringForKey:@"Lat"];
    
    
    AGSPoint *locPoint = (AGSPoint *)self.locationGrp.geometry;
    double cataLon = [[self.agsGraphic attributeAsStringForKey:@"Lon"] doubleValue];
    double cataLat = [[self.agsGraphic attributeAsStringForKey:@"Lat"] doubleValue];
    long distance = [MapUtil getDistanceLatA:locPoint.y lngA:locPoint.x latB:cataLat lngB:cataLon];
    
    double distaceDou = (round((distance))/100000)*100;
    
    self.distanceLab.text = [NSString stringWithFormat:@"%.2fkm", distaceDou] ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)disTitle:(NSString *)type{
    NSString *eqimType;
    if ([type isEqualToString:@"Auto"]) {
        eqimType = @"自动速报详情";
    }else{
        eqimType = @"正式速报详情";
    }
    return eqimType;
}

- (IBAction)returnMap:(id)sender {
    [self.delegate eqimDetailsViewControllerReturn:self];
}
@end
