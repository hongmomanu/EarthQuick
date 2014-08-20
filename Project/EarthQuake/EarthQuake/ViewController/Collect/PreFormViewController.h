//
//  PreFormViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-20.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CataLogSoap.h"
#import "RadioButton.h"
#import "NSConfigData.h"
#import "UAModalPanel.h"
#import "SimDescribePanel.h"
#import "PubIntensityPanel.h"
#import "PreinfoData.h"
#import "PreInfoSoap.h"
#import "CustomIOS7AlertView.h"
#import "MediaView.h"

@class PreFormViewController;
@protocol PreFormViewControllerDelegate <NSObject>
-(void)PreFormViewControllerReturn:(PreFormViewController *)controller Save:(BOOL)save;

@end
@interface PreFormViewController : UIViewController<UAModalPanelDelegate,PreInfoSoapDelegate,UITextFieldDelegate>


@property (weak,nonatomic) id <PreFormViewControllerDelegate> delegate;
@property (strong,nonatomic) MediaView *media;
@property (weak,nonatomic) NSDictionary *cataLogDic;
@property (weak,nonatomic) NSDictionary *selDic;
@property (strong,nonatomic) SimDescribePanel *simDescribePanel;
@property (strong,nonatomic) PubIntensityPanel *pubIntensityPanel;
@property (strong,nonatomic) PreInfoSoap *preinfoSoap;
@property (strong,nonatomic) PreinfoData *preinfoData;
@property (strong,nonatomic) CustomIOS7AlertView *progressView;
@property (strong,nonatomic) NSDictionary *userDic;
@property (strong,nonatomic) NSConfigData *configData;
@property (strong,nonatomic) AGSGraphic *locationGP;
@property (strong,nonatomic) NSString *infoId;

// 记录弹出的虚拟键盘在屏幕中Y轴方向的坐标
@property float keyboardY;
// 记录状态栏的高度值
@property float statusBarHeight;
// 指向当前用户操作的Text Field 对象
@property (weak,nonatomic) UITextField *currentTextField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *eqimId;
@property (weak, nonatomic) IBOutlet UILabel *eqimLonLat;
@property (weak, nonatomic) IBOutlet UILabel *eqimM;
@property (weak, nonatomic) IBOutlet UILabel *eqimLocName;
@property (weak, nonatomic) IBOutlet UILabel *eqimOTime;
@property (weak, nonatomic) IBOutlet UITextField *proName;
@property (weak, nonatomic) IBOutlet UITextField *proLon;
@property (weak, nonatomic) IBOutlet UITextField *proLat;
@property (weak, nonatomic) IBOutlet UIButton *proIntensity;
@property (weak, nonatomic) IBOutlet UIView *mediaView;
@property (strong, nonatomic) IBOutlet RadioButton *radioButton;
@property (weak, nonatomic) IBOutlet UIButton *proSimDescribe;
@property (weak, nonatomic) IBOutlet UITextField *proAddress;
@property (weak, nonatomic) IBOutlet UITextField *proDetails;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UILabel *proDate;
- (IBAction)uploadData:(id)sender;
- (IBAction)showDescribe:(id)sender;
- (IBAction)returnToProList:(id)sender;
- (IBAction)showIntensity:(id)sender;
@end
