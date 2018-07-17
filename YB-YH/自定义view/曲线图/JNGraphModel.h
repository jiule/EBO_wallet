//
//  JNGraphModel.h
//  YB-YH
//
//  Created by Apple on 2018/6/25.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNGraphModel : NSObject

//绘画区域的点  计算过后的点
@property(nonatomic,assign)CGSize size;

// 点击 点 显示的文字
@property(nonatomic,copy)NSString * text;

// 文字的显示方式  默认 0 : 
@property(nonatomic,assign)int style;

@end
