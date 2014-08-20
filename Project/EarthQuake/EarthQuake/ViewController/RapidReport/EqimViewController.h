//
//  EqimViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-10.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "esriView.h"
#import "EqimListViewController.h"
#import "EqimSoap.h"
#import "EqimDetailsViewController.h"
#import "CustomViewController.h"
#import "CustDetailsViewController.h"
#import "SubjectViewController.h"
#import "SubDetailsViewController.h"
#import "QueryParams.h"
#import "MRProgressOverlayView.h"
#import "NSConfigData.h"

@class EqimViewController;
@protocol EqimViewControllerDelegate <NSObject>
-(void)eqimViewControllerReturn:(EqimViewController *)controller ;

@end

@interface EqimViewController : UIViewController<esriViewDelegate,UITabBarDelegate,EqimSoapDelegate,EqimListViewControllerDelegate,EqimDetailsViewControllerDelegate,CustomViewControllerDelegate,CustDetailsViewControllerDelegate,SubjectViewControllerDelegate,SubDetailsViewControllerDelegate>

@property (weak,nonatomic) id <EqimViewControllerDelegate> delegate;
@property (strong,nonatomic) EqimSoap *eqimSoap;
@property (weak, nonatomic) NSString *type;
@property (weak, nonatomic) NSString *days;
@property (weak,nonatomic) AGSGraphic *detailsAGS;
@property (strong,nonatomic) QueryParams *queryParams;
@property (strong,nonatomic) AGSFeatureSet *featrueSet;

@property (strong,nonatomic) NSConfigData *configData;
@property (weak ,nonatomic) EqimListViewController *eqimListViewController;
@property (weak ,nonatomic) EqimDetailsViewController *eqimDetailsViewController;
@property (weak ,nonatomic) CustomViewController *customViewController;
@property (weak ,nonatomic) CustDetailsViewController *customDetailsViewController;
@property (weak ,nonatomic) SubDetailsViewController *subDetailsViewController;
@property (weak ,nonatomic) SubjectViewController *subjectViewController;
@property (strong,nonatomic)  esriView *esriView;
@property (weak, nonatomic) IBOutlet UIView *conView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *eqimBarItem;

- (IBAction)returnHome:(id)sender;
@end
