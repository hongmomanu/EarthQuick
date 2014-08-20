//
//  PreViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-13.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import "PreFormViewController.h"
#import "CataLogSoap.h"
#import "CataLogData.h"
#import "Reachability.h"
#import "NSConfigData.h"
#import "PreinfoData.h"
#import "ProCell.h"
#import "EGORefreshTableHeaderView.h"
#import "MRProgressOverlayView.h"
#import "PreInfoSoap.h"
#import "CustomIOS7AlertView.h"

@class PreViewController;
@protocol PreViewControllerDelegate <NSObject>
-(void)PreViewControllerReturn:(PreViewController *)controller ;

- (UIView *)viewForProgressOverlay;
@end

@interface PreViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate,PreFormViewControllerDelegate,CataLogSoapDelegate,EGORefreshTableHeaderDelegate,PreInfoSoapDelegate>
@property (weak,nonatomic) id <PreViewControllerDelegate> delegate;
@property (weak,nonatomic) PreFormViewController *preFormController;
@property (strong,nonatomic) CataLogSoap *cataLogSoap;
@property (strong,nonatomic) CataLogData *cataLogData;
@property (strong,nonatomic) NSConfigData *configData;
@property (strong,nonatomic) PreinfoData *preinfoData;
@property (strong,nonatomic) PreInfoSoap *preinfoSoap;
@property (strong,nonatomic) AGSGraphic *locationGP;
@property (strong,nonatomic) Reachability *reachability;
@property (strong,nonatomic) CustomIOS7AlertView *progressView;
@property (strong,nonatomic) EGORefreshTableHeaderView *tableHeaderView;    //TableView 下拉刷新
@property (assign,nonatomic) BOOL reloading;                               //是否刷新

@property (strong,nonatomic) NSDictionary *cataLogDic;
@property (strong,nonatomic) NSDictionary *selDic;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

- (IBAction)addToPro:(id)sender;

- (IBAction)returnToMap:(id)sender;
@end
