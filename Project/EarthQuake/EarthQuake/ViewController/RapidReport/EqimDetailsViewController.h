//
//  EqimDetailsViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-16.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>
#import "MapUtil.h"

@class EqimDetailsViewController;
@protocol EqimDetailsViewControllerDelegate <NSObject>
-(void)eqimDetailsViewControllerReturn:(EqimDetailsViewController *)controller ;

@end

@interface EqimDetailsViewController : UIViewController
@property (weak,nonatomic) id <EqimDetailsViewControllerDelegate> delegate;

@property (nonatomic,strong) AGSGraphic *locationGrp;
@property (weak, nonatomic) AGSGraphic *agsGraphic;
@property (weak, nonatomic) NSString *typeTitle;
@property (weak, nonatomic) IBOutlet UILabel *locationCNameLab;
@property (weak, nonatomic) IBOutlet UILabel *oTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *mLab;
@property (weak, nonatomic) IBOutlet UILabel *depthLab;
@property (weak, nonatomic) IBOutlet UILabel *lonLab;
@property (weak, nonatomic) IBOutlet UILabel *latLab;
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleNav;
- (IBAction)returnMap:(id)sender;

@end
