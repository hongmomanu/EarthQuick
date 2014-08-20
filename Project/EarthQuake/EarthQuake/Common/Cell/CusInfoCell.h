//
//  CusInfoCell.h
//  EarthQuake
//
//  Created by hvit-pc on 14-6-16.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface CusInfoCell : SWTableViewCell
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *type;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end
