//
//  Intensity.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-15.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Intensity : NSObject
@property (nonatomic,strong) NSString *intensity;
@property (nonatomic,strong) NSString *feel;
@property (nonatomic,strong) NSString *build;
@property (nonatomic,strong) NSString *other;

-(id)initWithValue:(NSString *)theIntensity feel:(NSString *)theFeel build:(NSString *)theBuild other:(NSString *)theOther;
@end
