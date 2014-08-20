//
//  StationSoap.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-28.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//
#define ALERT(msg) {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"浙江地震信息网" message:msg delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];[alert show];}
#import "StationSoap.h"

@implementation StationSoap
-(void)GetStation:(NSString *) p_station{
    NSConfigData *configData = [[NSConfigData alloc]init];
    self.soap = [[SYSoapTool alloc] init];
    self.soap.delegate = self;
    
    _station = p_station;
    if ([p_station isEqual:@"GetQzStation"]) {
        [_soap callSoapServiceWithoutParameters__functionName:@"GetQzStation"
                                                      wsdlURL:[configData getWebServices]];
    }else{
        [_soap callSoapServiceWithoutParameters__functionName:@"GetCzStation"
                                                      wsdlURL:[configData getWebServices]];
    }

}

/*!
 @method
 @discussion 调用后台接口成功
 @result 空值
 */
-(void)retriveFromSYSoapTool:(NSMutableArray *)_data{
    NSError *error;
    NSString *t_json;
    if ([_station isEqualToString:@"GetQzStation"]) {
        t_json                =   [[_data objectAtIndex:0]
                                             objectForKey:@"GetQzStationResult"];
    }else{
         t_json                =   [[_data objectAtIndex:0]
                                             objectForKey:@"GetCzStationResult"];
    }
   
    NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                            options:kNilOptions
                                                              error:&error];
    if ([[jsonDic objectForKey:@"success"] boolValue]) {
        [self.delegate stationSoapDidReturn:self stationData:[jsonDic objectForKey:@"data"]];
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
