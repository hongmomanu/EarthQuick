//
//  MapUtil.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-17.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapUtil : NSObject
+(double)rad:(double)  d;
+(NSString *) compareCurrentTime:(NSDate*) compareDate;
+(long) getDistanceLatA:(double)latA
                   lngA:(double)lngA
                   latB:(double)latB
                   lngB:(double)lngB;
@end
