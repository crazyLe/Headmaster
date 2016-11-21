//
//  ClasstypeCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "ClasstypeCell.h"

@implementation ClasstypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(TinyClassesModel *)model
{
    _model = model;
    
    _showmsg.text = [NSString stringWithFormat:@"%@ %@ %@元 ",model.className,model.classCar,model.classMoney];
}

- (IBAction)deleteCurClass:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(classtypeCell:didClickDeleteBtnModel:)]) {
        [self.delegate classtypeCell:self didClickDeleteBtnModel:_model];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
