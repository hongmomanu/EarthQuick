//
//  ProCell.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-20.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "ProCell.h"

@implementation ProCell
@synthesize address;
@synthesize time;
@synthesize state;

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

- (void)setAddress:(NSString *)p_address{
    if (![p_address isEqualToString:address]) {
        address = [p_address copy];
        self.addressLabel.text = address;
    }
}

-(void)setTime:(NSString *)p_time{
    if (![p_time isEqualToString:time]) {
        time = [p_time copy];
        self.timeLabel.text = time;
        
    }
}

-(void)setState:(NSString *)p_state{
    if (![p_state isEqualToString:state]) {
        state = [p_state copy];
        self.stateLabel.text = state;
        
    }
}

@end
