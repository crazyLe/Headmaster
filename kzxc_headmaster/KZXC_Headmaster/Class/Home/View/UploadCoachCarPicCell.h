//
//  UploadCoachCarPicCell.h
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/15.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    
    UploadCoachCarPicCellLeftBtn = 0,
    UploadCoachCarPicCellMiddleBtn,
    UploadCoachCarPicCellRightBtn,
    
    
    
}UploadCoachCarPicCellBtnType;

@protocol UploadCoachCarPicCellDelegate <NSObject>

- (void)UploadCoachCarPicCellDidClickBtnWithBtnType:(UploadCoachCarPicCellBtnType)btnType withBtn:(UIButton *)btn;


@end



@interface UploadCoachCarPicCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *leftImgBtn;
@property (weak, nonatomic) IBOutlet UIButton *middleImgBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightImgBtn;

@property (nonatomic, weak) id<UploadCoachCarPicCellDelegate>delegate;
@end
