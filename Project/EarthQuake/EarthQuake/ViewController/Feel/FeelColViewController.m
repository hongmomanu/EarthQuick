//
//  FeelColViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-6-5.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "FeelColViewController.h"

@interface FeelColViewController ()

@end

@implementation FeelColViewController

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
    _scrollView.contentSize                     = CGSizeMake(305, 500);
    _configData                                 = [[NSConfigData alloc]init];
    _userDic                                    = [_configData getUserDic];
    _nameField.text                             = [[_userDic objectForKey:@"Name"] description];
    
    _locationP                                  = (AGSPoint *)self.locationGP.geometry;
    _latlonLabel.text                           = [NSString stringWithFormat:@"(%@,%@)",
                                                   [NSString stringWithFormat:@"%.3f", self.locationP.x],
                                                   [NSString stringWithFormat:@"%.3f", self.locationP.y]];
    
    NSDateFormatter* formatter                  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    _infoId                                     = [formatter stringFromDate:[NSDate date]];
    
    _partDescribe.delegate = self;
    _nameField.delegate = self;
    _floorNum.delegate=self;
    
    self.media               = [[MediaView alloc] initWithFrame:self.mediaView.frame];
    self.media.supViewCon = self;
    self.media.modelType = @"EQFEEL";
    self.media.infoId = _infoId;
    [self.mediaView addSubview:self.media];
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

-(void)feelUploadSoapDidReturn:(FeelUploadSoap *) p_soap{
    
    
    //友好界面隐藏
    [_configData performBlock:^{
        [_progressView close];
        [_configData performBlock:^{
            [_configData showAlert:p_soap.msg];
           [self returnToMap:Nil];
        } afterDelay:1.0];
    } afterDelay:1.0];
};

- (IBAction)returnToMap:(id)sender {
    [self.delegate feelColViewControllerReturn:self];
}

- (IBAction)describeChange:(id)sender {
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [_describeBut setTitle:selectedValue forState:UIControlStateNormal];
    };
    
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
    };
    
    NSArray *colors = [NSArray arrayWithObjects:@"有感", @"强烈有感", @"房屋破坏", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"人的感觉" rows:colors initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
}

- (IBAction)uploadFeel:(id)sender {
    //键盘隐藏
    [self textFieldShouldReturn:_partDescribe];
    [self textFieldShouldReturn:_floorNum];
    //弹出等待友好界面
    _progressView = [_configData getAlert:@"上传中..."];
    [_progressView show];
    
    self.feelUploadSoap = [[FeelUploadSoap alloc]init];
    self.feelUploadSoap.delegate = self;
    
    _feelUploadSoap.strInfoId = _media.infoId;
    _feelUploadSoap.strMoudleType = _media.modelType;
    _feelUploadSoap.photoArr = _media.photoArr;
    _feelUploadSoap.videoArr = _media.videoArr;
    _feelUploadSoap.strEarthId = @"";
    
    [self.feelUploadSoap uploadDataFeel:_infoId Name:_nameField.text
                              Longitude:[NSString stringWithFormat:@"%.3f", _locationP.x]
                               Latitude:[NSString stringWithFormat:@"%.3f", _locationP.y]
                                Address:_addressField.text
                           SDescription:_describeBut.titleLabel.text
                           PDescription:_partDescribe.text
                               FloorNum:_floorNum.text
                                   Date:[[_dateLabel.text componentsSeparatedByString:@" "] objectAtIndex:0]
                                   Time:[[_dateLabel.text componentsSeparatedByString:@" "] objectAtIndex:1]];
}
@end
