//
//  RollSaomaViewController.h
//  YB-YH
//
//  Created by Apple on 2018/6/21.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>



@class RollSaomaViewController;

@protocol RollSaomaViewControllerDelegate <NSObject>

@optional
-(void)RollSaomaViewController:(RollSaomaViewController *)vc stringValue:(NSString *)stringValue;

@end

@interface RollSaomaViewController : BaseViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession * session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;

@property(nonatomic,assign)id <RollSaomaViewControllerDelegate>delegate;
@end
