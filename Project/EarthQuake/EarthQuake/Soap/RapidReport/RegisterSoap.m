//
//  RegisterSoap.m
//  RapidReport_P
//
//  Created by hvit-pc on 14-3-23.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//
#define ALERT(msg) {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"浙江地震信息网" message:msg delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];[alert show];}
#import "RegisterSoap.h"

@implementation RegisterSoap

-(void)RegisterUser:(NSString *) p_userName
             userId:(NSString *)p_userId
           password:(NSString *)p_userPwd
               name:(NSString *)p_name
          mobiletel:(NSString *)p_mobiletel
              email:(NSString *)p_email
               note:(NSString *)p_note
               imei:(NSString *)p_imei{
    
    NSConfigData *configData = [[NSConfigData alloc]init];
    
    self.soap = [[SYSoapTool alloc] init];
    self.soap.delegate = self;
    
    NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"p_userName",
                            @"p_userId",
                            @"p_name",
                            @"p_userPwd",
                            @"p_mobiletel",
                            @"p_email",
                            @"p_note",
                            @"p_imei",
                            nil];
    NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:p_userName,
                            p_userId,
                            p_name,
                            p_userPwd,
                            p_mobiletel,
                            p_email,
                            p_note,
                            p_imei,
                            nil];
    
    [_soap callSoapServiceWithParameters__functionName:@"SetUser"
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
                                         objectForKey:@"SetUserResult"];
    NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                            options:kNilOptions
                                                              error:&error];
    if ([[jsonDic objectForKey:@"success"] boolValue]) {
        self.msg = [jsonDic objectForKey:@"msg"];
        ALERT(self.msg);
        [self.delegate registerSoapDidReturn:self];
    }else{
        self.msg = [jsonDic objectForKey:@"msg"];
        ALERT(self.msg);
    }
    
}

/*!
 @method
 @discussion 调用后台接口失败
 @result 空值
 */
-(void)retriveErrorSYSoapTool:(NSError *)_error{
    self.msg = [NSString stringWithFormat:@"ERROR: %@", _error.localizedDescription];
    ALERT(self.msg);
}


@end
