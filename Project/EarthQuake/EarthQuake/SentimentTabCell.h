//
//  SentimentTabCell.h
//  EarthQuake
//
//  Created by hvit-pc on 14-9-4.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SentimentTabCell : UITableViewCell
@property (copy, nonatomic) NSString *levelchar;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *levelstr;
@property (copy, nonatomic) NSString *otime;


@property (weak, nonatomic) IBOutlet UILabel *levelcharLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelstrLabel;
@property (weak, nonatomic) IBOutlet UILabel *oTimeLabel;

@end
