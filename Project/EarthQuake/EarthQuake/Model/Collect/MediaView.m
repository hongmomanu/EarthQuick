//
//  MediaView.m
//  EarthQuake
//
//  Created by 于华 on 14-8-6.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "MediaView.h"

@implementation MediaView

- (instancetype)initWithFrame:(CGRect)frame
{
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"MediaView" owner:self options: nil];
    if(arrayOfViews.count < 1)
    {
        self =  nil;
    }else{
        self = [arrayOfViews objectAtIndex:0];
        self = [super initWithFrame:frame];
        CGRect r1 = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.frame = r1;
        
        self.configData = [[NSConfigData alloc]init];
        
        [self setupEasyPhoto];
        [self setupEasyVideo];
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


- (void)setupEasyPhoto {
    
    self.photoArr = [[NSMutableArray alloc]init];
    self.photoLongPress = [[UILongPressGestureRecognizer alloc]
                           initWithTarget:self
                           action:@selector(myHandleTableviewCellLongPressed:)];
    
    self.photoLongPress.delegate = self;
    self.photoLongPress.minimumPressDuration = 1.0;
   
    CGRect phptoFrameRect	= CGRectMake(0, 0, _viewPhoto.frame.size.width, _viewPhoto.frame.size.height);
    
    _easyPhoto= [[EasyTableView alloc] initWithFrame:phptoFrameRect numberOfColumns:3 ofWidth:100];
    [_easyPhoto.tableView addGestureRecognizer:self.photoLongPress];
    _easyPhoto.delegate						= self;
    _easyPhoto.tableView.allowsSelection	= YES;
    _easyPhoto.tableView.separatorColor		= [UIColor clearColor];
    _easyPhoto.cellBackgroundColor			= [UIColor darkGrayColor];
    _easyPhoto.autoresizingMask				= UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    [_viewPhoto addSubview:_easyPhoto];
}

- (void)setupEasyVideo{
    
     self.videoArr = [[NSMutableArray alloc]init];
    self.videoLongPress = [[UILongPressGestureRecognizer alloc]
                           initWithTarget:self
                           action:@selector(myHandleTableviewCellLongPressed:)];
    
    self.videoLongPress.delegate = self;
    self.videoLongPress.minimumPressDuration = 1.0;
    
    CGRect videoFrameRect	= CGRectMake(0, 0, _viewVideo.frame.size.width, _viewVideo.frame.size.height);

    _easyVideo= [[EasyTableView alloc] initWithFrame:videoFrameRect numberOfColumns:3 ofWidth:100];
    [_easyVideo.tableView addGestureRecognizer:self.videoLongPress];
    _easyVideo.delegate						= self;
    _easyVideo.tableView.allowsSelection	= YES;
    _easyVideo.tableView.separatorColor		= [UIColor clearColor];
    _easyVideo.cellBackgroundColor			= [UIColor darkGrayColor];
    _easyVideo.autoresizingMask				= UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    [_viewVideo addSubview:_easyVideo];
}

-(void)initRe{
   self.photoArr =  [self.configData judgeMediaFile:self.modelType info:self.infoId fileType:@"image"];
    [self.easyPhoto reloadData];
   self.videoArr = [self.configData judgeMediaFile:self.modelType info:self.infoId fileType:@"video"];
    [self.easyVideo reloadData];
}

#pragma mark -
#pragma mark Utility Methods

//- (void)borderIsSelected:(BOOL)selected forView:(UIView *)view {
//    UIImageView *borderView		= (UIImageView *)[view viewWithTag:10];
//    NSString *borderImageName	= (selected) ? @"selected_border.png" : @"image_border.png";
//    borderView.image			= [UIImage imageNamed:borderImageName];
//}


#pragma mark -
#pragma mark EasyTableViewDelegate

// These delegate methods support both example views - first delegate method creates the necessary views

- (UIView *)easyTableView:(EasyTableView *)easyTableView viewForRect:(CGRect)rect {
    CGRect tImageRect		= CGRectMake(5, 5, rect.size.width-10, rect.size.height-10);
    
    UIImageView *tImageView =  [[UIImageView alloc] initWithFrame:tImageRect];
    
    
    return tImageView;
}

// Second delegate populates the views with data from a data source

- (void)easyTableView:(EasyTableView *)easyTableView setDataForView:(UIView *)view forIndexPath:(NSIndexPath *)indexPath {
    UIImageView *tImageView	= (UIImageView *)view;
    
    if (easyTableView == _easyPhoto){
        [tImageView setImage:[UIImage imageWithContentsOfFile:[self.photoArr objectAtIndex:indexPath.row]]];
    }else if(easyTableView == _easyVideo){
        [tImageView setImage:[self getImage:[self.videoArr objectAtIndex:indexPath.row]]];
    }
    
}

// Optional delegate to track the selection of a particular cell

- (void)easyTableView:(EasyTableView *)easyTableView selectedView:(UIView *)selectedView atIndexPath:(NSIndexPath *)indexPath deselectedView:(UIView *)deselectedView {
    

    if (easyTableView == _easyPhoto){
        [SJAvatarBrowser showImage:(UIImageView*)selectedView];
    }else if(easyTableView == _easyVideo){
        [self PlayMovieAction:[self.videoArr objectAtIndex:self.selIndex.row]];
    }


}


//长按事件的手势监听实现方法
- (void) myHandleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {

    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point;
        point = [gestureRecognizer locationInView:self.easyPhoto.tableView];
        
        NSIndexPath * indexPath;
        indexPath = [self.easyPhoto.tableView indexPathForRowAtPoint:point];
        
        if(indexPath == nil){
            point = [gestureRecognizer locationInView:self.easyVideo.tableView];
            indexPath = [self.easyVideo.tableView indexPathForRowAtPoint:point];
            if (indexPath == nil) {
                return;
            }else{
                self.selIndex = indexPath;
                self.selEasy = self.easyVideo;
            }
        }else{
            self.selIndex = indexPath;
            self.selEasy = self.easyPhoto;

        }
        
        self.alertSheet = [[UIActionSheet alloc] initWithTitle:@"附件操作" delegate:self cancelButtonTitle:@"取消"  destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
        
        [self.alertSheet showInView:self.supViewCon.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        

        if (self.selEasy == _easyPhoto){
            [self.configData deleteMediaFile:[self.photoArr objectAtIndex:self.self.selIndex.row]];
            [self.photoArr removeObjectAtIndex:self.selIndex.row];
        }else if(self.selEasy == _easyVideo){
            [self.configData deleteMediaFile:[self.videoArr objectAtIndex:self.self.selIndex.row]];
            [self.videoArr removeObjectAtIndex:self.selIndex.row];
        }
        
        [self.selEasy reloadData];
    }
}



-(void)PlayMovieAction:(NSString *)pVideoPath
{
    NSURL *movieURL = [[NSURL alloc] initFileURLWithPath:pVideoPath];
    MPMoviePlayerViewController *movieTemp = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
    movieTemp.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;//全屏
    [movieTemp.moviePlayer prepareToPlay];
    [self.supViewCon presentMoviePlayerViewControllerAnimated:movieTemp];//切换到视频播放视图
    [movieTemp.moviePlayer play];
}



#pragma mark -
#pragma mark Optional EasyTableView delegate methods for section headers and footers

// Delivers the number of sections in the TableView
- (NSUInteger)numberOfSectionsInEasyTableView:(EasyTableView*)easyTableView{
    return 1;
}

// Delivers the number of cells in each section, this must be implemented if numberOfSectionsInEasyTableView is implemented
-(NSUInteger)numberOfCellsForEasyTableView:(EasyTableView *)easyTableView inSection:(NSInteger)section {
    NSUInteger tCount = 0;
    if (easyTableView == self.easyPhoto) {
        tCount = self.photoArr.count;
    }else if(easyTableView == self.easyVideo){
        tCount = self.videoArr.count;
    }
    
    return tCount;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSString *DataType = [mediaType substringFromIndex:7];
    
    if ([DataType isEqualToString:@"image"])
    {
        //获取当前时间，精确到分钟，并使用时间给照片命名
        NSString* date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter  setDateFormat:@"YYYYMMddhhmmss"];
        date = [formatter stringFromDate:[NSDate date]];
        //将图片名称拼接成拍摄时间
        NSString* tImgName = [NSString  stringWithFormat:@"%@.png",date ];


        NSString* tImgPath = [self.configData getMediaPath:self.modelType info:self.infoId fileType:@"image" fileName:tImgName];
        [self.photoArr addObject:tImgPath];
        
        NSData *tImgData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.5);
        
        NSFileManager *fileManage = [NSFileManager defaultManager];
        
        [fileManage createFileAtPath:tImgPath contents:tImgData attributes:nil];

        [picker dismissViewControllerAnimated:YES completion:nil];
        
        [self.easyPhoto reloadData];
    }
    else
    {

        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter  setDateFormat:@"YYYYMMddhhmmss"];
        NSString *date = [formatter stringFromDate:[NSDate date]];
        NSString *tVideoName = [date stringByAppendingString:@".mov"];
        
        NSURL *tVideoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSData *tVideoData = [NSData dataWithContentsOfURL:tVideoURL];
        
        NSString* tVideoPath = [self.configData getMediaPath:self.modelType info:self.infoId fileType:@"video" fileName:tVideoName];
        [self.videoArr addObject:tVideoPath];
        
//        NSData *tImgData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.5);
        
        NSFileManager *fileManage = [NSFileManager defaultManager];
        
        [fileManage createFileAtPath:tVideoPath contents:tVideoData attributes:nil];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        [self.easyVideo reloadData];
    }

}

-(UIImage *)getImage:(NSString *)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
    
}

- (IBAction)actPhoto:(id)sender {
    //检查相机是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
        photoPicker.delegate = self;
        photoPicker.allowsEditing = NO;
        photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //将拍摄的分辨率设置到最低
        photoPicker.videoQuality = UIImagePickerControllerQualityTypeLow;
        [self.supViewCon presentViewController:photoPicker animated:YES completion:nil];
    }
    else
    {
        NSLog(@"相机调用失败，请重启。");
    }
}

- (IBAction)actVideo:(id)sender {
    //检查相机模式是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *videoPicker = [[UIImagePickerController alloc] init];
        videoPicker.delegate = self;
        //设置图像选取控制器的来源模式为相机模式
        videoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //设置图像选取控制器的类型为动态图像
        videoPicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        //设置视频来源是摄像机
        videoPicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        videoPicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        //设置拍摄质量
        videoPicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
        
        [self.supViewCon presentViewController:videoPicker animated:YES completion:nil];
        
    }
    else
    {
        NSLog(@"相机调用失败，请重启。");
    }
}
@end
