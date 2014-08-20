//
//  AppDelegate.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-8.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "AppDelegate.h"
#import "WZGuideViewController.h"
#import "ViewController.h"
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    /*
     2.判断是否第一次使用这个版本
     */
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    // 2.1.先去沙盒中取出上次使用的版本号
    NSString *lastVersionCode = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    // 2.2.加载程序中info.plist文件(获得当前软件的版本号)
    NSString *currentVersionCode = [NSBundle mainBundle].infoDictionary[key];
    
    if ([lastVersionCode isEqualToString:currentVersionCode]) {
        // 非第一次使用软件
        
        [UIApplication sharedApplication].statusBarHidden=NO;
        
        
        // 2.3.开始微博(主界面)
        [self startWeibo:NO];
    } else {
        // 第一次使用软件
        // 2.3.保存当前软件版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersionCode forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
         // 2.4.新特性控制器
        WZGuideViewController *new = [[WZGuideViewController alloc] init];
       
        new.startBlock = ^(BOOL shared)
        {
           [self startWeibo:shared];
        };
        self.window.rootViewController = new;
    }
    
    // 3.显示窗口
    
    [self.window makeKeyAndVisible];
    return YES;

    }

- (void)startWeibo:(BOOL)shared
{
    // 1.显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 2.主界面
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // initstance root_Vc
    ViewController *root_Vc = [storyboard instantiateViewControllerWithIdentifier:@"rootView"];
    // set to rootViewController
    [[self window] setRootViewController:root_Vc];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
