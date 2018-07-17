//
//  JNCoinTriangleView.h
//  YB-YH
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNCoinTriangleView : UIView

-(instancetype)initWithFrame:(CGRect)frame  selTitle:(NSString *)title type:(int)type;

@property(nonatomic,assign)id<JNBaseViewDelegate>delegate;

@end
