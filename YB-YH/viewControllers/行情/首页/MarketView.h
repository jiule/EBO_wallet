//
//  MarketView.h
//  YB-YH
//
//  Created by Apple on 2018/6/14.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketView : UIView

// style == 1 买入 style = 2 卖出
-(instancetype)initWithFrame:(CGRect)frame style:(int)style;

-(void)setTextnum:(int)num;
//获取ebo
-(NSString *)readNum;
//获取eth
-(NSString *)readNumeth;

-(int)readStyle;

@property(nonatomic,assign)float bili;

@property(nonatomic,assign)float rmbBili;

@property(nonatomic,assign)id<JNBaseViewDelegate>delegate;

@property(nonatomic,assign)int max;
@end
