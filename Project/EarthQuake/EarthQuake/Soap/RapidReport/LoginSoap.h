//
//  LoginSoap.h
//  RapidReport_P
//
//  Created by hvit-pc on 14-3-16.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"

@class LoginSoap;
@protocol LoginSoapDelegate

-(void)loginSoapDidReturn:(LoginSoap *) p_soap;
@end

@interface LoginSoap : NSObject<SOAPToolDelegate>

-(void)getData:(NSString *) p_userName password:(NSString *)p_userPwd;

@property (weak,nonatomic)id<LoginSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSConvert *nsConvert;

@property (assign,nonatomic) BOOL remember;
@property (strong,nonatomic) NSMutableDictionary *userPlist;
@property (strong,nonatomic) NSString *userPlistPath;
@property (assign,nonatomic) BOOL success;
@property (strong,nonatomic) NSString *msg;

@end
