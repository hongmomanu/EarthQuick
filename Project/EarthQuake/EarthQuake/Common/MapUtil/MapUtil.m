//
//  MapUtil.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-17.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "MapUtil.h"

@implementation MapUtil
static double EARTH_RADIUS = 6378.137;

+(double)rad:(double)  d{
    return d * M_PI / 180.0;
}

/**
 * 比较两个时间的相差值
 * @param begin
 * @param date
 * @param after
 * @return begin+n(秒or分or天or月or年)+end 如果当前时间在比较时间之前的直接返回data.toString
 */
+(NSString *) compareCurrentTime:(NSDate*) compareDate
//                            after:(NSString*) after
{
    
    /**
     
     - (id)initWithTimeInterval:(NSTimeInterval)secs sinceDate:(NSDate *)refDate;
     初始化为以refDate为基准，然后过了secs秒的时间
     
     - (id)initWithTimeIntervalSinceNow:(NSTimeInterval)secs;
     初始化为以当前时间为基准，然后过了secs秒的时间
     
     
     - (NSTimeInterval)timeIntervalSinceDate:(NSDate *)refDate;
     以refDate为基准时间，返回实例保存的时间与refDate的时间间隔
     
     - (NSTimeInterval)timeIntervalSinceNow;
     以当前时间(Now)为基准时间，返回实例保存的时间与当前时间(Now)的时间间隔
     
     - (NSTimeInterval)timeIntervalSince1970;
     以1970/01/01 GMT为基准时间，返回实例保存的时间与1970/01/01 GMT的时间间隔
     
     - (NSTimeInterval)timeIntervalSinceReferenceDate;
     以2001/01/01 GMT为基准时间，返回实例保存的时间与2001/01/01 GMT的时间间隔
     
     
     + (NSTimeInterval)timeIntervalSinceReferenceDate;
     
     */
    
    
    //秒
    // - (NSTimeInterval)timeIntervalSinceNow;
    //    以当前时间(Now)为基准时间，返回实例保存的时间与当前时间(Now)的时间间隔
    
    //    NSLog(@"compareDate:%@", compareDate);
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%d分前",temp];
    }
    
    else if((temp = temp/60) < 24){
        result = [NSString stringWithFormat:@"%d小前",temp];
    }
    
    else if((temp = temp/24) < 30){
        result = [NSString stringWithFormat:@"%d天前",temp];
    }
    
    else if((temp = temp/30) < 12){
        result = [NSString stringWithFormat:@"%d月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",temp];
    }
    
    return  result;
    
}

//获取两点经纬度地址的方法 返回的单位是公里
+(long) getDistanceLatA:(double)latA
                   lngA:(double)lngA
                   latB:(double)latB
                   lngB:(double)lngB{
    
    double radLat1 =  [self rad:latA ];
    
    double radLat2 = [self rad:latB ];
    
    double a = radLat1 - radLat2;
    double b = [self rad:lngA] - [self rad:lngB];
    
    double s = 2 * sin(sqrt(pow(sin(a / 2), 2)
                            + cos(radLat1) * cos(radLat2)
                            * pow(sin(b / 2), 2)));
    s = s * EARTH_RADIUS;
    s = s*1000;
    long c = (round((s))/10)*10;
    
    return c;
}
@end
