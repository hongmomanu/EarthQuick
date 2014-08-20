//
//  CustDetailsViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-18.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "CustDetailsViewController.h"

@interface CustDetailsViewController ()

@end

@implementation CustDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSString * labelStr = [self.agsGraphic attributeAsStringForKey:@"Msg"];
    CGSize labelSize;
    labelSize = [labelStr sizeWithFont:[UIFont systemFontOfSize:14]
                     constrainedToSize:CGSizeMake(150, 9999)
                         lineBreakMode:UILineBreakModeWordWrap];
    
    self.msgLabel.numberOfLines = 0;//表示label可以多行显示
    
    self.msgLabel.lineBreakMode = UILineBreakModeCharacterWrap;//换行模式，与上面的计算保持一致。
    
    self.msgLabel.frame = CGRectMake(self.msgLabel.frame.origin.x, self.msgLabel.frame.origin.y, self.msgLabel.frame.size.width, labelSize.height);//保持原来Label的位置和宽度，只是改变高度。
    
    self.msgLabel.text = labelStr;
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnTomap:(id)sender {
    [self.delegate custDetailsViewControllerReturn:self];
}
@end
