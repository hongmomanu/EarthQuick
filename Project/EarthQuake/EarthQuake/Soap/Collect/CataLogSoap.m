//
//  CataLogSoap.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-20.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "CataLogSoap.h"
#define ALERT(msg) {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"浙江地震信息网" message:msg delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];[alert show];}

@implementation CataLogSoap
-(void)getData
{
    
    NSConfigData *configData = [[NSConfigData alloc]init];
    
    self.soap = [[SYSoapTool alloc] init];
    self.soap.delegate = self;
    
    NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"p_focus",
                            nil];
    NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:@"1",
                            nil];
    
    [_soap callSoapServiceWithParameters__functionName:@"GetCzCatalog"
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
                                         objectForKey:@"GetCzCatalogResult"];
    NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                            options:kNilOptions
                                                              error:&error];
    if ([[jsonDic objectForKey:@"success"] boolValue])
    {
        NSDictionary *userData = [jsonDic objectForKey:@"data"];
        
        self.returnDic = [userData mutableCopy];
        
        [self.delegate cataLogSoapDidReturn:self data:self.returnDic];
    }
    else
    {
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
