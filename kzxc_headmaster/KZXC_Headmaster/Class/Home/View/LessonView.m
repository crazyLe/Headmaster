//
//  LessonView.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "LessonView.h"
#import "UIColor+Hex.h"


@interface LessonView (){
    
    CGFloat _btnW;
    UIView *_line;
    NSInteger _lastTag;
}

@end

@implementation LessonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        
    }
    return self;
}


- (void)LessonViewWithTitleArrays:(NSArray *)titleArray
{
    _btnW = kWidth/titleArray.count;
    
    // 创建滑块
    UIView *line = [[UIView alloc]init];
    line.frame = CGRectMake(0, self.height - 2 , _btnW, 2);
        line.backgroundColor = [UIColor colorWithHexString:@"#ff6866"];
    [self addSubview:line];
    _line = line;
    
    for (int i = 0; i < titleArray.count; i++) {
        
        CGRect btnRect = CGRectMake(_btnW * i, 0, _btnW, 48);
        
        UIButton *btn = [[UIButton alloc]initWithFrame:btnRect];
        
        btn.tag = 100 + i;
        
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithHexString:@"#c8c8c8"] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithHexString:@"#ff6a69"] forState:UIControlStateSelected];
        
        if (0 == i) {
            btn.selected = YES;
        }
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
        [self addSubview:btn];
        
    }

}

- (void)updateLesssonViewStatueWithTag:(NSInteger)tag
{
    if (tag >= 100) {
        UIButton *lastBtn = (id)[self viewWithTag:_lastTag];
        lastBtn.selected = NO;
    }
    UIButton *curBtn = [self viewWithTag:tag];
    curBtn.selected = YES;
    
    CGFloat lineX = (tag - 100) * _btnW;
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _line.frame;
        frame.origin.x = lineX;
        _line.frame = frame;
    }];
    
     _lastTag = curBtn.tag;
    
    if ([_delegate respondsToSelector:@selector(lessonViewWithIndex:title:)]) {
        [_delegate lessonViewWithIndex:(curBtn.tag-100) title:curBtn.titleLabel.text];
    }
}
// 点击事件
- (void)click:(UIButton *)btn{
    
    [self endEditing:YES];
    
    NSInteger index = btn.tag;
    if (0 == _lastTag) {
        UIButton *lastBtn = (id)[self viewWithTag:100];
        lastBtn.selected = NO;
    }
    
    if (_lastTag >= 100) {
        UIButton *lastBtn = (id)[self viewWithTag:_lastTag];
        lastBtn.selected = NO;
    }
    btn.selected = YES;
    
    CGFloat lineX = (index - 100) * _btnW;
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _line.frame;
        frame.origin.x = lineX;
        _line.frame = frame;
    }];
    
    _lastTag = btn.tag;
//
    if ([_delegate respondsToSelector:@selector(lessonViewWithIndex:title:)]) {
        [_delegate lessonViewWithIndex:(btn.tag-100) title:btn.titleLabel.text];
    }
//
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self endEditing:YES];
}
@end
