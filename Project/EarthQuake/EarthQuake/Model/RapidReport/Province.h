//
//  Diary.h
//  MyDiary
//
//  Created by hvit-pc on 14-3-6.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject

+(id)createProvince;
-(id)initWithTitle:(NSString *)theTitle select:(BOOL *)theSelect;

@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) BOOL *select;

@end
