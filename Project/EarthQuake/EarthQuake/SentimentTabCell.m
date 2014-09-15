//
//  SentimentTabCell.m
//  EarthQuake
//
//  Created by hvit-pc on 14-9-4.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "SentimentTabCell.h"

@implementation SentimentTabCell
@synthesize title;
@synthesize levelstr;
@synthesize levelchar;
@synthesize otime;
@synthesize evaluatestr;


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void) setEvaluatestr:(NSString *)p_evaluatestr{
    
    if (![p_evaluatestr isEqualToString:evaluatestr]) {
        evaluatestr = [p_evaluatestr copy];
        
    }

}
- (void)setLevelchar:(NSString *)p_levelchar {
    
    if (![p_levelchar isEqualToString:levelchar]) {
        levelchar = [p_levelchar copy];
        
        self.levelcharLabel.text = levelchar;
        if([evaluatestr isEqualToString:@"1"]){
            [self.levelcharLabel setTextColor:[UIColor greenColor]];
        }else{
            [self.levelcharLabel setTextColor:[UIColor redColor]];
        }
       
        
    }
}

-(void)setLevelstr:(NSString *)p_levelstr {
    if (![p_levelstr isEqualToString:levelstr]) {
        levelstr = [p_levelstr copy];
        self.levelstrLabel.text = levelstr;
    }
}
-(void)setTitle:(NSString *)p_title{
    if(![p_title isEqualToString:title]){
        title=[p_title copy];
        self.titleLabel.text=title;
    }

}


-(void)setOtime:(NSString *)p_oTime {
    if (![p_oTime isEqualToString:otime]) {
        otime = [p_oTime copy];
        self.oTimeLabel.text = otime;
    }
}


@end
