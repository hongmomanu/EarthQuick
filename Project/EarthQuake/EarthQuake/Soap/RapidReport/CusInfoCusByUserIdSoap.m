//
//  CusInfoCusByUserId.m
//  EarthQuake
//
//  Created by hvit-pc on 14-6-13.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//
#import "CusInfoCusByUserIdSoap.h"

@implementation CusInfoCusByUserIdSoap
-(void)getInfoCusByUserId:(NSString *) p_userId{
    
    NSConfigData *configData = [[NSConfigData alloc]init];
    self.soap = [[SYSoapTool alloc] init];
    self.soap.delegate = self;
    
    NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"p_userId",
                            nil];
    NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:p_userId,
                            nil];
    
    [_soap callSoapServiceWithParameters__functionName:@"GetInfoCusByUserId"
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
                                         objectForKey:@"GetInfoCusByUserIdResult"];
    NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                            options:kNilOptions
                                                              error:&error];
    if ([[jsonDic objectForKey:@"success"] boolValue]) {
        _returnDic = [jsonDic objectForKey:@"data"];
    }
    _success                        = [[jsonDic objectForKey:@"success"] boolValue];
    _msg                            = [jsonDic objectForKey:@"msg"];
    [_delegate cusInfoCusByUserIdSoapDidReturn:self];
}
/*!
 @method
 @discussion 调用后台接口失败
 @result 空值
 */
-(void)retriveErrorSYSoapTool:(NSError *)_error{
    _msg        = [NSString stringWithFormat:@"ERROR: %@", _error.localizedDescription];
    _success    = NO;
    [_delegate cusInfoCusByUserIdSoapDidReturn:self];
}
@end

