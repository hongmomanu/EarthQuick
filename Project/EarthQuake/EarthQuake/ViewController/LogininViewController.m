//
//  LogininViewController.m
//  RapidReport_P
//
//  Created by hvit-pc on 14-3-19.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "LogininViewController.h"

@interface LogininViewController ()

@end

@implementation LogininViewController


- (void)viewDidLoad
{
	// Do any additional setup after loading the view.
    [super viewDidLoad];
    self.configData = [[NSConfigData alloc]init];
    self.userDic = [self.configData getUserDic];
    if ((NSNull *)[self.userDic objectForKey:@"Username"] != [NSNull null]) {
        self.userNameField.text = [self.userDic objectForKey:@"Username"];
    }
    if ((NSNull *)[self.userDic objectForKey:@"Name"] != [NSNull null]) {
        self.nameField.text = [self.userDic objectForKey:@"Name"];
    }
    if ((NSNull *)[self.userDic objectForKey:@"Mobiletel"] != [NSNull null]) {
        self.mobileField.text = [self.userDic objectForKey:@"Mobiletel"];
    }
    if ((NSNull *)[self.userDic objectForKey:@"Email"] != [NSNull null]) {
        self.emailField.text = [self.userDic objectForKey:@"Email"];
    }
    if ((NSNull *)[self.userDic objectForKey:@"Note"] != [NSNull null]) {
        self.noteField.text = [self.userDic objectForKey:@"Note"] ;
    }
    
    self.userNameField.delegate = self;
    self.nameField.delegate = self;
    self.mobileField.delegate = self;
    self.emailField.delegate = self;
    self.noteField.delegate = self;

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]  isEqualToString:@"inTooff"]){
        LoginoffViewController *loginoffViewController = [segue destinationViewController];
        loginoffViewController.delegate =self;
        
    }
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
    [self.noteField resignFirstResponder];
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

- (IBAction)Loginoff:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"确定注销用户吗？" delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"确定",nil];
    // 显示
    [alert show];

}



//确定注销
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        [self.userDic setValue:@"" forKey:@"Userpwd"];
        [self.userDic setValue:nil forKey:@"TabRoles"];
        NSConvert *convert = [[NSConvert alloc]init];
        
        [[convert NSDictionaryToNsData:self.userDic ] writeToFile:self.configData.getUserPath atomically:YES];
         [self performSegueWithIdentifier:@"inTooff" sender:nil];
        //[[self delegate] loginoffViewControllerDone:self];
    }
}

- (IBAction)ModifyUser:(id)sender {
    self.modifyUserSoap  = [[ModifyUserSoap alloc]init];
    self.modifyUserSoap.delegate = self;
    [self.modifyUserSoap ModifyUser:self.userNameField.text
                             userId:[self.userDic objectForKey:@"Userid"]
                           password:[self.userDic objectForKey:@"Userpwd"]
                               name:self.nameField.text
                          mobiletel:self.mobileField.text
                              email:self.emailField.text
                               note:self.noteField.text
                               imei:[self.userDic objectForKey:@"Imei"]];
}
-(void)loginoffViewControllerReturn:(LoginoffViewController *)controller{
    [self retrunHome:nil];
}

- (IBAction)retrunHome:(id)sender {
    [self.delegate logininViewControllerReturn:self];
}

//修改成功后
-(void)ModifyUserSoapDidReturn:(ModifyUserSoap *) modifyUserSoap{

        [self.userDic setValue:self.emailField.text forKey:@"Email"];
        [self.userDic setValue:self.nameField.text forKey:@"Name"];
        [self.userDic setValue:self.mobileField.text forKey:@"Mobiletel"];
        [self.userDic setValue:self.noteField.text forKey:@"Note"];
    
    NSConvert *nsConvert = [[NSConvert alloc]init];
    [[nsConvert NSDictionaryToNsData:self.userDic ] writeToFile:self.configData.getUserPath atomically:YES];
}
@end
