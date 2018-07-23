//
//  BaseDDView.h
//  YB-YH
//
//  Created by Apple on 2018/7/23.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN
@interface BaseDDView : BaseView

-(instancetype)initWithLeftName:(nullable NSString *)leftName title:(NSString * )title;

-(instancetype)initWithLeftName:(nullable NSString *)leftName title:(NSString *)title rightImageName:(BOOL)rightImageName;

-(instancetype)initWithLeftName:(nullable NSString *)leftName title:(NSString *)title rightName:(nullable NSString *)rightName;

@end
NS_ASSUME_NONNULL_END
