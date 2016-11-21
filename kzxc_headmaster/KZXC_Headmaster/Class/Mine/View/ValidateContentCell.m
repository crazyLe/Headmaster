//
//  ValidateContentCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/22.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "ValidateContentCell.h"

@implementation ValidateContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_pictureBtn addTarget:self action:@selector(uploadImage) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
- (void)uploadImage {
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选取",@"拍照", nil];
    [actionSheet showInView:self];
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        //从相册选取
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [_delegate presentViewController:imagePicker animated:YES completion:nil];
    }
    if (buttonIndex == 1) {
        //拍照
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [_delegate presentViewController:imagePicker animated:YES completion:nil];
    }
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [_pictureBtn setImage:image forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
