//
//  ValidateContentCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/22.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ValidateSchoolController.h"

@interface ValidateContentCell : UITableViewCell<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *pictureBtn;

@property (nonatomic, strong) ValidateSchoolController * delegate;



@end
