//
//  CusEqimViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-6-12.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomInfoSoap.h"
#import "NSConfigData.h"
#import "CusInfoSetSoap.h"
#import "ProViewController.h"
#import "CutViewController.h"
#import "CustomIOS7AlertView.h"


@class CusEqimViewController;
@protocol CusEqimViewControllerDelegate <NSObject>
-(void)CusEqimViewControllerReturn:(CusEqimViewController *)controller ;
-(void)eqimViewReloadList:(CustomRecordSoap *) p_soap;

@end

@interface CusEqimViewController : UIViewController<UITextFieldDelegate,ProViewControllerDelegate,CutViewControllerDelegate>
@property (weak,nonatomic) id <CusEqimViewControllerDelegate> delegate;
@property (strong,nonatomic) MRProgressOverlayView *progressView;
@property (strong,nonatomic) CustomIOS7AlertView *progressViewnew;
@property (strong,nonatomic) NSConfigData *configData;
@property (strong,nonatomic)ProViewController *proView;
@property (strong,nonatomic)CutViewController *cutView;
@property (strong,nonatomic) CusInfoSetSoap *cusInfoSetSoap;

@property (strong,nonatomic) NSDictionary *userDic;
@property (strong,nonatomic) NSString *infoId;
@property (strong,nonatomic) NSDictionary *selDic;

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
- (IBAction)returnToCustom:(id)sender;


// 记录弹出的虚拟键盘在屏幕中Y轴方向的坐标
@property float keyboardY;
// 记录状态栏的高度值
@property float statusBarHeight;
// 指向当前用户操作的Text Field 对象
@property (weak,nonatomic) UITextField *currentTextField;

@property (strong, nonatomic) UIButton *doneInKeyboardButton;
@end
