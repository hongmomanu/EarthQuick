//
//  Media.m
//  EarthQuake
//
//  Created by 于华 on 14-8-5.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "Media.h"
#define BIG_IMG_WIDTH  200.0
#define BIG_IMG_HEIGHT 200.0

@implementation Media{
   
    UIView *background;
    NSString *imageData;
    NSString *voideData;
    UIImageView *photoarray;
    UIImage *image;
    NSString *dataleft;
    NSString *dataamong;
    NSString *dataright;
    NSString *dataleftPath;
    NSString *dataamongPath;
    NSString *datarightPath;
    BOOL left;
    BOOL among;
    BOOL right;
    BOOL leftmsg;
    BOOL amongmsg;
    BOOL rightmsg;
    BOOL leftview;
    BOOL amongView;
    BOOL rigthview;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"Media" owner:self options: nil];
    if(arrayOfViews.count < 1)
    {
        self =  nil;
    }else{
        self = [arrayOfViews objectAtIndex:0];
        self = [super initWithFrame:frame];
        CGRect r1 = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.frame = r1;
        
        self.photoscroll.contentSize = CGSizeMake(320,110);
        self.videscrollview.contentSize =CGSizeMake(320,110);
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"类型:%@",mediaType);
    NSString *DataType = [mediaType substringFromIndex:7];
    NSLog(@"格式:%@",DataType);
    
    
    if ([DataType isEqualToString:@"image"])
    {
        
        if (left==NO&&among==NO&&right==NO)
        {
            //获取当前时间，精确到分钟，并使用时间给照片命名
            NSString* date;
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter  setDateFormat:@"YYYYMMddhhmmss"];
            date = [formatter stringFromDate:[NSDate date]];
            //将图片名称拼接成拍摄时间
            dataleft= [NSString  stringWithFormat:@"%@.png",date ];
            NSLog(@"%@",imageData);
            dataleftPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            dataleftPath  = [dataleftPath stringByAppendingString:@"/"];
            dataleftPath  = [dataleftPath stringByAppendingString:dataleft];
            NSLog(@"%@",dataleftPath);
            [picker dismissViewControllerAnimated:YES completion:^{}];
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
            photoarray.image = image;
            //将拍摄的图片保存的沙盒
            [self saveImage:image withName:dataleft];
            self.Webphotoleft = UIImageJPEGRepresentation(image, 1);
            //加入点击图片
            [self.leftpic setBackgroundImage:image forState:UIControlStateNormal];
            imagejudge = dataleft;
            left =YES;
            leftview=YES;
            
            
        }
        else if (left==YES&&among==NO&&right==NO)
        {
            //获取当前时间，精确到分钟，并使用时间给照片命名
            NSString* date;
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter  setDateFormat:@"YYYY-MM-dd-hh:mm:ss"];
            date = [formatter stringFromDate:[NSDate date]];
            //将图片名称拼接成拍摄时间
            dataamong= [NSString  stringWithFormat:@"%@.png",date ];
            NSLog(@"%@",imageData);
            dataamongPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            dataamongPath  = [dataamongPath stringByAppendingString:@"/"];
            dataamongPath  = [dataamongPath stringByAppendingString:dataamong];
            NSLog(@"%@",dataamongPath);
            [picker dismissViewControllerAnimated:YES completion:^{}];
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
            photoarray.image = image;
            //将拍摄的图片保存的沙盒
            [self saveImage:image withName:dataamong];
            //加入点击图片
            [self.amongpic setBackgroundImage:image forState:UIControlStateNormal];
            imagejudge = dataamong;
            NSLog(@"第2个");
            self.Webphotoamong = UIImageJPEGRepresentation(image, 1);
            among =YES;
            amongView=YES;
        }
        else if(left==YES&&among==YES&&right==NO)
        {
            //获取当前时间，精确到分钟，并使用时间给照片命名
            NSString* date;
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter  setDateFormat:@"YYYY-MM-dd-hh:mm:ss"];
            date = [formatter stringFromDate:[NSDate date]];
            //将图片名称拼接成拍摄时间
            dataright= [NSString  stringWithFormat:@"%@.png",date ];
            NSLog(@"%@",imageData);
            datarightPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            datarightPath  = [datarightPath stringByAppendingString:@"/"];
            datarightPath  = [datarightPath stringByAppendingString:dataright];
            NSLog(@"%@",datarightPath);
            [picker dismissViewControllerAnimated:YES completion:^{}];
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
            photoarray.image = image;
            //将拍摄的图片保存的沙盒
            [self saveImage:image withName:dataright];
            //加入点击图片
            [self.rigthpic setBackgroundImage:image forState:UIControlStateNormal];
            imagejudge = dataright;
            //将照片转换成NSDATA
            self.Webphotoright = UIImageJPEGRepresentation(image, 1);
            NSLog(@"第2个");
            right =YES;
            leftview=YES;
        }
        
    }
    else
    {
        
        
        NSURL *mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter  setDateFormat:@"YYYY-MM-dd-hh:mm:ss"];
        NSString *date = [formatter stringFromDate:[NSDate date]];
        NSString *DataMOV = [date stringByAppendingString:@".mov"];
        NSString *videoFile = [documentsDirectory stringByAppendingPathComponent:DataMOV];
        [videoData writeToFile:videoFile atomically:YES];
        //获取视频缩略图
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoFile] options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
        UIButton *leftvideoBTN = [[UIButton alloc]initWithFrame:CGRectMake(19, 600, 180 ,150)];
        [leftvideoBTN setBackgroundImage:thumb forState:UIControlStateNormal];
        //[self.scrollView addSubview:leftvideoBTN];
        [self.videscrollview addSubview:leftvideoBTN];
        
        ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc]init];
        [assetLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL
                                         completionBlock:^(NSURL *assetURL, NSError *error)
         {
             if (!error)
             {
                 NSLog(@"视频保存成功");
             }
             else
             {
                 NSLog(@"保存视频出现错误：%@",error);
             }
         }];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
    isFullScreen = NO;
}

