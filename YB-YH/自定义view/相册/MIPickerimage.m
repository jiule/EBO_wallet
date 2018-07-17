//
//  MIPickerimage.m
//  duwen
//
//  Created by Apple on 17/4/7.
//  Copyright © 2017年 duwen. All rights reserved.
//

#import "MIPickerimage.h"

@implementation MIPickerimage

XMGSingletoM

-(void)PickerpushWithscurceType:(UIImagePickerControllerSourceType)sourceType MIPickerimage:(selectPickerImage )MIPickerimage
{
    [self PickerpushWithscurceType:sourceType MIPickerimage:MIPickerimage controller:[UIViewController getCurrentVC]];
}

-(void)PickerpushWithscurceType:(UIImagePickerControllerSourceType)sourceType MIPickerimage:(selectPickerImage)MIPickerimage controller:(UIViewController *)viewController
{
    if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        if (![Permissions isCanUsePhotos]) {
            return ;
        }
    }else if(sourceType == UIImagePickerControllerSourceTypeCamera){
        if (![Permissions isCanUseCamera] || ![Permissions isCameraAvailable]) {
            return ;
        }
    }else if(sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum){
        if (![Permissions isCanUsePhotos] ) {
            return ;
        }
    }
    self.MIPickerimage = MIPickerimage;
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    [viewController presentViewController:imagePickerController animated:YES completion:^{

    }];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
      UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
    }else {
        __weak typeof(self) wself = self;
        if (wself.MIPickerimage) {
            wself.MIPickerimage(image);
        }
    }
   
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error) {
     //   DLog(@"保存失败");
    }else{
      //  DLog(@"保存成功");
        __weak typeof(self) wself = self;
        if (wself.MIPickerimage) {
            wself.MIPickerimage(image);
        }
    }
}
@end
