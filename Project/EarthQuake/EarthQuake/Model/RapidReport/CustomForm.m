//
//  CustomForm.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-21.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "CustomForm.h"

@implementation CustomForm

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CustomForm" owner:self options: nil];
        if(arrayOfViews.count < 1){return nil;}
        self = [arrayOfViews objectAtIndex:0];
        
        CGRect r1 = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.frame = r1;
        
        self.startLatText.delegate = self;
        self.startLonText.delegate = self;
        self.endLatText.delegate = self;
        self.endLonText.delegate = self;
        self.mStartText.delegate = self;
        self.mEndText.delegate = self;
        
        [self.saveBut defaultStyle];
        [self.addProBut defaultStyle];
        [self.cutProBut defaultStyle];
        

        self.configData = [[NSConfigData alloc]init];
        self.userDic = [self.configData getUserDic];
        
        self.customInfoSoap = [[CustomInfoSoap alloc]init];
        self.customInfoSoap.delegate = self;
        [self.customInfoSoap GetInfoCus:[self.userDic objectForKey:@"Userid"] infoType:@"CzCataLogEx"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    }
    return self;
}
-(void)customInfoSoapDidReturn:(CustomRecordSoap *) p_loginSoap cusData:(NSDictionary *) p_cusData{

    if (p_cusData.count>0) {
        NSDictionary *cusInfo = [(NSArray *)p_cusData objectAtIndex:0];
        self.infoId = [[cusInfo objectForKey:@"Id"] stringValue];
        self.proLabel.text = [cusInfo objectForKey:@"Province"];
        self.startLatText.text = [NSString stringWithFormat:@"%.3f",[[cusInfo objectForKey:@"Miny"] doubleValue]];
        self.startLonText.text = [NSString stringWithFormat:@"%.3f",[[cusInfo objectForKey:@"Minx"] doubleValue]];
        self.endLatText.text = [NSString stringWithFormat:@"%.3f",[[cusInfo objectForKey:@"Maxy"] doubleValue]];
        self.endLonText.text = [NSString stringWithFormat:@"%.3f",[[cusInfo objectForKey:@"Maxx"] doubleValue]];
        self.mStartText.text = [NSString stringWithFormat:@"%.2f",[[cusInfo objectForKey:@"Msmall"] doubleValue]];
        self.mEndText.text = [NSString stringWithFormat:@"%.2f",[[cusInfo objectForKey:@"Mlarge"] doubleValue]];
        
        NSDictionary *cusSer = [cusInfo objectForKey:@"TabCustomsers"];
        if (cusSer.count>0) {
            for (int i=0; i<cusSer.count; i++) {
                if ([[[(NSArray *)cusSer objectAtIndex:i] objectForKey:@"Field"] isEqualToString:@"SMS"]) {
                    [self.smsBtn setSelected:TRUE];
                }else if([[[(NSArray *)cusSer objectAtIndex:i] objectForKey:@"Field"] isEqualToString:@"EMAIL"]){
                    [self.emailBtn setSelected:TRUE];
                }
            }
        }
    }
}
-(void)cusInfoSetSoapDidReturn:(CusInfoSetSoap *) p_cusSoap cusData:(NSDictionary *) p_cusData{

}

-(void) dealloc{
        [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void) keyboardDidShow:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    CGRect statusBarFrame = [[UIApplication sharedApplication]statusBarFrame];
    
    self.statusBarHeight = statusBarFrame.size.height;
    self.keyboardY = keyboardFrame.origin.y-100;
    
    if (self.currentTextField!=nil) {
        
        float textFieldTop = self.currentTextField.frame.origin.y;
        float textFieldBottom = textFieldTop +self.currentTextField.frame.size.height;
        
        if (textFieldBottom>self.keyboardY) {
            [(UIScrollView *)self.scrollView setContentOffset:CGPointMake(0, textFieldBottom-self.keyboardY+self.statusBarHeight+50)animated:YES];
        }
        
        if (self.doneInKeyboardButton.superview) {
            [self.doneInKeyboardButton removeFromSuperview];
        }
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField{
    self.currentTextField = textField;
    
    float textFieldTop = self.currentTextField.frame.origin.y;
    float textFieldBottom = textFieldTop + self.currentTextField.frame.size.height;
    
    if ((textFieldBottom>self.keyboardY)&&(self.keyboardY!=0.0)) {
        [self.scrollView setContentOffset:CGPointMake(0, textFieldBottom-self.keyboardY +self.statusBarHeight+50)animated:YES];
    }
}


-(void)keyboardDidHide:(NSNotification *)notification{
    //如果doneInKeyboardButton按钮出现在屏幕上，将其从视图中移除
    if (self.doneInKeyboardButton.superview) {
        [self.doneInKeyboardButton removeFromSuperview];
    }
    
    [(UIScrollView *)self.scrollView setContentOffset:CGPointMake(0, 0)animated:YES];
}


- (IBAction)addProButAct:(id)sender {
    [self.delegate customFormAddPro:self];
}

- (IBAction)cutBoundButAct:(id)sender {
    [self.delegate customFormAddCut:self];
}

- (IBAction)saveButAct:(id)sender {
    self.cusInfoSetSoap = [[CusInfoSetSoap alloc]init];
    self.cusInfoSetSoap.delegate = self;
    
    NSString *smsState;
    NSString *emailState;
    if (self.smsBtn.selected) {
        smsState = @"true";
    }else{
        smsState = @"false";
    }
    if (self.emailBtn.selected) {
        emailState = @"true";
    }else{
        emailState = @"false";
    }
    [self.cusInfoSetSoap SetInfoCus:(NSString *) self.infoId
                             userId:(NSString *) [self.userDic objectForKey:@"Userid"]
                               type:(NSString *) @"CzCataLogEx"
                               maxx:(NSString *) self.endLonText.text
                               maxy:(NSString *) self.endLatText.text
                               minx:(NSString *) self.startLonText.text
                               miny:(NSString *) self.startLatText.text
                             mSmall:(NSString *) self.mStartText.text
                             mLarge:(NSString *) self.mEndText.text
                          conserStr:(NSString *) [smsState stringByAppendingFormat:@",%@",emailState]
                           province:(NSString *) self.proLabel.text];
}

- (IBAction)emailButAct:(id)sender {
    if (self.emailBtn.isSelected) {
        [self.emailBtn setSelected:FALSE];
    }else{
        [self.emailBtn setSelected:TRUE];
    }
}

- (IBAction)smsButAct:(id)sender {
    if (self.smsBtn.isSelected) {
        [self.smsBtn setSelected:FALSE];
    }else{
        [self.smsBtn setSelected:TRUE];
    }
}
@end
