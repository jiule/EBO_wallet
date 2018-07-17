//
//  CandyView.h
//  YB-YH
//
//  Created by Apple on 2018/7/3.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandyView : UIView

+(void)showWithnum:(int)num  delegate:(id <JNBaseViewDelegate>)delegate;

@property(nonatomic,assign)id <JNBaseViewDelegate>delegate;
@end
