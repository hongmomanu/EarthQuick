//
//  WebViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-14.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WebViewController;
@protocol WebViewControllerDelegate <NSObject>
-(void)WebViewControllerReturn:(WebViewController *)controller ;

@end
@interface WebViewController : UIViewController
@property (weak,nonatomic) id <WebViewControllerDelegate> delegate;

- (IBAction)returnTopub:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
