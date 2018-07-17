//
//  MIHelpr.m
//  duwen
//
//  Created by Apple on 17/4/7.
//  Copyright © 2017年 duwen. All rights reserved.
//

#import "MIHelpr.h"

@implementation MIHelpr

extern CGRect MIFrameWithMIType(MIView_TYPE type)
{
    CGRect frame;
    switch (type) {
        case MIView_Up: frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT); break;
        case MIView_Right: frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT); break;
        case MIView_DOWN : frame = CGRectMake(0, - SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT); break;
        case MIView_Left: frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT); break;
        case MIView_Normal: frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT); break;            
        default:
            break;
    }
    return  frame ;
}

float  MIView_timer = 0.5;
@end
