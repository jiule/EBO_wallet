//
//  ScreeningBtn.m
//  YB-YH
//
//  Created by Apple on 2018/7/9.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "ScreeningBtn.h"

@implementation ScreeningBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:COLOR_BL_2 forState:0];
        [self setTitleColor:COLOR_WHITE forState:UIControlStateSelected];
        [self setSelected:NO];
        return self;
    }
    return nil;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        JNViewStyle(self, self.height * 0.5, COLOR_A1, 1);
        self.backgroundColor = COLOR_A1;
    }else {
         JNViewStyle(self, self.height * 0.5, COLOR_BL_3, 1);
         self.backgroundColor = COLOR_WHITE;
    }
}

@end
