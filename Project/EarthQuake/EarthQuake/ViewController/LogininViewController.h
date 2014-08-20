//
//  LogininViewController.h
//  RapidReport_P
//
//  Created by hvit-pc on 14-3-19.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSConfigData.h"
#import "NSConvert.h"
#import "ModifyUserSoap.h"
#import "LoginoffViewController.h"
@class LogininViewController;
@protocol LogininViewControllerDelegate <NSObject>
-(void)logininViewControllerReturn:(LogininViewController *)controller ;

@end

@interface LogininViewController : UIViewController<UITextFieldDelegate,ModifUserSoapDelegate,UITextViewDelegate>
@property (weak,nonatomic) id <LogininViewControllerDelegate> delegate;

- (IBAction)Loginoff:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextView *noteField;
- (IBAction)ModifyUser:(id)sender;
- (IBAction)retrunHome:(id)sender;

@property (strong,nonatomic) ModifyUserSoap *modifyUserSoap;
@property (strong,nonatomic) NSConfigData *configData;
@property (strong,nonatomic) NSMutableDictionary *userDic;


// 记录弹出的虚拟键盘在屏幕中Y轴方向的坐标
@property float keyboardY;
// 记录状态栏的高度值
@property float statusBarHeight;
// 指向当前用户操作的Text Field 对象
@property (weak,nonatomic) UITextField *currentTextField;
@property (weak,nonatomic) UITextView *currentTextView;
@property (strong, nonatomic) UIButton *doneInKeyboardButton;
@end



