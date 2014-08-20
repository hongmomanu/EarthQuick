//
//  CzRunSoap.m
//  EarthQuake
//
//  Created by hvit-pc on 14-6-3.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "CzRunSoap.h"

@implementation CzRunSoap
-(void)getCzRun:(NSString*)p_stationId
         Months:(NSString*)p_months{
    NSConfigData *configData    = [[NSConfigData alloc]init];
    _soap                       = [[SYSoapTool alloc] init];
    _soap.delegate              = self;
    

    NSRange range = [p_months rangeOfString:@"个"];
    p_months = [p_months substringToIndex:range.location];
    
    NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"p_stationid",
                            @"p_months",
                            nil];
    NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:p_stationId,
                            [NSString stringWithFormat:@"%d",-[p_months intValue]],
                            nil];
    
    [_soap callSoapServiceWithParameters__functionName:@"GetCzRunning"
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
                                         objectForKey:@"GetCzRunningResult"];
    NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                            options:kNilOptions
                                                              error:&error];
    if ([[jsonDic objectForKey:@"success"] boolValue]) {
        _returnDic                 = [jsonDic objectForKey:@"data"];
        
    }
    _success                        = [[jsonDic objectForKey:@"success"] boolValue];
    _msg                            = [jsonDic objectForKey:@"msg"];
    [_delegate czRunSoapDidReturn:self];
}
/*!
 @method
 @discussion 调用后台接口失败
 @result 空值
 */
-(void)retriveErrorSYSoapTool:(NSError *)_error{
    _msg        = [NSString stringWithFormat:@"ERROR: %@", _error.localizedDescription];
    _success    = NO;
    [_delegate czRunSoapDidReturn:self];
}

@end
