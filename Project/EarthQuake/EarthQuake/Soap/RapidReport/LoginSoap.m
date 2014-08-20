//
//  UserSoap.m
//  RapidReport_P
//
//  Created by hvit-pc on 14-3-16.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//
#define ALERT(msg) {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"浙江地震信息网" message:msg delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];[alert show];}
#import "LoginSoap.h"

@implementation LoginSoap

-(void)getData:(NSString *)p_userName password:(NSString *)p_userPwd{
    
    NSConfigData *configData = [[NSConfigData alloc]init];
    self.userPlistPath=[configData getUserPath];
    self.nsConvert = [[NSConvert alloc]init];
    self.userPlist =[configData getUserDic];
    self.soap = [[SYSoapTool alloc] init];
    self.soap.delegate = self;
    
    NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"p_userName",
                            @"p_userPwd",
                            nil];
    NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:p_userName,
                            p_userPwd,
                            nil];
    
    [_soap callSoapServiceWithParameters__functionName:@"GetLogin"
                                                  tags:tags
                                                  vars:vars
                                               wsdlURL:[configData getWebServices]];
}

/*!
 @method
 @discussion 调用后台接口成功
 @result 空值
 */
-(void)retriveFromSYSoapTool:(NSMutableArray *)_data{
    NSError *error;
    NSString *t_json                =   [[_data objectAtIndex:0]
                                         objectForKey:@"GetLoginResult"];
    NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                            options:kNilOptions
                                                              error:&error];
    if ([[jsonDic objectForKey:@"success"] boolValue]) {
        NSDictionary *userData = [jsonDic objectForKey:@"data"];
        
        self.userPlist = [userData mutableCopy];
        if (self.remember) {
            [self.userPlist setValue:@"YES" forKey:@"Remember"];
            [[self.nsConvert NSDictionaryToNsData:self.userPlist ] writeToFile:self.userPlistPath atomically:YES];
        }
    }
    _success                        = [[jsonDic objectForKey:@"success"] boolValue];
    _msg                            = [jsonDic objectForKey:@"msg"];
    [_delegate loginSoapDidReturn:self];
}

/*!
 @method
 @discussion 调用后台接口失败
 @result 空值
 */
-(void)retriveErrorSYSoapTool:(NSError *)_error{
    _msg        = [NSString stringWithFormat:@"ERROR: %@", _error.localizedDescription];
    _success    = NO;
    [_delegate loginSoapDidReturn:self];
}

@end
