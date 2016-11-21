//
//  DrivingTypeCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/15.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "DrivingTypeCell.h"

@implementation DrivingTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (IBAction)cancel:(id)sender {
    self.cancle(sender);
}
- (IBAction)sure:(id)sender {
    
    if (0 == _DrivingClassName.text.length) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入班型名称" hideAfterDelay:1.0];
        return;
    }
    if (0 == _lastFirIndex) {
        [self.hudManager showErrorSVHudWithTitle:@"请选择车型" hideAfterDelay:1.0];
        return;
    }
    if (0 == _DrivingPrice.text.length) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入学车价格" hideAfterDelay:1.0];
        return;
    }
    if (0 == _lastSecIndex && _OtherDrivingTime.text.length == 0) {
        [self.hudManager showErrorSVHudWithTitle:@"请选择学车时间" hideAfterDelay:1.0];
        return;
    }
    
    self.succeed(self);
}
- (IBAction)DrivingClassNameClick:(UIButton *)sender {
    
    NSInteger index = sender.tag;
    
    if (0 != _lastFirIndex) {
        
        UIButton *btn = [self viewWithTag:_lastFirIndex];
        btn.selected = NO;
    }
    sender.selected = YES;
    _lastFirIndex = (int)index;
    
    if (sender == self.C1) {
        _C2.selected = NO;
    }
    
    if (sender == self.C2) {
        _C1.selected = NO;
    }
}

- (IBAction)TimeClick:(UIButton *)sender {
    
    NSInteger index = sender.tag;
    
    if (0 != _lastSecIndex) {
        
        UIButton *btn = [self viewWithTag:_lastSecIndex];
        
        btn.selected = NO;
    }
    
    sender.selected = YES;
    
    _lastSecIndex = (int)index;
    
}

- (IBAction)LearnPriceClick:(id)sender {
//    self.update(sender);
}
- (IBAction)OtherTimeClick:(id)sender {
//    self.update(sender);
    _lastSecIndex = 0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
     self.update(textField);

    if (203 == textField.tag)
    {
        _timeBtn1.selected = NO;
        _timeBtn2.selected = NO;
        _timeBtn3.selected = NO;
        _timeBtn4.selected = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.reset();
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)deleteClass:(UIButton *)sender {
    
    self.deleteself();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
