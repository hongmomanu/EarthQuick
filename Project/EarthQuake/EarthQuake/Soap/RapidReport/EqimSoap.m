//
//  EqimSoap.m
//  RapidReport_P
//
//  Created by hvit-pc on 14-3-30.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "EqimSoap.h"
#define ALERT(msg) {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"浙江地震信息网" message:msg delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];[alert show];}

@implementation EqimSoap
-(void)getCataLogEx:(NSString *)p_eqimType Day:(NSString *)p_day{
    
    NSConfigData *configData = [[NSConfigData alloc]init];
    
    self.soap = [[SYSoapTool alloc] init];
    self.soap.delegate = self;
    
    NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"p_epimType",
                            @"p_time",
                            @"p_currentPageIndex",
                            @"p_pageSize",
                            nil];
    NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:p_eqimType,
                            p_day,
                            @"1",
                            @"30",
                            nil];
    
    [_soap callSoapServiceWithParameters__functionName:@"GetCataLogCusEx"
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
                                         objectForKey:@"GetCataLogCusExResult"];
    NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                            options:kNilOptions
                                                              error:&error];
    if ([[jsonDic objectForKey:@"success"] boolValue]) {
        [self.delegate eqimSoapDidReturn:self eqimData:[jsonDic objectForKey:@"data"]];
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
