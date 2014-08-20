//
//  CusInfoDelByIdSoap.m
//  EarthQuake
//
//  Created by hvit-pc on 14-6-16.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "CusInfoDelByIdSoap.h"

@implementation CusInfoDelByIdSoap
-(void)DelInfoCusById:(NSString *) p_id{
    
    NSConfigData *configData = [[NSConfigData alloc]init];
    
    self.soap = [[SYSoapTool alloc] init];
    self.soap.delegate = self;
    NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"p_id",
                            nil];
    NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:p_id,
                            nil];
    
    [_soap callSoapServiceWithParameters__functionName:@"DelInfoCusById"
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
                                         objectForKey:@"DelInfoCusByIdResult"];
    NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                            options:kNilOptions
                                                              error:&error];
    if ([[jsonDic objectForKey:@"success"] boolValue]) {
        _returnDic = [jsonDic objectForKey:@"data"];
    }
    _success                        = [[jsonDic objectForKey:@"success"] boolValue];
    _msg                            = [jsonDic objectForKey:@"msg"];
    [_delegate cusInfoDelByIdSoapDidReturn:self];
}

/*!
 @method
 @discussion 调用后台接口失败
 @result 空值
 */
-(void)retriveErrorSYSoapTool:(NSError *)_error{
    _msg        = [NSString stringWithFormat:@"ERROR: %@", _error.localizedDescription];
    _success    = NO;
    [_delegate cusInfoDelByIdSoapDidReturn:self];
}
@end
