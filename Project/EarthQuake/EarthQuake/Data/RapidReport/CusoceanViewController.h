//
//  CusoceanViewController.h
//  EarthQuake
//
//  Created by apple on 14-6-23.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"
#import "CustomInfoSoap.h"
#import "NSConfigData.h"
#import "CusInfoSetSoap.h"
#import "MRProgressOverlayView.h"
#import "CustomIOS7AlertView.h"



@class CusoceanViewController;
@protocol CusoceanViewControllerDelegate <NSObject>;
-(void)CusoceanViewControllerReturn:(CusoceanViewController *)controller ;
-(void)eqimViewReloadList:(CustomRecordSoap *) p_soap;
@end
@interface CusoceanViewController : UIViewController<UITextFieldDelegate>
@property (weak,nonatomic) id <CusoceanViewControllerDelegate > delegate;

@property (strong,nonatomic) CustomIOS7AlertView *progressView;
@property (strong,nonatomic) CustomInfoSoap *customInfoSoap;
@property (strong,nonatomic) CusInfoSetSoap *cusInfoSetSoap;
@property (strong,nonatomic) NSConfigData *configData;
@property (strong,nonatomic) NSDictionary *userDic;
@property (strong,nonatomic) NSString *infoId;
@property (strong,nonatomic) NSDictionary *selDic;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *startLatText;
@property (weak, nonatomic) IBOutlet UITextField *startLonText;
@property (weak, nonatomic) IBOutlet UITextField *endLatText;
@property (nonatomic, strong) IBOutlet RadioButton* radioButton;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;
@property (weak, nonatomic) IBOutlet UIButton *smsBtn;

@property (weak, nonatomic) IBOutlet UITextField *endLonText;
@property (weak, nonatomic) IBOutlet UIButton *saveBut;
@property (weak, nonatomic) IBOutlet UITextField *mStartText;
@property (weak, nonatomic) IBOutlet UITextField *mEndText;

- (IBAction)onRadioBtn:(id)sender;

- (IBAction)saveButAct:(id)sender;
- (IBAction)emailButAct:(id)sender;
- (IBAction)smsButAct:(id)sender;
- (IBAction)returnTOCUS:(id)sender;


// 记录弹出的虚拟键盘在屏幕中Y轴方向的坐标
@property float keyboardY;
// 记录状态栏的高度值
@property float statusBarHeight;
// 指向当前用户操作的Text Field 对象
@property (weak,nonatomic) UITextField *currentTextField;

@property (strong, nonatomic) UIButton *doneInKeyboardButton;
@end
