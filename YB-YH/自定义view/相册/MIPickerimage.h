//--------------------------华丽的分割线-------------------------------
//-----------------------调用系统的相机 返回图片 ------------------------
//
//
//
//
//-------------------------------------------------------------------
//这是调用系统相机返回的image block


#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


NS_ASSUME_NONNULL_BEGIN

typedef void (^selectPickerImage)(UIImage * _Nonnull image );

@interface MIPickerimage : NSObject <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
XMGSingletoH
/*
 * 根据 UIImagePickerControllerSourceType 类型 返回 selectPickerImage
 */
-(void)PickerpushWithscurceType:(UIImagePickerControllerSourceType)sourceType MIPickerimage:(selectPickerImage)MIPickerimage;

-(void)PickerpushWithscurceType:(UIImagePickerControllerSourceType)sourceType MIPickerimage:(selectPickerImage)MIPickerimage controller:(UIViewController *)viewController;

@property(nonatomic,copy)selectPickerImage  MIPickerimage;

@end

NS_ASSUME_NONNULL_END
