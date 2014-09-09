//
//  SentimentSoap.m
//  EarthQuake
//
//  Created by hvit-pc on 14-9-4.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "SentimentSoap.h"
#define ALERT(msg) {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"浙江地震信息网" message:msg delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];[alert show];}

@implementation SentimentSoap

-(void)getPublicSentiment:(NSString *)p_pi p_page:(NSString *)p_pPageNo{
    
    NSConfigData *configData = [[NSConfigData alloc]init];
    
    self.soap = [[SYSoapTool alloc] init];
    self.soap.delegate = self;
    
    NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"pi",
                            @"pPageNo",nil];
    NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:p_pi,
                            p_pPageNo,nil];
    
    NSLog(@"vars %@",vars);
    
    
    [_soap callSoapServiceWithParameters__functionName:@"GetPublicSentimentList"
                                                  tags:tags
                                                  vars:vars
                                               wsdlURL:[configData getWebServices]
                                              
     ];
    
}

/*!
 @method
 @discussion 调用后台接口成功
 @result 空值
 */
-(void)retriveFromSYSoapTool:(NSMutableArray *)_data{
    
   
    NSError *error;
    NSString *t_json                =   [[_data objectAtIndex:0]
                                         objectForKey:@"GetPublicSentimentListResult"];
    NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                            options:kNilOptions
                                                              error:&error];
    //NSLog(@"测试11 %@",jsonDic);
    if(jsonDic==nil){
        //NSLog(@"测试2222 %@",jsonDic);
        [self.delegate sentimentSoapFailReturn];
    }
    else{
        
        if ([[jsonDic objectForKey:@"success"] boolValue]) {
            [self.delegate sentimentSoapDidReturn:self sentimentData:[jsonDic objectForKey:@"data"]];
        }else{
            self.msg = [jsonDic objectForKey:@"msg"];
            ALERT(self.msg);
        }
    }
    
}
/*!
 @method
 @discussion 调用后台接口失败
 @result 空值
 */
-(void)retriveErrorSYSoapTool:(NSError *)_error{
    //NSLog(@"eroor");
    self.msg = [NSString stringWithFormat:@"ERROR: %@", _error.localizedDescription];
    //ALERT(self.msg);
    [self.delegate sentimentSoapFailReturn];
}
@end
