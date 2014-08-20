//
//  PreFormViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-20.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "PreFormViewController.h"

@interface PreFormViewController ()

@end

@implementation PreFormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    _scrollView.contentSize                     = CGSizeMake(305, 680);
    _eqimId.text                                = [[_cataLogDic objectForKey:@"Id"] description];
    _eqimLonLat.text                            = [NSString stringWithFormat:@"(%@,%@)",
                                                   [NSString stringWithFormat:@"%.3f", [[_cataLogDic objectForKey:@"EpiLon"] doubleValue]],
                                                   [NSString stringWithFormat:@"%.3f",[[_cataLogDic objectForKey:@"EpiLat"] doubleValue]]];
    _eqimM.text                                 = [[_cataLogDic objectForKey:@"M"] description];
    _eqimLocName.text                           = [[_cataLogDic objectForKey:@"LocationName"] description];
    _eqimOTime.text                             = [[_cataLogDic objectForKey:@"OTime"] description];
    
    _configData                                 = [[NSConfigData alloc]init];
    _userDic                                    = [_configData getUserDic];
    _proName.text                               = [[_userDic objectForKey:@"Name"] description];
    
    NSDateFormatter* formatter                  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    _infoId =[formatter stringFromDate:[NSDate date]];
    [formatter setDateFormat:@"YYYY年MM月dd日 HH时mm分"];
    AGSPoint *locationP                         = (AGSPoint *)self.locationGP.geometry;
    
    _proAddress.text                            = [_configData getLocationAddress:locationP.x Lat:locationP.y];
    _proDate.text                               = [formatter stringFromDate:[NSDate date]];
    _proLat.text                                = [NSString stringWithFormat:@"%.3f", locationP.y];
    _proLat.delegate                            = self;
    _proLon.text                                = [NSString stringWithFormat:@"%.3f", locationP.x];
    _proLon.delegate                            = self;
    _proAddress.delegate                        = self;
    _proDetails.delegate                        = self;
    _proSimDescribe.titleLabel.lineBreakMode    = UILineBreakModeWordWrap;
    

    self.media               = [[MediaView alloc] initWithFrame:self.mediaView.frame];
    self.media.supViewCon = self;
    self.media.modelType = @"PROFESSION";
    self.media.infoId = _infoId;
    [self.mediaView addSubview:self.media];
    
    if (_selDic!=nil) {
        [self initRe];
    }
}

-(void)initRe{
    _infoId = [[_selDic objectForKey:@"InfoId"]description];
    self.media.infoId = _infoId;
    NSLog(@"%@",_infoId);
    _proName.text  = [[_selDic objectForKey:@"Name"]description];
    _proLon.text = [[_selDic objectForKey:@"Longitude"]description];
    _proLat.text = [[_selDic objectForKey:@"Latitude"]description];

    [_proSimDescribe setTitle:[[_selDic objectForKey:@"SDescription"]description] forState:UIControlStateNormal];
    [_proIntensity setTitle:[[_selDic objectForKey:@"SIntensity"]description] forState:UIControlStateNormal];
    _proDate.text = [NSString stringWithFormat:@"%@ %@",
                     [[_selDic objectForKey:@"Date"] description],
                     [[_selDic objectForKey:@"Time"] description]];
    
    _proAddress.text = [[_selDic objectForKey:@"Address"]description];
    _proDetails.text = [[_selDic objectForKey:@"PDescription"]description];
    
    if ([[[_selDic objectForKey:@"PIntensity"]description] isEqualToString:@"无"]) {
        [_radioButton setSelectedWithTag:0];
    }else if([[[_selDic objectForKey:@"PIntensity"]description] isEqualToString:@"+"]){
        [_radioButton setSelectedWithTag:1];
    }else if([[[_selDic objectForKey:@"PIntensity"]description] isEqualToString:@"-"]){
        [_radioButton setSelectedWithTag:-1];
    }
    
    if ([[_selDic objectForKey:@"SaveType"] intValue] == 0) {
        _navItem.rightBarButtonItem = nil;
    }
    
    [self.media initRe];
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
            [(UIScrollView *)_scrollView setContentOffset:CGPointMake(0, textFieldBottom - _keyboardY + _statusBarHeight)animated:YES];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField{
    _currentTextField       = textField;
    float textFieldTop      = _currentTextField.frame.origin.y;
    float textFieldBottom   = textFieldTop + _currentTextField.frame.size.height;
    
    if ((textFieldBottom > self.keyboardY) && (self.keyboardY != 0.0)) {
        [_scrollView setContentOffset:CGPointMake(0, textFieldBottom-_keyboardY + _statusBarHeight)animated:YES];
    }
}


-(void)keyboardDidHide:(NSNotification *)notification{
    [(UIScrollView *)_scrollView setContentOffset:CGPointMake(0, 0)animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)didCloseModalPanel:(UAModalPanel *)modalPanel {
    
    if (_simDescribePanel != nil) {
        if (_simDescribePanel.selectIndex != nil) {
            [_proSimDescribe setTitleColor:[UIColor colorWithWhite:0.0 alpha:1.0] forState:UIControlStateNormal];
            [_proSimDescribe setTitle:_simDescribePanel.selectIndex forState:UIControlStateNormal];
            _simDescribePanel = nil;
        }
    }else if (_pubIntensityPanel != nil ) {
        if (_pubIntensityPanel.selectIndex != nil) {
            [_proIntensity setTitleColor:[UIColor colorWithWhite:0.0 alpha:1.0] forState:UIControlStateNormal];
            [_proIntensity setTitle:_pubIntensityPanel.selectIndex forState:UIControlStateNormal];
            _pubIntensityPanel = nil;
        }
    }
	
}

- (IBAction)returnToProList:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示信息"
                                                   message:@"是否保存吗？"
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"确定",nil];
    [alert show];
    
}
//确定保存
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        [self saveData:@"1"];
    }else{
        [_delegate PreFormViewControllerReturn:self Save:NO];
    }
}

