//
//  QzRunSoap.m
//  EarthQuake
//
//  Created by hvit-pc on 14-6-5.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "QzRunSoap.h"

@implementation QzRunSoap
-(void)getQzRun:(NSString*)p_stationId
         ItemId:(NSString*)p_itemId
     InstrtType:(NSString*)p_instrtType
         Months:(NSString*)p_months{
    NSConfigData *configData    = [[NSConfigData alloc]init];
    _soap                       = [[SYSoapTool alloc] init];
    _soap.delegate              = self;
    
    
    NSRange range = [p_months rangeOfString:@"个"];
    p_months = [p_months substringToIndex:range.location];
    
    
    NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"p_stationid",
                            @"p_itemid",
                            @"p_instrttype",
                            @"p_months",
                            nil];
    NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:p_stationId,
                            p_itemId,
                            p_instrtType,
                            [NSString stringWithFormat:@"%d",-[p_months intValue]],
                            nil];
    
    [_soap callSoapServiceWithParameters__functionName:@"GetQzRunning"
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
                                         objectForKey:@"GetQzRunningResult"];
    NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                            options:kNilOptions
                                                              error:&error];
    if ([[jsonDic objectForKey:@"success"] boolValue]) {
        _returnDic                 = [jsonDic objectForKey:@"data"];
        
    }
    _success                        = [[jsonDic objectForKey:@"success"] boolValue];
    _msg                            = [jsonDic objectForKey:@"msg"];
    [_delegate qzRunSoapDidReturn:self];
}
/*!
 @method
 @discussion 调用后台接口失败
 @result 空值
 */
-(void)retriveErrorSYSoapTool:(NSError *)_error{
    _msg        = [NSString stringWithFormat:@"ERROR: %@", _error.localizedDescription];
    _success    = NO;
    [_delegate qzRunSoapDidReturn:self];
}
@end
