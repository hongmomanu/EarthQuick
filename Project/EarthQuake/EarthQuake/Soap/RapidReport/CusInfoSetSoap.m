//
//  CusInfoSetSoap.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-25.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//
#import "CusInfoSetSoap.h"

@implementation CusInfoSetSoap
-(void)SetInfoCus:(NSString *) p_id
         userId:(NSString *) p_userId
             type:(NSString *) p_type
             maxx:(NSString *) p_maxx
             maxy:(NSString *) p_maxy
             minx:(NSString *) p_minx
             miny:(NSString *) p_miny
           mSmall:(NSString *) p_mSmall
           mLarge:(NSString *) p_mLarge
        conserStr:(NSString *) p_conserStr
         province:(NSString *) p_province
{

    NSConfigData *configData = [[NSConfigData alloc]init];
    
    self.soap = [[SYSoapTool alloc] init];
    
    self.soap.delegate = self; // use SOAPEngineDelegate
    
    NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"p_id",
                            @"p_userId",
                            @"p_type",
                            @"p_maxx",
                            @"p_maxy",
                            @"p_minx",
                            @"p_miny",
                            @"p_mSmall",
                            @"p_mLarge",
                            @"p_conserStr",
                            @"p_province",
                            nil];
    NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:p_id,
                            p_userId,
                            p_type,
                            p_maxx,
                            p_maxy,
                            p_minx,
                            p_miny,
                            p_mSmall,
                            p_mLarge,
                            p_conserStr,
                            p_province,
                            nil];
    
    //NSLog(@"soap ocean,%@",vars);
    [_soap callSoapServiceWithParameters__functionName:@"SetInfoCus"
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
                                         objectForKey:@"SetInfoCusResult"];
    NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                            options:kNilOptions
                                                              error:&error];
    if ([[jsonDic objectForKey:@"success"] boolValue]) {
        _returnDic = [jsonDic objectForKey:@"data"];
    }
    _success                        = [[jsonDic objectForKey:@"success"] boolValue];
    _msg                            = [jsonDic objectForKey:@"msg"];
    //NSLog(@"soap ocean,%@",@"success");
    //NSLog(@"soap ocean,%@",_msg);

         
    [self.delegate cusInfoSetSoapDidReturn:self];
}
/*!
 @method
 @discussion 调用后台接口失败
 @result 空值
 */
-(void)retriveErrorSYSoapTool:(NSError *)_error{
    _msg        = [NSString stringWithFormat:@"ERROR: %@", _error.localizedDescription];
    //NSLog(@"soap ocean,%@",_msg);
    //NSLog(@"soap ocean,%@",@"error");
    _success    = NO;
    [self.delegate cusInfoSetSoapDidReturn:self];
}
@end
