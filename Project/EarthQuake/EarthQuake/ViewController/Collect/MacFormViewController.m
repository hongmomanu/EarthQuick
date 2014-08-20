//
//  MacFormViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-26.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "MacFormViewController.h"

@interface MacFormViewController ()

@end

@implementation MacFormViewController

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
    
    _srollView.contentSize                     = CGSizeMake(305, 500);
    NSDateFormatter* formatter;
    AGSPoint *locationP;
    
    formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    _infoId =[formatter stringFromDate:[NSDate date]];
    [formatter setDateFormat:@"YYYY年MM月dd日 HH时mm分"];
    
    _configData                 = [[NSConfigData alloc]init];
    _userDic                    = [_configData getUserDic];
    _nameField.text             = [[_userDic objectForKey:@"Name"] description];
    locationP                   = (AGSPoint *)self.locationGP.geometry;
    _lonField.text              = [NSString stringWithFormat:@"%.3f", locationP.x];
    _lonField.delegate          = self;
    _latField.text              = [NSString stringWithFormat:@"%.3f", locationP.y];
    _latField.delegate          = self;
    _departField.delegate       = self;
    _dateLabel.text             = [formatter stringFromDate:[NSDate date]];
    _addressField.text          = [_configData getLocationAddress:locationP.x Lat:locationP.y];
    _addressField.delegate      = self;
    _detailField.delegate       = self;
    
    self.media               = [[MediaView alloc] initWithFrame:self.mediaView.frame];
    self.media.supViewCon = self;
    self.media.modelType = @"MACROSCOPIC";
    self.media.infoId = _infoId;
    [self.mediaView addSubview:self.media];
    
    if (_selDic != nil) {
        [self initRe];
    }
}

-(void)initRe{
    _infoId                    = [[_selDic objectForKey:@"InfoId"] description];
    self.media.infoId = _infoId;
    _nameField.text            = [[_selDic objectForKey:@"Name"] description];
    _departField.text          = [[_selDic objectForKey:@"Department"] description];
    _lonField.text             = [[_selDic objectForKey:@"Longitude"] description];
    _latField.text             = [[_selDic objectForKey:@"Latitude"] description];
    _dateLabel.text            = [NSString stringWithFormat:@"%@ %@",
                                  [[_selDic objectForKey:@"Date"] description],
                                  [[_selDic objectForKey:@"Time"] description]];
    _addressField.text         = [[_selDic objectForKey:@"Address"] description];
    _detailField.text          = [[_selDic objectForKey:@"Description"] description];
    if ([[_selDic objectForKey:@"SaveType"] intValue] == 0) {
        _navItem.rightBarButtonItem = nil;
    }
    [self.media initRe];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void) keyboardDidShow:(NSNotification *)notification{
    NSDictionary *info          = [notification userInfo];
    CGRect keyboardFrame        = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect statusBarFrame       = [[UIApplication sharedApplication]statusBarFrame];
    
    _statusBarHeight            = statusBarFrame.size.height;
    _keyboardY                  = keyboardFrame.origin.y-100;
    
    if (_currentTextField!=nil) {
        float textFieldTop      = _currentTextField.frame.origin.y;
        float textFieldBottom   = textFieldTop + _currentTextField.frame.size.height;
        
        if (textFieldBottom > _keyboardY) {
            [(UIScrollView *)_srollView setContentOffset:CGPointMake(0, textFieldBottom - _keyboardY + _statusBarHeight)animated:YES];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField{
    _currentTextField           = textField;
    float textFieldTop          = _currentTextField.frame.origin.y;
    float textFieldBottom       = textFieldTop + _currentTextField.frame.size.height;
    
    if ((textFieldBottom > _keyboardY)&&(_keyboardY != 0.0)) {
        [_srollView setContentOffset:CGPointMake(0, textFieldBottom - _keyboardY + _statusBarHeight)animated:YES];
    }
}


-(void)keyboardDidHide:(NSNotification *)notification{
    //如果doneInKeyboardButton按钮出现在屏幕上，将其从视图中移除
    
    [(UIScrollView *)_srollView setContentOffset:CGPointMake(0, 0)animated:YES];
}

-(void)macinfoSoapDidReturn:(MacinfoSoap *) p_soap{
    //友好界面隐藏
    [_configData performBlock:^{
        [_progressView close];
        [_configData performBlock:^{
            if (p_soap.success) {
                 [self saveData:@"0"];
            }else{
                 [self saveData:@"2"];
            }
            [_configData showAlert:p_soap.msg];
        } afterDelay:1.0];
    } afterDelay:1.0];
}

- (IBAction)returnToList:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"是否保存吗？" delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"确定",nil];
    [alert show];
    
    
}

//确定保存
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        [self saveData:@"1"];
    }else{
        [_delegate MacFormViewControllerReturn:self Save:NO];
    }
}

-(void)saveData:(NSString *)p_saveType{
    _macInfoData = [MacinfoData initDb:[_configData getMyDb]];
    [_macInfoData InsertData:_infoId
                            Name:[[_userDic objectForKey:@"Name"] description]
                          UserId:[[_userDic objectForKey:@"Userid"] description]
                      Department:_departField.text
                       Longitude:_lonField.text
                        Latitude:_latField.text
                         Address:_addressField.text
                     Description:_detailField.text
                            Date:[[_dateLabel.text componentsSeparatedByString:@" "] objectAtIndex:0]
                            Time:[[_dateLabel.text componentsSeparatedByString:@" "] objectAtIndex:1]
                        SaveType:p_saveType];
    if (_macInfoData.success) {
        [_delegate MacFormViewControllerReturn:self Save:YES];
    }
}

- (IBAction)uploadData:(id)sender{
    //键盘隐藏
    [self textFieldShouldReturn:_detailField];
    //弹出等待友好界面
    _progressView           = [_configData getAlert:@"上传中..."];
    [_progressView show];
    //访问后台服务
    _macInfoSoap            = [[MacinfoSoap alloc]init];
    _macInfoSoap.delegate   = self;
    
    _macInfoSoap.strInfoId = _media.infoId;
    _macInfoSoap.strMoudleType = _media.modelType;
    _macInfoSoap.photoArr = _media.photoArr;
    _macInfoSoap.videoArr = _media.videoArr;
    _macInfoSoap.strEarthId = @"";
    
    [_macInfoSoap uploadDataMac:self.infoId
                           Name:[[self.userDic objectForKey:@"Name"] description]
                         UserId:[[self.userDic objectForKey:@"Userid"] description]
                     Department:self.departField.text
                      Longitude:self.lonField.text
                       Latitude:self.latField.text
                        Address:self.addressField.text
                    Description:self.detailField.text
                           Date:[[self.dateLabel.text componentsSeparatedByString:@" "] objectAtIndex:0]
                           Time:[[self.dateLabel.text componentsSeparatedByString:@" "] objectAtIndex:1]];
}
@end
