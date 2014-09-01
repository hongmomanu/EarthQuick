//
//  FeelUploadSoap.m
//  EarthQuake
//
//  Created by hvit-pc on 14-6-9.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "FeelUploadSoap.h"

@implementation FeelUploadSoap
-(void)uploadDataFeel:(NSString*)p_infoId
                Name:(NSString*)p_name
           Longitude:(NSString*)p_longitude
            Latitude:(NSString*)p_latitude
             Address:(NSString*)p_address
        SDescription:(NSString*)p_sDescription
        PDescription:(NSString*)p_pDescription
             FloorNum:(NSString*)p_floornum
                Date:(NSString*)p_date
                Time:(NSString*)p_time{
    
    NSConfigData *configData    = [[NSConfigData alloc]init];
    _soap                       = [[SYSoapTool alloc] init];
    _soap.delegate              = self;
    
    
    NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"p_infoId",
                            @"p_name",
                            @"p_longitude",
                            @"p_latitude",
                            @"p_address",
                            @"p_sDescription",
                            @"p_pDescription",
                            @"p_floor",
                            @"p_date",
                            @"p_time",
                            nil];
    NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:p_infoId,
                            p_name,
                            p_longitude,
                            p_latitude,
                            p_address,
                            p_sDescription,
                            p_pDescription,
                            p_floornum,
                            p_date,
                            p_time,
                            nil];
    
    [_soap callSoapServiceWithParameters__functionName:@"UploadDataEqFeel"
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
                                            objectForKey:@"UploadDataEqFeelResult"];
        NSData *result = [t_json dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:result
                                                                options:kNilOptions
                                                                  error:&error];
    _success                        = [[jsonDic objectForKey:@"success"] boolValue];
    _msg                            = [jsonDic objectForKey:@"msg"];
        if ([[jsonDic objectForKey:@"success"] boolValue]) {
            _returnDic                 = [jsonDic objectForKey:@"data"];
            
            if (_photoArr.count >0) {
                _imageSoap                 = [[ImageSoap alloc]init];
                _imageSoap.delegate = self;
                [self UploadImage:0];
            }else {
                if(_videoArr.count >0){
                    _videoSoap                 = [[VideoSoap alloc]init];
                    _videoSoap.delegate = self;
                    [self UploadVideo:0];
                }else{
                    [_delegate feelUploadSoapDidReturn:self];
                }
            }
            
        }else{
            
            [_delegate feelUploadSoapDidReturn:self];
        }

        [_delegate feelUploadSoapDidReturn:self];
}

-(void)imageSoapDidReturn:(ImageSoap *) p_soap{
    self.photoIndex++;
    [self UploadImage:self.photoIndex];
}

-(void)videoSoapDidReturn:(ImageSoap *) p_soap{
    self.videoIndex++;
    [self UploadVideo:self.videoIndex];
}



-(void)UploadImage:(NSUInteger)pIndex{
    if (pIndex < _photoArr.count) {
        self.photoIndex = pIndex;
        [_imageSoap UploadImage:[[self.photoArr objectAtIndex:self.photoIndex] lastPathComponent] imageType:_strMoudleType imgFkid:_strInfoId earthId:_strEarthId data:[[NSData alloc] initWithContentsOfFile:[self.photoArr objectAtIndex:self.photoIndex]]];
    }else{
        if(_videoArr.count >0){
            _videoSoap                 = [[VideoSoap alloc]init];
            _videoSoap.delegate = self;
            [self UploadVideo:0];
        }else{
            [_delegate feelUploadSoapDidReturn:self];
        }
        
    }
    
}

-(void)UploadVideo:(NSUInteger)pIndex{
    if (pIndex < _videoArr.count) {
        self.videoIndex = pIndex;
        [_videoSoap UploadVideo:[[self.videoArr objectAtIndex:self.videoIndex] lastPathComponent] videoType:_strMoudleType videoFkid:_strInfoId earthId:_strEarthId data:[[NSData alloc] initWithContentsOfFile:[self.videoArr objectAtIndex:self.videoIndex]]];
    }else{
        [_delegate feelUploadSoapDidReturn:self];
    }
    
}
/*!
 @method
 @discussion 调用后台接口失败
 @result 空值
 */
-(void)retriveErrorSYSoapTool:(NSError *)_error{
    _msg        = [NSString stringWithFormat:@"ERROR: %@", _error.localizedDescription];
    _success    = NO;
    [_delegate feelUploadSoapDidReturn:self];
}



@end
