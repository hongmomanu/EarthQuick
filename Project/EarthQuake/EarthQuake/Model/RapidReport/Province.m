//
//  Diary.m
//  MyDiary
//
//  Created by hvit-pc on 14-3-6.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "Province.h"

@implementation Province
+(id)createProvince{
    Province *newDiary = [[Province alloc] init];
    
    return newDiary;
}

-(id)init{
    return [self initWithTitle:@"" select:NO];
}

-(id)initWithTitle:(NSString *)theTitle select:(BOOL *)theSelect{
    self = [super init];
    if(self){
        //通过访问器赋值
        [self setTitle:theTitle];
        [self setSelect:theSelect];
        
    }
    return self;
}
@end
