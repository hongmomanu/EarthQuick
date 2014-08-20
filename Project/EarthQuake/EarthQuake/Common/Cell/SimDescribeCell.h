//
//  SimDescribeCell.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-14.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimDescribeCell : UITableViewCell

@property (copy, nonatomic) NSString *context;

@property (weak, nonatomic) IBOutlet UILabel *conLabel;

@end