-(void)saveData:(NSString *)p_saveType{
    _preinfoData = [PreinfoData initDb:[_configData getMyDb]];
    [_preinfoData InsertData:_infoId
                         EarthId:_eqimId.text
                            Name:[[_userDic objectForKey:@"Name"] description]
                          UserId:[[_userDic objectForKey:@"Userid"] description]
                       Longitude:_proLon.text
                        Latitude:_proLat.text
                         Address:_proAddress.text
                      SIntensity:_proIntensity.titleLabel.text
                      PIntensity:_radioButton.selectedButton.titleLabel.text
                    SDescription:_proSimDescribe.titleLabel.text
                    PDescription:_proDetails.text
                            Date:[[_proDate.text componentsSeparatedByString:@" "] objectAtIndex:0]
                            Time:[[_proDate.text componentsSeparatedByString:@" "] objectAtIndex:1]
                        SaveType:p_saveType];
    if (_preinfoData.success) {
        [_delegate PreFormViewControllerReturn:self Save:YES];
    }

}

- (IBAction)showDescribe:(id)sender {
    _simDescribePanel               = [[SimDescribePanel alloc]initWithFrame:self.view.bounds title:@"简要描述"];
    _simDescribePanel.delegate      = self;
	[self.view addSubview:_simDescribePanel];
	[_simDescribePanel show];
    
}

- (IBAction)showIntensity:(id)sender {
    _pubIntensityPanel              = [[PubIntensityPanel alloc]initWithFrame:self.view.bounds title:@"烈度列表"];
    _pubIntensityPanel.delegate     = self;
	[self.view addSubview:self.pubIntensityPanel];
	[_pubIntensityPanel show];
}

-(void)preInfoSoapDidReturn:(PreInfoSoap *) p_soap{
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

- (IBAction)uploadData:(id)sender{
    //键盘隐藏
    [self textFieldShouldReturn:_proDetails];
    //弹出等待友好界面
    _progressView = [_configData getAlert:@"上传中..."];

    [_progressView show];
    //访问后台服务
    _preinfoSoap = [[PreInfoSoap alloc]init];
    _preinfoSoap.delegate = self;
    
    _preinfoSoap.strInfoId = _media.infoId;
    _preinfoSoap.strMoudleType = _media.modelType;
    _preinfoSoap.photoArr = _media.photoArr;
    _preinfoSoap.videoArr = _media.videoArr;
    _preinfoSoap.strEarthId = _eqimId.text;
    
    [_preinfoSoap uploadDataPre:_infoId
                        EarthId:_eqimId.text
                           Name:[[_userDic objectForKey:@"Name"] description]
                         UserId:[[_userDic objectForKey:@"Userid"] description]
                      Longitude:_proLon.text
                       Latitude:_proLat.text
                        Address:_proAddress.text
                     SIntensity:_proIntensity.titleLabel.text
                     PIntensity:_radioButton.titleLabel.text
                   SDescription:_proSimDescribe.titleLabel.text
                   PDescription:_proDetails.text
                           Date:[[_proDate.text componentsSeparatedByString:@" "] objectAtIndex:0]
                           Time:[[_proDate.text componentsSeparatedByString:@" "] objectAtIndex:1]];
}
@end
