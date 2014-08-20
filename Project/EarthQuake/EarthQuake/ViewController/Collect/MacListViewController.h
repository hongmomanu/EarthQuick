//
//  MacListViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-26.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>
#import "MacFormViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "ProCell.h"
#import "MacinfoData.h"
#import "CustomIOS7AlertView.h"
#import "MacinfoSoap.h"

@class MacListViewController;
@protocol MacListViewControllerDelegate <NSObject>
-(void)MacListViewControllerReturn:(MacListViewController *)controller ;

@end

@interface MacListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate,EGORefreshTableHeaderDelegate,MacFormViewControllerDelegate,MacinfoSoapDelegate>
@property (weak,nonatomic) id <MacListViewControllerDelegate> delegate;
@property (weak,nonatomic) MacFormViewController *macFormViewController;
@property (strong,nonatomic) NSConfigData *configData;
@property (strong,nonatomic) MacinfoData *macinfoData;
@property (strong,nonatomic) MacinfoSoap *macInfoSoap;
@property (strong,nonatomic) CustomIOS7AlertView *progressView;
@property (strong,nonatomic) EGORefreshTableHeaderView *tableHeaderView;    //TableView 下拉刷新
@property (assign,nonatomic) BOOL reloading;                                //是否刷新

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSDictionary *selDic;
@property (strong,nonatomic) AGSGraphic *locationGP;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addToMacForm:(id)sender;
- (IBAction)returnToMap:(id)sender;

@end
