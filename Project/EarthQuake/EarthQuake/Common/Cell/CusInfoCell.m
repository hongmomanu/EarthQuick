//
//  CusInfoCell.m
//  EarthQuake
//
//  Created by hvit-pc on 14-6-16.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "CusInfoCell.h"

@implementation CusInfoCell
@synthesize title;
@synthesize type;

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


- (void)setTitle:(NSString *)p_title
{
    if (![p_title isEqualToString:title])
    {
        title = [p_title copy];
        
        self.titleLabel.text = title;
    }
}

-(void)setType:(NSString *)p_type
{
    if (![p_type isEqualToString:type])
    {
        type = [p_type copy];
        
        self.typeLabel.text = type;
    }
}

@end