#pragma mark - 保存视频至沙盒
- (void) savevideo:(NSData *)currentvideo withName:(NSString *)videoName
{
//    NSData *videoData = [[NSData alloc]init];
//    videoData = currentvideo;
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:videoName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
    
}
#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

/**
 *拍照
 */
- (IBAction)photoaction:(id)sender
{
    //检查相机是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *tPhoto = [[UIImagePickerController alloc] init];
        tPhoto.delegate = self;
        tPhoto.allowsEditing = NO;
        tPhoto.sourceType = UIImagePickerControllerSourceTypeCamera;
        //将拍摄的分辨率设置到最低
        tPhoto.videoQuality = UIImagePickerControllerQualityTypeLow;
        [self.supViewCon presentViewController:tPhoto animated:YES completion:nil];
    }
    else
    {
        NSLog(@"这个是没有拿到相机的情况");
    }
    
    
    
}
/**
 *摄像
 */
- (IBAction)videoget:(id)sender
{
    //检查相机模式是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *tVideo = [[UIImagePickerController alloc] init];
        tVideo.delegate = self;
        //设置图像选取控制器的来源模式为相机模式
        tVideo.sourceType = UIImagePickerControllerSourceTypeCamera;
        //设置图像选取控制器的类型为动态图像
        tVideo.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        //设置视频来源是摄像机
        tVideo.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        tVideo.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        //设置拍摄质量
        tVideo.videoQuality = UIImagePickerControllerQualityTypeMedium;
        
        [self.supViewCon presentViewController:tVideo animated:YES completion:nil];
        
    }
    else
    {
        NSLog(@"这个是没有拿到相机的情况");
    }
    
}

