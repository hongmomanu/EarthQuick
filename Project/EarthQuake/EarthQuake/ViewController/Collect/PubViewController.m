//
//  PubViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-13.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "PubViewController.h"
#define BIG_IMG_WIDTH  200.0
#define BIG_IMG_HEIGHT 200.0

@interface PubViewController ()

@end

@implementation PubViewController

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
    
    _scrollView.contentSize                     = CGSizeMake(305, 580);
    _locationP                                  = (AGSPoint *)self.locationGP.geometry;
    _locationLab.text                           = [NSString stringWithFormat:@"(%@,%@)",
                                                       [NSString stringWithFormat:@"%.3f", self.locationP.x],
                                                       [NSString stringWithFormat:@"%.3f", self.locationP.y]];
    _simDescribeLable.titleLabel.lineBreakMode  = UILineBreakModeWordWrap;
    _configData                                 = [[NSConfigData alloc]init];
    _addressLab.text                            = [_configData getLocationAddress:_locationP.x Lat:_locationP.y];
    NSDateFormatter* formatter                  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    _infoId                                     = [formatter stringFromDate:[NSDate date]];
    [formatter setDateFormat:@"YYYY年MM月dd日 HH时mm分"];
    _dateLabel.text                             = [formatter stringFromDate:[NSDate date]];
    _detailsField.delegate                      = self;
    _phoneField.delegate                        = self;
    
    
    self.media               = [[MediaView alloc] initWithFrame:self.mediaView.frame];
    self.media.supViewCon = self;
    self.media.modelType = @"PUBLIC";
    self.media.infoId = _infoId;
    [self.mediaView addSubview:self.media];

}

-(void) viewWillAppear:(BOOL)animated
{
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
-(void) keyboardDidShow:(NSNotification *)notification
{
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
}
/*!
 @method
 @abstract 返回地图界面
 @result 空值
 */
- (IBAction)returnToMap:(id)sender {
    [_delegate PubViewControllerReturn:self];
    NSString *extension = @"png";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        if ([[filename pathExtension] isEqualToString:extension]) {
            
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
        }
    }

}

/*!
 @method
 @abstract 页面间传递
 @result 空值
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]  isEqualToString:@"pubToweb"]){
        _webViewController          = [segue destinationViewController];
        _webViewController.delegate =self;
        
    }
}
/*!
 @method
 @abstract 后台数据返回协议
 @result 空值
 */
- (IBAction)showPanel:(id)sender
{
    _simDescribePanel               = [[SimDescribePanel alloc]initWithFrame:self.view.bounds
                                                                           title:@"简要描述"];
    _simDescribePanel.delegate      = self;
	[self.view addSubview:_simDescribePanel];
	[_simDescribePanel show];
    
}
/*!
 @method
 @abstract 弹出框选着列表关闭
 @result 空值
 */
- (void)didCloseModalPanel:(UAModalPanel *)modalPanel {
    
    if (_simDescribePanel != nil) {
        if (_simDescribePanel.selectIndex != nil)
        {
            //简要描述赋值
            [_simDescribeLable setTitleColor:[UIColor colorWithWhite:0.0 alpha:1.0]
                                        forState:UIControlStateNormal];
            [_simDescribeLable setTitle:_simDescribePanel.selectIndex
                                   forState:UIControlStateNormal];
            _simDescribePanel = nil;
        }
        
    }else if (_pubIntensityPanel != nil )
    {
        //简要烈度赋值
        if (_pubIntensityPanel.selectIndex != nil)
        {
            [_pubIntensityLable setTitleColor:[UIColor colorWithWhite:0.0 alpha:1.0]
                                         forState:UIControlStateNormal];
            [_pubIntensityLable setTitle:_pubIntensityPanel.selectIndex
                                    forState:UIControlStateNormal];
            _pubIntensityPanel = nil;
        }
    }
	
}
/*!
 @method
 @abstract 后台数据返回协议
 @result 空值
 */
-(void)pubInfoSoapDidReturn:(PubInfoSoap *) p_soap
{
    //友好界面隐藏
    [_configData performBlock:^{
        [_progressView close];
        [_configData performBlock:^{
            [_configData showAlert:p_soap.msg];
            [_delegate PubViewControllerReturn:self];
        } afterDelay:1.0];
    } afterDelay:1.0];
    
}
/*!
 @method
 @abstract 烈度列表界面返回协议
 @result 空值
 */
-(void)WebViewControllerReturn:(WebViewController *)controller {
        [self dismissViewControllerAnimated:YES completion:NULL];
};
/*!
 @method
 @abstract 跳转到烈度列表界面
 @result 空值
 */
- (IBAction)pubToList:(id)sender {
     [self performSegueWithIdentifier:@"pubToweb" sender:nil];
}
/*!
 @method
 @abstract 弹出简要烈度选择
 @result 空值
 */
- (IBAction)showIntensity:(id)sender
{
    //弹出烈度选着列表
    _pubIntensityPanel                  = [[PubIntensityPanel alloc]initWithFrame:self.view.bounds
                                                                            title:@"烈度列表"];
    _pubIntensityPanel.delegate         = self;
	[self.view addSubview:_pubIntensityPanel];
	[_pubIntensityPanel show];
}
/*!
 @method
 @abstract 公众采集上传
 @result 空值
 */
- (IBAction)uploadData:(id)sender
{
    //键盘隐藏
    [self textFieldShouldReturn:_detailsField];
    //弹出等待友好界面
    _progressView = [_configData getAlert:@"上传中..."];
    [_progressView show];
    //访问后台服务
    _pubInfoSoap = [[PubInfoSoap alloc]init];
    _pubInfoSoap.delegate = self;
    _pubInfoSoap.strInfoId = _media.infoId;
    _pubInfoSoap.strMoudleType = _media.modelType;
    _pubInfoSoap.photoArr = _media.photoArr;
    _pubInfoSoap.videoArr = _media.videoArr;
    _pubInfoSoap.strEarthId = @"";
    
    [_pubInfoSoap uploadDataPub:_infoId
                               Name:_phoneField.text
                          Longitude:[NSString stringWithFormat:@"%.3f", _locationP.x]
                           Latitude:[NSString stringWithFormat:@"%.3f", _locationP.y]
                            Address:_addressLab.text
                         SIntensity:_pubIntensityLable.titleLabel.text
                         PIntensity:_radioButton.selectedButton.titleLabel.text
                       SDescription:_simDescribeLable.titleLabel.text
                       PDescription:_detailsField.text
                               Date:[[_dateLabel.text componentsSeparatedByString:@" "] objectAtIndex:0]
                               Time:[[_dateLabel.text componentsSeparatedByString:@" "] objectAtIndex:1]];
   
    
   
    
}

@end
