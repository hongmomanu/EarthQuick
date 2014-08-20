//
//  RegisterSoap.h
//  RapidReport_P
//
//  Created by hvit-pc on 14-3-23.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"

@class RegisterSoap;
@protocol RegisterSoapDelegate

-(void)registerSoapDidReturn:(RegisterSoap *) p_loginSoap;
@end

@interface RegisterSoap : NSObject<SOAPToolDelegate>
-(void)RegisterUser:(NSString *) p_userName
             userId:(NSString *)p_userId
           password:(NSString *)p_userPwd
               name:(NSString *)p_name
          mobiletel:(NSString *)p_mobiletel
              email:(NSString *)p_email
               note:(NSString *)p_note
               imei:(NSString *)p_imei;

@property (weak,nonatomic)id<RegisterSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSConvert *nsConvert;

@property (assign,nonatomic) BOOL *remember;
@property (strong,nonatomic) NSMutableDictionary *userPlist;
@property (strong,nonatomic) NSString *userPlistPath;
@property (assign,nonatomic) BOOL *success;
@property (strong,nonatomic) NSString *msg;
@end
