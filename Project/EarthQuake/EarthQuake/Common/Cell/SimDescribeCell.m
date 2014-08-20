//
//  SimDescribeCell.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-14.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "SimDescribeCell.h"

@implementation SimDescribeCell
@synthesize context;

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

- (void)setContext:(NSString *)p_con {
    if (![p_con isEqualToString:context]) {
        context = [p_con copy];
        self.conLabel.text = context;
    }
}

@end
