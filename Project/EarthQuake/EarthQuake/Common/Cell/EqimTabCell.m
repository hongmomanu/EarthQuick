//
//  EqimTabCell.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-14.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "EqimTabCell.h"

@implementation EqimTabCell
@synthesize m;
@synthesize locationCName;
@synthesize oTime;
@synthesize distance;

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

- (void)setM:(NSString *)p_m {
    if (![p_m isEqualToString:m]) {
        m = [p_m copy];
        self.mLabel.text = m;
    }
}

-(void)setLocationCName:(NSString *)p_locationCName {
    if (![p_locationCName isEqualToString:locationCName]) {
        locationCName = [p_locationCName copy];
        self.locationCNameLabel.text = locationCName;
    }
}

-(void)setDistance:(NSString *)p_distance {
    if (![p_distance isEqualToString:distance]) {
        distance = [p_distance copy];
        self.distanceLabel.text = distance;
    }
}

-(void)setOTime:(NSString *)p_oTime {
    if (![p_oTime isEqualToString:oTime]) {
        oTime = [p_oTime copy];
        self.oTimeLabel.text = p_oTime;
    }
}

@end
