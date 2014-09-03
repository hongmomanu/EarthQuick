//
//  QzRuning.m
//  EarthQuake
//
//  Created by hvit-pc on 14-6-4.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "QzRuning.h"

@implementation QzRuning

- (id)initWithFrame:(CGRect)frame
{
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"QzRuning" owner:self options: nil];
        if(arrayOfViews.count < 1){return nil;}
        self = [arrayOfViews objectAtIndex:0];
        self = [super initWithFrame:frame];
        CGRect r1 = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.frame = r1;
        
        self.configData = [[NSConfigData alloc]init];
        self.dateField.delegate = self;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)getQzRunCri{
    self.qzRunCriSoap = [[QzRunCriSoap alloc]init];
    self.qzRunCriSoap.delegate = self;
    [self.qzRunCriSoap getQzRunCri:self.stationId];
}

-(void)qzRunSoapDidReturn:(QzRunSoap *) p_soap{
    NSArray *returnArr = (NSArray*)p_soap.returnDic;
    returnArr = [returnArr objectAtIndex:0];
    double count = [[returnArr objectAtIndex:0] integerValue];
    //友好界面隐藏
    [_configData performBlock:^{
        
        [_configData performBlock:^{
            [_progressView close];
            if (p_soap.success && count >1) {
                double runSum = [[returnArr objectAtIndex:1] integerValue];
                double fullSum = [[returnArr objectAtIndex:1] integerValue];
                [_configData showAlert: @"获取成功"];
                _runLabel.text = [[NSString stringWithFormat:@"%.3f", runSum/count] stringByAppendingString:@"%"];
                _fullLabel.text = [[NSString stringWithFormat:@"%.3f", fullSum/count] stringByAppendingString:@"%"];
            }else{
                [_configData showAlert: @"没有数据"];
                _runLabel.text = @"没有数据";
                _fullLabel.text = @"没有数据";
            }
        } afterDelay:1.0];
    } afterDelay:1.0];

}

-(void)qzRunCriSoapDidReturn:(QzRunCriSoap *) p_soap{
    self.itemArr = [[NSMutableArray alloc]init];
    NSArray *jsonArr = (NSArray *)p_soap.returnDic;
    for (NSInteger i = 0; i<jsonArr.count; i++) {
        NSMutableArray *t_instrArr = [[NSMutableArray alloc]init];
        for (NSInteger j=0; j<jsonArr.count; j++) {
            if([jsonArr[j][0] isEqualToString:jsonArr[i][0]]&&[jsonArr[j][1] isEqualToString:jsonArr[i][1]]){
                [t_instrArr addObject:[NSString stringWithFormat:@"(%@)%@",jsonArr[j][3],jsonArr[j][2]]];
            }
        }
        NSMutableArray *t_itemArritem = [[NSMutableArray alloc]init];
        [t_itemArritem addObject:t_instrArr];
        [t_itemArritem addObject:[NSString stringWithFormat:@"(%@)%@",jsonArr[i][1],jsonArr[i][0]]];
        
        [self.itemArr addObject:t_itemArritem];
    }
    //移除相同显示类别的
    for (NSInteger i=0; i<self.itemArr.count; i++) {
        for (NSInteger j = self.itemArr.count - 1; j > i; j--) {
            if ([self.itemArr[j][1] isEqualToString:self.itemArr[i][1]]) {
                [self.itemArr removeObjectAtIndex:j];
            }
        }
    }
    //测项分量数据
    self.itemStrArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < self.itemArr.count; i++) {
        [self.itemStrArr addObject:self.itemArr[i][1]];
    }
    self.itemField.text = self.itemStrArr[0];
    //仪器名称数据
    [self getInStrArr:self.itemField.text];
    self.instrField.text = self.inStrArr[0];
    
    //获取运行率
    [self getQzRun:self.dateField.text];
    
}

-(void)getQzRun:(NSString *)p_moths{
    //弹出等待友好界面
    _progressView = [_configData getAlert:@"加载中..."];
    [_progressView show];
    
    self.qzRunSoap = [[QzRunSoap alloc]init];
    self.qzRunSoap.delegate = self;
    
    NSString *t_itemStr = [self.configData getSubString:self.itemField.text Start:@"(" End:@")"];
    
    NSString *t_instrtStr = [self.configData getSubString:self.instrField.text Start:@"(" End:@")"];
    
    [self.qzRunSoap getQzRun:self.stationId ItemId:t_itemStr InstrtType:t_instrtStr Months:p_moths];
    
}

-(void) getInStrArr:(NSString *)p_selectItem{
    for (NSInteger i=0; i<self.itemArr.count; i++) {
        if ([self.itemArr[i][1] isEqualToString:p_selectItem] ) {
            self.inStrArr = [[NSMutableArray alloc]init];
            NSArray *t_inArr;
            t_inArr = self.itemArr[i][0];
            for (NSInteger j=0; j<t_inArr.count; j++) {
                [self.inStrArr addObject:t_inArr[0]];
            }
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

- (IBAction)itemChange:(id)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
            [self getInStrArr:selectedValue];
        }
    };
    
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
    };

    [ActionSheetStringPicker showPickerWithTitle:@"测项分量" rows:self.itemStrArr initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
}

- (IBAction)instrChange:(id)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
    };
    [ActionSheetStringPicker showPickerWithTitle:@"仪器名称" rows:self.inStrArr initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
}

- (IBAction)dateChange:(id)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
            [self getQzRun:selectedValue];
        }
    };
    
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        //NSLog(@"Block Picker Canceled");
    };
    
    NSArray *colors = [NSArray arrayWithObjects:@"1个月", @"3个月", @"6个月", @"9个月",@"12个月", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"最近几个月" rows:colors initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
}
@end
