//
//  LoginViewController.m
//  RapidReport_P
//
//  Created by hvit-pc on 14-3-15.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "LoginoffViewController.h"

@interface LoginoffViewController ()

@end

@implementation LoginoffViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.key = @"earth125";
    self.configData = [[NSConfigData alloc]init];
    
    self.userDic = [self.configData getUserDic];
    
    self.accountText.delegate = self;
    self.accountText.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    self.accountText.layer.borderWidth= 1.0f;
    self.accountText.text = [self.userDic objectForKey:@"Username"];
    
    self.passwordText.delegate = self;
    self.passwordText.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    self.passwordText.layer.borderWidth= 1.0f;
    self.passwordText.text = [DesUtil decryptUseDES:[self.userDic objectForKey:@"Userpwd"] key:self.key];

    self.rememberSwitch.transform = CGAffineTransformMakeScale(0.6, 0.6);
    self.rememberSwitch.on = YES;
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]  isEqualToString:@"Register"]){
        self.registerViewController = [segue destinationViewController];
        self.registerViewController.delegate =self;
    
    }
}

-(void) keyboardDidShow:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    CGRect statusBarFrame = [[UIApplication sharedApplication]statusBarFrame];
    
    self.statusBarHeight = statusBarFrame.size.height;
    self.keyboardY = keyboardFrame.origin.y-100;
    
    if (self.currentTextField!=nil) {
        
        float textFieldTop = self.currentTextField.frame.origin.y;
        float textFieldBottom = textFieldTop +self.currentTextField.frame.size.height;
        
        if (textFieldBottom>self.keyboardY) {
            [(UIScrollView *)self.scrollView setContentOffset:CGPointMake(0, textFieldBottom-self.keyboardY+self.statusBarHeight)animated:YES];
        }
        
    }
}

//-(BOOL) textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    return YES;
//}
-(void) textFieldDidBeginEditing:(UITextField *)textField{
    self.currentTextField = textField;
    
    float textFieldTop = self.currentTextField.frame.origin.y;
    float textFieldBottom = textFieldTop + self.currentTextField.frame.size.height;
    
    if ((textFieldBottom>self.keyboardY)&&(self.keyboardY!=0.0)) {
        [self.scrollView setContentOffset:CGPointMake(0, textFieldBottom-self.keyboardY +self.statusBarHeight)animated:YES];
    }
}


-(void)keyboardDidHide:(NSNotification *)notification{
    //如果doneInKeyboardButton按钮出现在屏幕上，将其从视图中移除
    
    [(UIScrollView *)self.scrollView setContentOffset:CGPointMake(0, 0)animated:YES];
}


//用户注销
-(void)loginoffViewControllerDone:(LogininViewController *)controller{
    [self viewDidLoad];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//登录成功后页面跳转
-(void)loginSoapDidReturn:(LoginSoap *) p_soap{
    //友好界面隐藏
    [_configData performBlock:^{
        [_progressView close];
        [_configData performBlock:^{
            [_configData showAlert:p_soap.msg];
             [_delegate loginoffViewControllerReturn:self];
        } afterDelay:1.0];
    } afterDelay:1.0];
   
}

//注册返回
-(void)registerViewControllerReturn:(RegisterViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
};

//注册保存
-(void)registerViewControllerSure:(RegisterViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
};


- (IBAction)login:(id)sender {
    
    //键盘隐藏
    [self textFieldShouldReturn:_passwordText];
    //弹出等待友好界面
    _progressView = [_configData getAlert:@"登陆中..."];
    [_progressView show];
    
    self.loginSoap = [[LoginSoap alloc]init];
    
    self.loginSoap.remember = [self.rememberSwitch isOn];
    self.loginSoap.delegate = self;
    [self.loginSoap getData:self.accountText.text password:[DesUtil encryptUseDES:self.passwordText.text key:self.key]];
    
}

- (IBAction)returnHome:(id)sender {
    
    [self.delegate loginoffViewControllerReturn:self];
    
}

@end
