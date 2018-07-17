//
//  ScreeningTransferView.h
//  YB-YH
//
//  Created by Apple on 2018/7/9.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ScreeningTransferView;

@protocol ScreeningTransferViewDelegate <NSObject>

@optional
-(void)didScreeningTransferView:(ScreeningTransferView *)view dict:(NSDictionary *)dict;
@end

@interface ScreeningTransferView : UIView


-(void)showWithDict:(NSDictionary *)dict;

@property(nonatomic,assign)id <ScreeningTransferViewDelegate>delegate;

@end
