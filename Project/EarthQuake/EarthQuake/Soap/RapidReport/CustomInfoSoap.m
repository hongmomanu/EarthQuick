//
//  CustomInfoSoap.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-25.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//
#define ALERT(msg) {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"浙江地震信息网" message:msg delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];[alert show];}
#import "CustomInfoSoap.h"

@implementation CustomInfoSoap
-(void)GetInfoCus:(NSString *) p_userId
         infoType:(NSString *) p_infoType{

    NSConfigData *configData = [[NSConfigData alloc]init];
    
    self.soap = [[SYSoapTool alloc] init];
    self.soap.delegate = self; // use SOAPEngineDelegate
    NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"p_userId",
                            @"p_infoType",
                            nil];
    NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:p_userId,
                            p_infoType,

                            nil];
    
    [_soap callSoapServiceWithParameters__functionName:@"GetInfoCus"
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
                                         objectForKey:@"GetInfoCusResult"];
    NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                            options:kNilOptions
                                                              error:&error];
    if ([[jsonDic objectForKey:@"success"] boolValue]) {
        [self.delegate customInfoSoapDidReturn:self cusData:[jsonDic objectForKey:@"data"]];
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
