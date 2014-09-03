//
//  CusoceanViewController.m
//  EarthQuake
//
//  Created by apple on 14-6-23.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "CusoceanViewController.h"

@interface CusoceanViewController ()

@end

@implementation CusoceanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mEndText.delegate = self;
    self.startLatText.delegate=self;
    self.startLonText.delegate=self;
    
    self.endLatText.delegate=self;
    self.endLonText.delegate=self;
    

    
    
    self.configData = [[NSConfigData alloc]init];
    self.userDic = [self.configData getUserDic];
    self.infoId = @"null";
    
    if (_selDic != nil) {
        [self initRe];
    }
}
-(void) initRe
{
    self.infoId = [[_selDic objectForKey:@"Id"] stringValue];
    self.startLatText.text = [NSString stringWithFormat:@"%.3f",[[_selDic objectForKey:@"Miny"] doubleValue]];
    self.startLonText.text = [NSString stringWithFormat:@"%.3f",[[_selDic objectForKey:@"Minx"] doubleValue]];
    self.endLatText.text = [NSString stringWithFormat:@"%.3f",[[_selDic objectForKey:@"Maxy"] doubleValue]];
    self.endLonText.text = [NSString stringWithFormat:@"%.3f",[[_selDic objectForKey:@"Maxx"] doubleValue]];
    self.mStartText.text = [NSString stringWithFormat:@"%.2f",[[_selDic objectForKey:@"Msmall"] doubleValue]];
    self.mEndText.text = [NSString stringWithFormat:@"%.2f",[[_selDic objectForKey:@"Mlarge"] doubleValue]];
    
    NSDictionary *cusSer = [_selDic objectForKey:@"TabCustomsers"];
    if (cusSer.count>0) {
        for (int i=0; i<cusSer.count; i++) {
            if ([[[(NSArray *)cusSer objectAtIndex:i] objectForKey:@"Field"] isEqualToString:@"SMS"]) {
                [self.smsBtn setSelected:TRUE];
            }else if([[[(NSArray *)cusSer objectAtIndex:i] objectForKey:@"Field"] isEqualToString:@"EMAIL"]){
                [self.emailBtn setSelected:TRUE];
            }
        }
    }
    
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification object:nil];
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
/*!
 @method
 @abstract 防止被键盘遮盖
 @result 空值
 */
-(void) keyboardDidShow:(NSNotification *)notification{
    NSDictionary *info          = [notification userInfo];
    CGRect keyboardFrame        = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect statusBarFrame       = [[UIApplication sharedApplication]statusBarFrame];
    _statusBarHeight            = statusBarFrame.size.height;
    _keyboardY                  = keyboardFrame.origin.y-100;
    
    if (_currentTextField != nil) {
        float textFieldTop      = _currentTextField.frame.origin.y;
        float textFieldBottom   = textFieldTop +_currentTextField.frame.size.height;
        if (textFieldBottom > _keyboardY) {
            [(UIScrollView *) _scrollView setContentOffset:CGPointMake(0, textFieldBottom-_keyboardY+_statusBarHeight)animated:YES];
        }
    }
}
/*!
 @method
 @abstract 点击Done隐藏键盘
 @result 空值
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //NSLog(@"huidianlememememe");
    [textField resignFirstResponder];
    return YES;
}
/*!
 @method
 @abstract 防止被键盘遮盖
 @result 空值
 */
-(void) textFieldDidBeginEditing:(UITextField *)textField{
    _currentTextField       = textField;
    float textFieldTop      = _currentTextField.frame.origin.y;
    float textFieldBottom   = textFieldTop + _currentTextField.frame.size.height;
    if ((textFieldBottom > _keyboardY) && (_keyboardY != 0.0)) {
        [_scrollView setContentOffset:CGPointMake(0, textFieldBottom - _keyboardY + _statusBarHeight)animated:YES];
    }
}

/*!
 @method
 @abstract 隐藏键盘
 @result 空值
 */
-(void)keyboardDidHide:(NSNotification *)notification{
    //如果doneInKeyboardButton按钮出现在屏幕上，将其从视图中移除
    [(UIScrollView *)_scrollView setContentOffset:CGPointMake(0, 0)animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cusInfoSetSoapDidReturn:(CusInfoSetSoap *) p_soap {
    //友好界面隐藏
    [_configData performBlock:^{
        
        [_configData performBlock:^{
            [_progressView close];
            [_configData showAlert:p_soap.msg];
            [self.delegate eqimViewReloadList :p_soap];
             [self returnTOCUS:self];
        } afterDelay:1.0];
    } afterDelay:1.0];
}

- (IBAction)returnTOCUS:(id)sender
{
   [self.delegate CusoceanViewControllerReturn:self];
}
- (IBAction)emailButAct:(id)sender
{
    if (self.emailBtn.isSelected)
    {
        [self.emailBtn setSelected:FALSE];
    }
    else
    {
        [self.emailBtn setSelected:TRUE];
    }

}
- (IBAction)smsButAct:(id)sender
{
    
    if (self.smsBtn.isSelected) {
        [self.smsBtn setSelected:FALSE];
    }else{
        [self.smsBtn setSelected:TRUE];
    }
}
- (IBAction)saveButAct:(id)sender
{
    self.progressView = [self.configData getAlert:@"加载中..."];
    [self.progressView show];
    self.cusInfoSetSoap = [[CusInfoSetSoap alloc]init];
    self.cusInfoSetSoap.delegate = self;
    NSString *smsState;
    NSString *emailState;
    if (self.smsBtn.selected)
    {
        smsState = @"true";
    }
    else
    {
        smsState = @"false";
    }
    if (self.emailBtn.selected)
    {
        emailState = @"true";
    }
    else
    {
        emailState = @"false";
    }
    [self.cusInfoSetSoap SetInfoCus:(NSString *) self.infoId
                             userId:(NSString *) [self.userDic objectForKey:@"Userid"]
                               type:(NSString *) @"CzCataLogSO"
                               maxx:(NSString *) self.endLonText.text
                               maxy:(NSString *) self.endLatText.text
                               minx:(NSString *) self.startLonText.text
                               miny:(NSString *) self.startLatText.text
                             mSmall:(NSString *) self.mStartText.text
                             mLarge:(NSString *) self.mEndText.text
                          conserStr:(NSString *) [smsState stringByAppendingFormat:@",%@",emailState]
                           province:(NSString *) @""];
}
- (IBAction)onRadioBtn:(id)sender {
    
}

@end
