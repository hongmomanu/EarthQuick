//
//  PubViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-13.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"
#import "UAModalPanel.h"
#import "SimDescribePanel.h"
#import "PubIntensityPanel.h"
#import "WebViewController.h"
#import <ArcGIS/ArcGIS.h>
#import "NSConfigData.h"
#import "PubInfoSoap.h"
#import "MRProgressOverlayView.h"
#include <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "CustomIOS7AlertView.h"
#import "MediaView.h"



@class PubViewController;
@protocol PubViewControllerDelegate <NSObject>
-(void)PubViewControllerReturn:(PubViewController *)controller ;

@end
@interface PubViewController : UIViewController<UITextFieldDelegate,
                                                WebViewControllerDelegate,
                                                UAModalPanelDelegate,
                                                PubInfoSoapDelegate,
                                                UIActionSheetDelegate,
                                                UINavigationBarDelegate,UIScrollViewDelegate >

@property (weak,nonatomic) id <PubViewControllerDelegate> delegate;
@property (strong,nonatomic) MediaView *media;
@property (strong,nonatomic) PubInfoSoap *pubInfoSoap;              // 公众服务接口访问
@property (strong,nonatomic) SimDescribePanel *simDescribePanel;    // 简要描述弹出框
@property (strong,nonatomic) PubIntensityPanel *pubIntensityPanel;  // 简要烈度弹出框
@property (strong,nonatomic) WebViewController *webViewController;  // 烈度列表界面
@property (strong,nonatomic) NSConfigData *configData;              // 公用类
@property (strong,nonatomic) NSString *infoId;                      // 公众上报ID
@property (strong,nonatomic) CustomIOS7AlertView *progressView;   // 友好等待弹出框
@property (strong,nonatomic) AGSGraphic *locationGP;                // 定位要数
@property (strong,nonatomic) AGSPoint *locationP;                   // 定位点坐标
@property float keyboardY;                                          // 记录弹出的虚拟键盘在屏幕中Y轴方向的坐标
@property float statusBarHeight;                                    // 记录状态栏的高度值
@property (weak,nonatomic) UITextField *currentTextField;           // 指向当前用户操作的Text Field 对象

@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *detailsField;
@property (weak, nonatomic) IBOutlet UIButton *pubIntensityLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet RadioButton* radioButton;
@property (weak, nonatomic) IBOutlet UIButton *simDescribeLable;

@property (weak, nonatomic) IBOutlet UIView *mediaView;


- (IBAction)returnToMap:(id)sender;
- (IBAction)showPanel:(id)sender;
- (IBAction)pubToList:(id)sender;
- (IBAction)showIntensity:(id)sender;
- (IBAction)uploadData:(id)sender;


@end
