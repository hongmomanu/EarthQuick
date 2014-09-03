//
//  CzRuning.m
//  EarthQuake
//
//  Created by hvit-pc on 14-6-3.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "CzRuning.h"

@implementation CzRuning

- (id)initWithFrame:(CGRect)frame
{
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CzRuning" owner:self options: nil];
        if(arrayOfViews.count < 1)
        {
            self =  nil;
        }else{
            self = [arrayOfViews objectAtIndex:0];
            self = [super initWithFrame:frame];
            CGRect r1 = CGRectMake(0, 0, frame.size.width, frame.size.height);
            self.frame = r1;
            self.configData = [[NSConfigData alloc]init];
        }
    return self;
}

- (IBAction)dateChange:(id)sender {
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
            [self getCzRun:selectedValue];
        }
    };
    
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        //NSLog(@"Block Picker Canceled");
    };
    
    NSArray *colors = [NSArray arrayWithObjects:@"1个月", @"3个月", @"6个月", @"9个月",@"12个月", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"最近几个月" rows:colors initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
}

-(void)getCzRun:(NSString *)p_moths{
    //弹出等待友好界面
    _progressView = [_configData getAlert:@"加载中..."];
    [_progressView show];
    
    self.czRunSoap  = [[CzRunSoap alloc]init];
    self.czRunSoap.delegate = self;
    [self.czRunSoap getCzRun:_stationId Months:p_moths];

}

-(void)czRunSoapDidReturn:(CzRunSoap *) p_soap{
    NSArray *returnArr = (NSArray*)p_soap.returnDic;
    returnArr = [returnArr objectAtIndex:0];
    double count = [[returnArr objectAtIndex:0] integerValue];
    
    
    //友好界面隐藏
    [_configData performBlock:^{
        
        [_configData performBlock:^{
            [_progressView close];
            if (p_soap.success && count >1) {
                double sum = [[returnArr objectAtIndex:1] integerValue];
                [_configData showAlert: @"获取成功"];
                double run = sum/count;
                _runingLabel.text = [[NSString stringWithFormat:@"%.3f", run] stringByAppendingString:@"%"];
            }else{
                [_configData showAlert: @"没有数据"];
                _runingLabel.text = @"没有数据";
            }
            
        } afterDelay:1.0];
    } afterDelay:1.0];
}
@end
