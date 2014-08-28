//
//  CusSKViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-6-13.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "CusSKViewController.h"

@interface CusSKViewController ()

@end

@implementation CusSKViewController

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
	// Do any additional setup after loading the view.
    
    
    self.mStartText.delegate = self;
    self.mEndText.delegate = self;
    
    
    self.configData = [[NSConfigData alloc]init];
    self.userDic = [self.configData getUserDic];
    self.infoId = @"null";
    
    if (_selDic != nil) {
        [self initRe];
    }
}

-(void) initRe{
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
        [_progressView close];
        [_configData performBlock:^{
            [_configData showAlert:p_soap.msg];
            [self.delegate eqimViewReloadList :p_soap];
            [self returnToCustom:self];
        } afterDelay:1.0];
    } afterDelay:1.0];
}

- (IBAction)saveButAct:(id)sender {
    self.progressView = [self.configData getAlert:@"加载中..."];
    [self.progressView show];
    
    self.cusInfoSetSoap = [[CusInfoSetSoap alloc]init];
    self.cusInfoSetSoap.delegate = self;
    
    NSString *smsState;
    NSString *emailState;
    if (self.smsBtn.selected) {
        smsState = @"true";
    }else{
        smsState = @"false";
    }
    if (self.emailBtn.selected) {
        emailState = @"true";
    }else{
        emailState = @"false";
    }
    [self.cusInfoSetSoap SetInfoCus:(NSString *) self.infoId
                             userId:(NSString *) [self.userDic objectForKey:@"Userid"]
                               type:(NSString *) @"CzCataLogSk"
                               maxx:(NSString *) self.endLonText.text
                               maxy:(NSString *) self.endLatText.text
                               minx:(NSString *) self.startLonText.text
                               miny:(NSString *) self.startLatText.text
                             mSmall:(NSString *) self.mStartText.text
                             mLarge:(NSString *) self.mEndText.text
                          conserStr:(NSString *) [smsState stringByAppendingFormat:@",%@",emailState]
                           province:(NSString *) @""];
}

- (IBAction)emailButAct:(id)sender {
    if (self.emailBtn.isSelected) {
        [self.emailBtn setSelected:FALSE];
    }else{
        [self.emailBtn setSelected:TRUE];
    }
}

- (IBAction)smsButAct:(id)sender {
    if (self.smsBtn.isSelected) {
        [self.smsBtn setSelected:FALSE];
    }else{
        [self.smsBtn setSelected:TRUE];
    }
}

- (IBAction)returnToCustom:(id)sender {
    [self.delegate CusSKViewControllerReturn:self];
}

- (IBAction)onRadioBtn:(id)sender {
    if (_radioButton.selectedButton.tag == 0) {
        _startLonText.text = @"119.67";
        _startLatText.text = @"27.55";
        _endLonText.text = @"120.25";
        _endLatText.text = @"27.82";
    }else{
        _startLonText.text = @"119.52";
        _startLatText.text = @"27.98";
        _endLonText.text = @"120.37";
        _endLatText.text = @"28.2";
    }
}
@end
