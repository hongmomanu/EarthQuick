//
//  Media.h
//  EarthQuake
//
//  Created by 于华 on 14-8-5.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@interface Media : UIView<UIImagePickerControllerDelegate>{
    BOOL isFullScreen;
    NSString *imagejudge;
    int chang;
}
@property NSData  *Webphotoleft;
@property NSData  *Webphotoamong;
@property NSData  *Webphotoright;
@property UIViewController *supViewCon;

@property (weak, nonatomic) IBOutlet UIButton *photobtn;
@property (weak,nonatomic) IBOutlet UIScrollView *videscrollview;
@property (weak, nonatomic)IBOutlet UIScrollView *photoscroll;
@property (weak, nonatomic)IBOutlet UIButton *videobtn;
@property (weak, nonatomic) IBOutlet UIButton *leftpic;
@property (weak, nonatomic) IBOutlet UIButton *amongpic;
@property (weak, nonatomic) IBOutlet UIButton *rigthpic;

- (IBAction)photoaction:(id)sender;
- (IBAction)videoget:(id)sender;
- (IBAction)leftpicture:(id)sender;
- (IBAction)amongpicture:(id)sender;
- (IBAction)rightpicture:(id)sender;
@end