//图片放大所执行的方法
- (IBAction)leftpicture:(id)sender{
    if (leftview==YES) {
        
        //创建灰色透明背景，使其背后内容不可操作
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 648)];
        background = bgView;
        [bgView setBackgroundColor:[UIColor colorWithRed:0.3
                                                   green:0.3
                                                    blue:0.3
                                                   alpha:0.7]];
        [self.supViewCon.view addSubview:bgView];
        //创建边框视图
        UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,BIG_IMG_WIDTH+50, BIG_IMG_HEIGHT+50)];
        //将图层的边框设置为圆脚
        borderView.layer.cornerRadius = 8;
        borderView.layer.masksToBounds = YES;
        //给图层添加一个有色边框
        borderView.layer.borderWidth = 8;
        borderView.layer.borderColor = [[UIColor colorWithRed:0.9
                                                        green:0.9
                                                         blue:0.9
                                                        alpha:0.7]CGColor];
        [borderView setCenter:bgView.center];
        [bgView addSubview:borderView];
        //创建关闭按钮
        leftmsg = YES;
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"removebtn.png"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(lessenleft) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setFrame:CGRectMake(borderView.frame.origin.x+borderView.frame.size.width-20, borderView.frame.origin.y-6, 26, 27)];
        [bgView addSubview:closeBtn];
        //创建显示图像视图
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, BIG_IMG_WIDTH+50,BIG_IMG_HEIGHT+50)];
        imgView.image =self.leftpic.currentBackgroundImage;
        [borderView addSubview:imgView];
        leftview=NO;
        
    }
    
}
- (IBAction)amongpicture:(id)sender
{
    if (amongView==YES)
    {
        //创建灰色透明背景，使其背后内容不可操作
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,648)];
        background = bgView;
        [bgView setBackgroundColor:[UIColor colorWithRed:0.3
                                                   green:0.3
                                                    blue:0.3
                                                   alpha:0.7]];
        [self.supViewCon.view addSubview:bgView];
        //创建边框视图
        UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,BIG_IMG_WIDTH+50, BIG_IMG_HEIGHT+50)];
        //将图层的边框设置为圆脚
        borderView.layer.cornerRadius = 8;
        borderView.layer.masksToBounds = YES;
        //给图层添加一个有色边框
        borderView.layer.borderWidth = 8;
        borderView.layer.borderColor = [[UIColor colorWithRed:0.9
                                                        green:0.9
                                                         blue:0.9
                                                        alpha:0.7]CGColor];
        [borderView setCenter:bgView.center];
        [bgView addSubview:borderView];
        //创建关闭按钮
        amongmsg = YES;
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"removebtn.png"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(lessenamong) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setFrame:CGRectMake(borderView.frame.origin.x+borderView.frame.size.width-20, borderView.frame.origin.y-6, 26, 27)];
        [bgView addSubview:closeBtn];
        //创建显示图像视图
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, BIG_IMG_WIDTH+50,BIG_IMG_HEIGHT+50)];
        imgView.image =self.amongpic.currentBackgroundImage;
        [borderView addSubview:imgView];
        amongView = NO;
    }
}
- (IBAction)rightpicture:(id)sender
{
    if (rigthview==YES){
        //创建灰色透明背景，使其背后内容不可操作
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 648)];
        background = bgView;
        [bgView setBackgroundColor:[UIColor colorWithRed:0.3
                                                   green:0.3
                                                    blue:0.3
                                                   alpha:0.7]];
        [self.supViewCon.view addSubview:bgView];
        //创建边框视图
        UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,BIG_IMG_WIDTH+50, BIG_IMG_HEIGHT+50)];
        //将图层的边框设置为圆脚
        borderView.layer.cornerRadius = 8;
        borderView.layer.masksToBounds = YES;
        //给图层添加一个有色边框
        borderView.layer.borderWidth = 8;
        borderView.layer.borderColor = [[UIColor colorWithRed:0.9
                                                        green:0.9
                                                         blue:0.9
                                                        alpha:0.7]CGColor];
        [borderView setCenter:bgView.center];
        [bgView addSubview:borderView];
        //创建关闭按钮
        rightmsg =YES;
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"removebtn.png"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(lessenrigth) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setFrame:CGRectMake(borderView.frame.origin.x+borderView.frame.size.width-20, borderView.frame.origin.y-6, 26, 27)];
        [bgView addSubview:closeBtn];
        //创建显示图像视图
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, BIG_IMG_WIDTH+50,BIG_IMG_HEIGHT+50)];
        imgView.image =self.rigthpic.currentBackgroundImage;
        [borderView addSubview:imgView];
        rigthview=NO;
    }
    
}


-(void)leftvoideBtn
{
    NSLog(@"按钮效果");
}
+(UIImage *)getImage:(NSString *)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(5, 15);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
    
}


-(void)lessenrigth
{
    UIAlertView *picmsg =[[UIAlertView alloc]initWithTitle:@"当前图片操作" message:@"点击消息" delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"保存", nil];
    [picmsg show];
    [background removeFromSuperview];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:datarightPath error:nil];
}
-(void)lessenleft
{
    UIAlertView *picmsg =[[UIAlertView alloc]initWithTitle:@"当前图片操作" message:@"点击消息" delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"保存", nil];
    [picmsg show];
    [background removeFromSuperview];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:dataleftPath error:nil];
    NSLog(@"%@",dataleftPath);
}
-(void)lessenamong
{
    UIAlertView *picmsg =[[UIAlertView alloc]initWithTitle:@"当前图片操作" message:@"点击消息" delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"保存", nil];
    [picmsg show];
    [background removeFromSuperview];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:dataamongPath error:nil];
}


//选择事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        if (leftmsg == YES)
        {
            NSLog(@"右边的");
            UIImage *backpic =[UIImage imageNamed:@"backpic"];
            [self.leftpic setBackgroundImage:backpic forState:UIControlStateNormal];
            left = NO;
            leftmsg=NO;
            right = NO;
            among = NO;
            
        }
        else if (rightmsg==NO&&amongmsg==YES)
        {
            NSLog(@"右边的1");
            UIImage *backpic =[UIImage imageNamed:@"backpic"];
            [self.amongpic setBackgroundImage:backpic forState:UIControlStateNormal];
            among = NO;
            amongmsg=NO;
            left=YES;
            right=NO;
        }
        else if(rightmsg==YES)
        {
            UIImage *backpic =[UIImage imageNamed:@"backpic"];
            [self.rigthpic setBackgroundImage:backpic forState:UIControlStateNormal];
            
            rightmsg =NO;
            left=YES;
            among=YES;
            right=NO;
            NSLog(@"右边的12");
        }
    }
    else
    {
        NSLog(@"这又是是什么？");
        
    }
}

-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan)
    {
        if (rightmsg == YES)
        {
            NSLog(@"右边的");
            self.rigthpic.backgroundColor = [UIColor whiteColor];
            
            
        }
        else if (rightmsg==NO&&amongmsg ==YES)
        {
            NSLog(@"右边的1");
        }
        else if(rightmsg==YES)
        {
            NSLog(@"右边的12");
        }
    }
}

@end
