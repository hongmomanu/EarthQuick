//
//  FeelColViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-6-5.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetPicker.h"
#import "NSConfigData.h"
#import "FeelUploadSoap.h"
#import "MediaView.h"
#import "CustomIOS7AlertView.h"

@class FeelColViewController;
@protocol FeelColViewControllerDelegate <NSObject>
-(void)feelColViewControllerReturn:(FeelColViewController *)controller ;

@end
@interface FeelColViewController : UIViewController<UITextFieldDelegate,FeelUploadSoapDelegate>
@property (strong,nonatomic) MediaView *media;
@property float keyboardY;                                          // 记录弹出的虚拟键盘在屏幕中Y轴方向的坐标
@property float statusBarHeight;                                    // 记录状态栏的高度值
@property (weak,nonatomic) UITextField *currentTextField;           // 指向当前用户操作的Text Field 对象
@property (strong,nonatomic) NSConfigData *configData;
@property (strong,nonatomic) NSDictionary *userDic;
@property (strong,nonatomic) FeelUploadSoap *feelUploadSoap;
@property (strong,nonatomic) NSString *infoId;
@property (strong,nonatomic) CustomIOS7AlertView *progressView;   // 友好等待弹出框
@property (strong,nonatomic) AGSGraphic *locationGP;                // 定位要数
@property (strong,nonatomic) AGSPoint *locationP;                   // 定位点坐标

@property (weak, nonatomic) IBOutlet UIView *mediaView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressField;
@property (weak, nonatomic) IBOutlet UITextField *partDescribe;
@property (weak,nonatomic) IBOutlet UITextField *floorNum;
@property (weak, nonatomic) IBOutlet UIButton *describeBut;
@property (weak, nonatomic) IBOutlet UILabel *latlonLabel;
- (IBAction)returnToMap:(id)sender;
- (IBAction)describeChange:(id)sender;
- (IBAction)uploadFeel:(id)sender;
@property (weak,nonatomic) id <FeelColViewControllerDelegate> delegate;
@end
