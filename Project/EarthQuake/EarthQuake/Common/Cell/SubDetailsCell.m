//
//  SubDetailsCell.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-30.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "SubDetailsCell.h"

@implementation SubDetailsCell
@synthesize key;
@synthesize value;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setKey:(NSString *)p_key{
    if (![p_key isEqualToString:key]) {
        key = [p_key copy];
        self.keyLabel.text = key;
    }
}

-(void)setValue:(NSString *)p_value{
    if (![p_value isEqualToString:value]) {
        value = [p_value copy];
        self.valueLabel.text = value;
        
    }
}

@end
