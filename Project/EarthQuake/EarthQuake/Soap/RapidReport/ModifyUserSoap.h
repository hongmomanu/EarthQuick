//
//  ModifyUserSoap.h
//  RapidReport_P
//
//  Created by hvit-pc on 14-3-21.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"
@class ModifyUserSoap;
@protocol ModifUserSoapDelegate

-(void)ModifyUserSoapDidReturn:(ModifyUserSoap *) p_soap;
@end


@interface ModifyUserSoap : NSObject<SOAPToolDelegate>
-(void)ModifyUser:(NSString *) p_userName
           userId:(NSString *)p_userId
         password:(NSString *)p_userPwd
             name:(NSString *)p_name
      mobiletel:(NSString *)p_mobiletel
          email:(NSString *)p_email
           note:(NSString *)p_note
           imei:(NSString *)p_imei;

@property (weak,nonatomic)id<ModifUserSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;

@property (assign,nonatomic) BOOL *success;
@property (strong,nonatomic) NSString *msg;
@property (strong,nonatomic) NSMutableDictionary *userPlist;
@end
