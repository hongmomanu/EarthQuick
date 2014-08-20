//
//  RegisterViewController.h
//  RapidReport_P
//
//  Created by hvit-pc on 14-3-23.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSConfigData.h"
#import "NSConvert.h"
#import "RegisterSoap.h"
#import "DesUtil.h"


@class RegisterViewController;
@protocol RegisterViewControllerDelegate <NSObject>
-(void)registerViewControllerReturn:(RegisterViewController *)controller ;

-(void)registerViewControllerSure:(RegisterViewController *)controller ;
@end
@interface RegisterViewController : UIViewController<UITextFieldDelegate,RegisterSoapDelegate,UITextViewDelegate>
@property (weak,nonatomic) id <RegisterViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UITextField *firstUserPwdField;
@property (weak, nonatomic) IBOutlet UITextField *secondUserPwdField;

- (IBAction)retrun:(id)sender;
- (IBAction)sure:(id)sender;

@property (strong,nonatomic) NSString *key;
@property (strong,nonatomic) RegisterSoap *registerSoap;
@property (strong,nonatomic) NSConfigData *configData;

// 记录弹出的虚拟键盘在屏幕中Y轴方向的坐标
@property float keyboardY;
// 记录状态栏的高度值
@property float statusBarHeight;
// 指向当前用户操作的Text Field 对象
@property (weak,nonatomic) UITextField *currentTextField;
@property (weak,nonatomic) UITextView *currentTextView;
@property (strong, nonatomic) UIButton *doneInKeyboardButton;
@end
