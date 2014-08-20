//
//  CustomForm.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-21.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Bootstrap.h"
#import "CustomInfoSoap.h"
#import "NSConfigData.h"
#import "CusInfoSetSoap.h"
@class CustomForm;
@protocol CustomFormDelegate <NSObject>
-(void)customFormAddPro:(CustomForm *)controller;

-(void)customFormAddCut:(CustomForm *)controller;

@end
@interface CustomForm : UIView<UITextFieldDelegate,CusInfoSetSoapDelegate,CustomInfoSoapDelegate>

@property (weak,nonatomic) id <CustomFormDelegate> delegate;
@property (strong,nonatomic) CustomInfoSoap *customInfoSoap;
@property (strong,nonatomic) CusInfoSetSoap *cusInfoSetSoap;
@property (strong,nonatomic) NSConfigData *configData;
@property (strong,nonatomic) NSDictionary *userDic;

@property (strong,nonatomic) NSString *infoId;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *startLatText;
@property (weak, nonatomic) IBOutlet UITextField *startLonText;
@property (weak, nonatomic) IBOutlet UITextField *endLatText;
@property (weak, nonatomic) IBOutlet UILabel *proLabel;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;
@property (weak, nonatomic) IBOutlet UIButton *smsBtn;

@property (weak, nonatomic) IBOutlet UITextField *endLonText;
@property (weak, nonatomic) IBOutlet UIButton *saveBut;
@property (weak, nonatomic) IBOutlet UIButton *addProBut;
@property (weak, nonatomic) IBOutlet UIButton *cutProBut;
@property (weak, nonatomic) IBOutlet UITextField *mStartText;
@property (weak, nonatomic) IBOutlet UITextField *mEndText;
- (IBAction)addProButAct:(id)sender;
- (IBAction)cutBoundButAct:(id)sender;
- (IBAction)saveButAct:(id)sender;
- (IBAction)emailButAct:(id)sender;
- (IBAction)smsButAct:(id)sender;


// 记录弹出的虚拟键盘在屏幕中Y轴方向的坐标
@property float keyboardY;
// 记录状态栏的高度值
@property float statusBarHeight;
// 指向当前用户操作的Text Field 对象
@property (weak,nonatomic) UITextField *currentTextField;

@property (strong, nonatomic) UIButton *doneInKeyboardButton;
@end
