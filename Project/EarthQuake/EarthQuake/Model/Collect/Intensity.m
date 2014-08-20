//
//  Intensity.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-15.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "Intensity.h"

@implementation Intensity
-(id)initWithValue:(NSString *)theIntensity feel:(NSString *)theFeel build:(NSString *)theBuild other:(NSString *)theOther{
    self = [super init];
    if(self){
        //通过访问器赋值
        [self setIntensity:theIntensity];
        [self setFeel:theFeel];
        [self setBuild:theBuild];
        [self setOther:theOther];
        
    }
    return self;
}
@end
