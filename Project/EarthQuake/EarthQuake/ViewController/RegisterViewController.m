//
//  RegisterViewController.m
//  RapidReport_P
//
//  Created by hvit-pc on 14-3-23.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "RegisterViewController.h"
#define ALERT(msg) {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"浙江地震信息网" message:msg delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];[alert show];}

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.key = @"earth125";
    self.userNameField.delegate = self;
    self.userNameField.text = @"";
    self.nameField.delegate = self;
    self.nameField.text = @"";
    self.emailField.delegate = self;
    self.emailField.text = @"";
    self.mobileField.delegate = self;
    self.mobileField.text = @"";
    self.firstUserPwdField.delegate=self;
    self.firstUserPwdField.text=@"";
    self.secondUserPwdField.delegate=self;
    self.secondUserPwdField.text = @"";
    self.noteTextView.delegate = self;
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

//-(void) viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidHideNotification object:nil];
//}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void) keyboardDidShow:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    CGRect statusBarFrame = [[UIApplication sharedApplication]statusBarFrame];
    
    self.statusBarHeight = statusBarFrame.size.height;
    self.keyboardY = keyboardFrame.origin.y;
    
    if (self.currentTextView==nil) {
        
        float textFieldTop = self.currentTextField.frame.origin.y;
        float textFieldBottom = textFieldTop +self.currentTextField.frame.size.height;
        
        if (textFieldBottom>self.keyboardY) {
            [(UIScrollView *)self.scrollView setContentOffset:CGPointMake(0, textFieldBottom-self.keyboardY+self.statusBarHeight+50)animated:YES];
        }
        
        if (self.doneInKeyboardButton.superview) {
            [self.doneInKeyboardButton removeFromSuperview];
        }
    }else{
        
        float textViewTop = self.currentTextView.frame.origin.y;
        float textViewBottom = textViewTop +self.currentTextView.frame.size.height;
        
        if (textViewBottom>self.keyboardY) {
            [(UIScrollView *)self.scrollView setContentOffset:CGPointMake(0, textViewBottom-self.keyboardY+self.statusBarHeight+50)animated:YES];
        }
        
        //如果doneInKeyboardButton没有被实例化，侧创建它
        if (self.doneInKeyboardButton == nil) {
            //设置按钮的类型为自定义
            self.doneInKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            //设置按钮在View中的位置和大小
            self.doneInKeyboardButton.frame = CGRectMake(keyboardFrame.size.width-45, keyboardFrame.origin.y-40, 48, 48);
            
            //设置按钮上显示的图标
            self.doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
            [self.doneInKeyboardButton setImage:[UIImage imageNamed:@"doneInKeyboard.png"] forState:UIControlStateNormal];
            
            //设置用户点击按钮后的执行的方法
            [self.doneInKeyboardButton addTarget:self action:@selector(handleDoneInkeyboard:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        //获取虚拟键盘所在的视图
        UIWindow* tempWindow  =[[[UIApplication sharedApplication] windows] objectAtIndex:1];
        
        //将自定义的按钮显示在虚拟键盘所在的视图上
        if (self.doneInKeyboardButton.superview == nil) {
            [tempWindow addSubview:self.doneInKeyboardButton];
        }
    }
    
}

-(void)handleDoneInkeyboard:(id)sender{
    [self.noteTextView resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField{
    self.currentTextField = textField;
    self.currentTextView = nil;
    
    float textFieldTop = self.currentTextField.frame.origin.y;
    float textFieldBottom = textFieldTop + self.currentTextField.frame.size.height;
    
    if ((textFieldBottom>self.keyboardY)&&(self.keyboardY!=0.0)) {
        [self.scrollView setContentOffset:CGPointMake(0, textFieldBottom-self.keyboardY +self.statusBarHeight+50)animated:YES];
    }
}

-(void) textViewDidBeginEditing:(UITextView *)textView{
    self.currentTextView = textView;
    self.currentTextField = nil;
    
    float textViewTop = self.currentTextView.frame.origin.y;
    float textViewBottom = textViewTop + self.currentTextView.frame.size.height;
    
    if ((textViewBottom>self.keyboardY)&&(self.keyboardY!=0.0)) {
        [self.scrollView setContentOffset:CGPointMake(0, textViewBottom-self.keyboardY +self.statusBarHeight+50)animated:YES];
    }
    
}

-(void)keyboardDidHide:(NSNotification *)notification{
    //如果doneInKeyboardButton按钮出现在屏幕上，将其从视图中移除
    if (self.doneInKeyboardButton.superview) {
        [self.doneInKeyboardButton removeFromSuperview];
    }
    
    [(UIScrollView *)self.scrollView setContentOffset:CGPointMake(0, 0)animated:YES];
}


- (IBAction)retrun:(id)sender {
    [self.delegate registerViewControllerReturn:self];
}

- (IBAction)sure:(id)sender {
    if ([self.userNameField.text isEqualToString:@""]||[self.firstUserPwdField.text isEqualToString:@""]) {
        ALERT(@"用户名和密码不能为空！");
    }else{
    if ([self.firstUserPwdField.text isEqualToString:self.secondUserPwdField.text] ) {
        self.registerSoap = [[RegisterSoap alloc]init];
        self.registerSoap.delegate = self;
        [self.registerSoap RegisterUser:self.userNameField.text userId:@"" password:[DesUtil encryptUseDES:self.firstUserPwdField.text key:self.key] name:self.nameField.text mobiletel:self.mobileField.text email:self.emailField.text note:self.noteTextView.text imei:@""];
    }else{
        self.firstUserPwdField.text = @"";
        self.secondUserPwdField.text = @"";
        ALERT(@"两次密码输入不同！");
    }
    }
    
}

-(void)registerSoapDidReturn:(RegisterSoap *) p_loginSoap{
    [self.delegate registerViewControllerSure:self];
};
@end
