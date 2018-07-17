//
//  RealnameView.h
//  YB-YH
//
//  Created by Apple on 2018/6/13.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RealnameButton : UIButton

-(instancetype)initWithFrame:(CGRect)frame image:(NSString *)imageName selImage:(NSString *)selimageName title:(NSString *)title  describe:(NSString *)describe;

//默认style == 0  ，  实名认证 style = 1
-(void)setStyle:(int)style;
// style = 1 这个方法才有用
-(void)setText:(NSString *)text;

@end
