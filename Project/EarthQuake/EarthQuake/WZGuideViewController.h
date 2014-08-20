//
//  WZGuideViewController.h
//  WZGuideViewController
//
//  Created by Wei on 13-3-11.
//  Copyright (c) 2013年 ZhuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZGuideViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, copy) void (^startBlock)(BOOL shared);
@end
