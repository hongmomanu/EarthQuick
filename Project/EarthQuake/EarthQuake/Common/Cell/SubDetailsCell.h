//
//  SubDetailsCell.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-30.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubDetailsCell : UITableViewCell
@property (copy, nonatomic) NSString *key;
@property (copy, nonatomic) NSString *value;
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@end
