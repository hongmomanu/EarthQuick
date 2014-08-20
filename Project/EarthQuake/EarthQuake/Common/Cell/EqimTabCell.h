//
//  EqimTabCell.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-14.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EqimTabCell : UITableViewCell
@property (copy, nonatomic) NSString *m;
@property (copy, nonatomic) NSString *locationCName;
@property (copy, nonatomic) NSString *oTime;
@property (copy, nonatomic) NSString *distance;

@property (weak, nonatomic) IBOutlet UILabel *mLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationCNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *oTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end
