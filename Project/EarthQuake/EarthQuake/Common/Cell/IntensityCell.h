//
//  IntensityCell.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-15.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntensityCell : UITableViewCell
@property (copy, nonatomic) NSString *key;
@property (copy, nonatomic) NSString *value;

@property (weak, nonatomic) IBOutlet UILabel *keyLab;
@property (weak, nonatomic) IBOutlet UILabel *valueLab;

@end
