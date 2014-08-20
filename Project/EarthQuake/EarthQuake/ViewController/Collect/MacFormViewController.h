//
//  MacFormViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-26.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>
#import "NSConfigData.h"
#import "MacinfoData.h"
#import "MacinfoSoap.h"
#import "MRProgressOverlayView.h"
#import "CustomIOS7AlertView.h"
#import "MediaView.h"

@class MacFormViewController;
@protocol MacFormViewControllerDelegate <NSObject>
-(void)MacFormViewControllerReturn:(MacFormViewController *)controller Save:(BOOL)save;

@end

@interface MacFormViewController : UIViewController<UITextFieldDelegate,MacinfoSoapDelegate>
@property (weak,nonatomic) id <MacFormViewControllerDelegate> delegate;
@property (strong,nonatomic) MediaView *media;
@property (strong,nonatomic) CustomIOS7AlertView *progressView;
@property (strong,nonatomic) MacinfoData *macInfoData;
@property (strong,nonatomic) MacinfoSoap *macInfoSoap;
@property (strong,nonatomic) NSDictionary *userDic;
@property (strong,nonatomic) NSDictionary *selDic;
@property (strong,nonatomic) NSConfigData *configData;
@property (strong,nonatomic) AGSGraphic *locationGP;
@property (strong,nonatomic) NSString *infoId;
// 记录弹出的虚拟键盘在屏幕中Y轴方向的坐标
@property float keyboardY;
// 记录状态栏的高度值
@property float statusBarHeight;
// 指向当前用户操作的Text Field 对象
@property (weak,nonatomic) UITextField *currentTextField;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *lonField;
@property (weak, nonatomic) IBOutlet UITextField *latField;
@property (weak, nonatomic) IBOutlet UITextField *departField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *detailField;
@property (weak, nonatomic) IBOutlet UIScrollView *srollView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UIView *mediaView;

- (IBAction)returnToList:(id)sender;
- (IBAction)uploadData:(id)sender;

@end
