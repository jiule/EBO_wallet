//
//  BaseView.h
//  YB-YH
//
//  Created by Apple on 2018/6/12.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView

//右边图标 没有
-(instancetype)initWithFrame:(CGRect)frame leftName:(nullable NSString *)leftName title:(NSString *)title;

-(instancetype)initWithFrame:(CGRect)frame leftName:(nullable NSString *)leftName title:(NSString *)title rightImageName:(BOOL)rightImageName;

-(instancetype)initWithFrame:(CGRect)frame leftName:(nullable NSString *)leftName title:(NSString *)title rightName:(nullable NSString *)rightName;

@property(nonatomic,retain,nullable)UIButton * leftBtn;

@property(nonatomic,retain)UILabel * titleLabel;

@property(nonatomic,retain,nullable)UIButton * rightBtn;

@property(nonatomic,assign)id <JNBaseViewDelegate> delegate;

-(void)jn_setRightName:(nullable NSString *)rightName;

-(void)jn_setLeftName:(nullable NSString *)leftName;

@end
NS_ASSUME_NONNULL_END
