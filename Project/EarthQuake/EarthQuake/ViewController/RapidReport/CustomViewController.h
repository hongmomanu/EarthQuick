//
//  CustomViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-17.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>
#import "EqimTabCell.h"
#import "CusInfoCell.h"
#import "CustomRecordSoap.h"
#import "NSConfigData.h"
#import "CusEqimViewController.h"
#import "CusSKViewController.h"
#import "CusInfoCusByUserIdSoap.h"
#import "CustomIOS7AlertView.h"
#import "CusInfoDelByIdSoap.h"
#import "CusoceanViewController.h"


@class CustomViewController;
@protocol CustomViewControllerDelegate <NSObject>
-(void)customViewControllerReturn:(CustomViewController *)controller ;
-(void)customViewControllerEnter:(CustomViewController *)controller custData:(NSDictionary *) custData custType:(NSString *)type;

-(void)customViewControllerSelect:(CustomViewController *)controller custData:(NSDictionary *) custData custType:(NSString *)type selectCell:(NSDictionary *)select;
@end

@interface CustomViewController : UIViewController<UITabBarDelegate,
    UITableViewDataSource,
    UITableViewDelegate,
    CustomRecordSoapDelegate,
    CusInfoCusByUserIdSoapDelegate,
    CusSKViewControllerDelegate,
    CusEqimViewControllerDelegate,
    SWTableViewCellDelegate,
    CusInfoDelByIdSoapDelegate,
    CusoceanViewControllerDelegate
>
@property (weak,nonatomic) id <CustomViewControllerDelegate> delegate;
@property (strong,nonatomic) NSConfigData *configData;
@property (strong,nonatomic) CustomRecordSoap *customRecordSoap;
@property (strong,nonatomic) CusEqimViewController *cusEqimViewController;
@property (strong,nonatomic) CusSKViewController *cusSKViewController;
@property (strong,nonatomic) CusInfoCusByUserIdSoap *cusInfoCusByUserIdSoap;
@property (strong,nonatomic) CustomIOS7AlertView *progressView;
@property (strong,nonatomic) CustomIOS7AlertView *progressViewnew;
@property (strong,nonatomic) CusInfoDelByIdSoap *cusInfoDelByIdSoap;
@property (strong,nonatomic) CusoceanViewController *oceanController;
@property (strong,nonatomic) NSDictionary *selDic;
@property (nonatomic, strong) UIActionSheet *typeSheet;
@property (strong,nonatomic) NSDictionary *userDic;
@property (strong, nonatomic) NSMutableArray *cusData;

@property (weak, nonatomic) IBOutlet UIView *conView;
@property (weak, nonatomic) IBOutlet UITabBarItem *messageBarItem;
@property (weak, nonatomic) IBOutlet UITableView *cusTabView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mapToolItem;
@property (weak, nonatomic) IBOutlet UITabBar *cusTabBar;
@property (weak, nonatomic) NSString *maxX1;
@property (nonatomic, strong) NSString *maxX2;
@property (nonatomic, strong) NSString *maxY1;
@property (nonatomic, strong) NSString *maxY2;
@property (nonatomic, strong) NSString *minX1;
@property (nonatomic, strong) NSString *minX2;
@property (nonatomic, strong) NSString *minY1;
@property (nonatomic, strong) NSString *minY2;
@property (nonatomic, strong) NSString *skname1;
@property (nonatomic, strong) NSString *skname2;




- (IBAction)returnTomap:(id)sender;
- (IBAction)enterTomap:(id)sender;

@end
