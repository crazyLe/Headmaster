//
//  LessonCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "LessonCell.h"

@implementation LessonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lessonContent.text = @"很多车主对自己的爱车都是关怀备至，甚至达到爱的程度，当然不能忽视";
}
- (IBAction)zanClick:(UIButton *)sender {
//    sender.selected = YES;
}

-(void)setModel:(ArticleModel *)model
{
    _model = model;
    
    [_leftmainImg sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"placeHeader"]];
    
    _lessonTitle.text = model.articleTitle;
    
    _lessonContent.text = model.articleContent;
    
    _seeNum.text = model.articleView;
    
    _goodNum.text = model.articleLike;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
