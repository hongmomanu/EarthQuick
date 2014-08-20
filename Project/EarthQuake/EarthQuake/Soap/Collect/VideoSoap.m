//
//  ImageSoap.m
//  EarthQuake
//
//  Created by 于华 on 14-8-9.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "VideoSoap.h"

@implementation VideoSoap
-(void)UploadVideo:(NSString *)pVideoName
        videoType :(NSString*)pVideoType
           videoFkid:(NSString*)pVideoFkid
           earthId:(NSString*)pEarthId
              data:(NSData*)pData{
    
    NSConfigData *configData    = [[NSConfigData alloc]init];
    _soap                       = [[SYSoapTool alloc] init];
    _soap.delegate              = self;
    
    
    NSMutableArray *tags =[[NSMutableArray alloc]initWithObjects:@"p_vidName",@"p_vidType",@"p_vidFkid",@"p_earthId",@"p_data", nil];
    
    NSString *tBase64Str = [pData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSMutableArray *vars =[[NSMutableArray alloc]initWithObjects:pVideoName,pVideoType,pVideoFkid,pEarthId,tBase64Str, nil];
    
    
    [_soap callSoapServiceWithParameters__functionName:@"VideoImage"
                                                  tags:tags
                                                  vars:vars
                                               wsdlURL:[configData getWebServices]];
}

/*!
 @method
 @discussion 调用后台接口成功
 @result 空值
 */
-(void)retriveFromSYSoapTool:(NSMutableArray *)_data
{
    NSError *error;
    NSString *t_json                =   [[_data objectAtIndex:0]
                                         objectForKey:@"VideoImageResult"];
    NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                            options:kNilOptions
                                                              error:&error];
    if ([[jsonDic objectForKey:@"success"] boolValue]) {
        _returnDic                 = [jsonDic objectForKey:@"data"];
        
    }
    _success                        = [[jsonDic objectForKey:@"success"] boolValue];
    _msg                            = [jsonDic objectForKey:@"msg"];
    [_delegate videoSoapDidReturn:self];
    
}



/*!
 @method
 @discussion 调用后台接口失败
 @result 空值
 */
-(void)retriveErrorSYSoapTool:(NSError *)_error{
    _msg        = [NSString stringWithFormat:@"ERROR: %@", _error.localizedDescription];
    _success    = NO;
    [_delegate videoSoapDidReturn:self];
}

@end
