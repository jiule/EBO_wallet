//
//  GongGeView.h
//  JNTest
//
//  Created by Apple on 2018/4/13.
//  Copyright © 2018年 YHCS. All rights reserved.
//

/*
 * 默认图片的高度 跟label的高度比 为 3:1
 * BASEVIEW_LABEL_TYPE  默认 textLabel的样式 默认 UILABEL_0
 */

#define GongGeView_LABEL_TYPE UILABEL_2

#import <UIKit/UIKit.h>

@interface GongGeView : UIView
/*
 * 图片跟显示名称 不一样的
 */
-(instancetype)initWithFrame:(CGRect)frame imageArrays:(NSArray *)imageArrays textArrays:(NSArray *)textArrays  number:(int)number;
/*
 * 图片跟显示名称一样的
 */
-(instancetype)initWithFrame:(CGRect)frame imageArrays:(NSArray *)imageArrays number:(int)number;

-(instancetype)initWithFrame:(CGRect)frame imageUrlArrays:(NSArray *)imageUrlArrays textArrays:(NSArray *)textArrays  number:(int)number;
/*
 * 点击按钮的返回
 */
-(void)didBtnsuccess:(void (^)(GongGeView * view,int index))btnsuccess;

@end
