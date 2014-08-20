//
//  LoginViewController.h
//  RapidReport_P
//
//  Created by hvit-pc on 14-3-15.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogininViewController.h"
#import "RegisterViewController.h"
#import "DesUtil.h"
#import "LoginSoap.h"
#import "NSConfigData.h"
#import "CustomIOS7AlertView.h"
#import "MRProgressOverlayView.h"
@class LoginoffViewController;
@protocol LoginoffViewControllerDelegate <NSObject>
-(void)loginoffViewControllerReturn:(LoginoffViewController *)controller ;

@end

@interface LoginoffViewController : UIViewController
<UITextFieldDelegate,RegisterViewControllerDelegate,LoginSoapDelegate>
@property (weak,nonatomic) id <LoginoffViewControllerDelegate> delegate;
@property (strong,nonatomic) CustomIOS7AlertView *progressView;
@property (strong,nonatomic) LoginSoap *loginSoap;
@property (strong,nonatomic) NSConfigData *configData;

@property (weak,nonatomic)  RegisterViewController *registerViewController;
@property (strong,nonatomic) NSMutableDictionary *userDic;
@property (strong,nonatomic) NSString *key;

// 记录弹出的虚拟键盘在屏幕中Y轴方向的坐标
@property float keyboardY;
// 记录状态栏的高度值
@property float statusBarHeight;
// 指向当前用户操作的Text Field 对象
@property (weak,nonatomic) UITextField *currentTextField;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;


- (IBAction)login:(id)sender;
- (IBAction)returnHome:(id)sender;


@end
