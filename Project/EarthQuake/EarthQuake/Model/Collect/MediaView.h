//
//  MediaView.h
//  EarthQuake
//
//  Created by 于华 on 14-8-6.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyTableView.h"
#include <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "NSConfigData.h"
#import "SJAvatarBrowser.h"

@interface MediaView : UIView<UIGestureRecognizerDelegate>

@property (strong,nonatomic) EasyTableView *easyPhoto;
@property (strong,nonatomic) EasyTableView *easyVideo;
@property (strong,nonatomic) UIViewController *supViewCon;
@property (strong,nonatomic) NSString *modelType;
@property (strong,nonatomic) NSString *infoId;
@property (strong,nonatomic) NSString *fileType;
@property (strong,nonatomic) NSConfigData *configData;
@property (strong,nonatomic) NSMutableArray *photoArr;
@property (strong,nonatomic) NSMutableArray *videoArr;
@property (nonatomic, strong) UIActionSheet *alertSheet;
@property (strong,nonatomic) EasyTableView *selEasy;
@property (strong,nonatomic) NSIndexPath *selIndex;
@property (strong,nonatomic) UILongPressGestureRecognizer *photoLongPress;
@property (strong,nonatomic) UILongPressGestureRecognizer *videoLongPress;
-(void)initRe;

@property (weak, nonatomic) IBOutlet UIButton *btnPhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnVideo;
@property (weak, nonatomic) IBOutlet UIView *viewPhoto;
@property (weak, nonatomic) IBOutlet UIView *viewVideo;
- (IBAction)actPhoto:(id)sender;
- (IBAction)actVideo:(id)sender;

@end
