//
//  MarketSlidingView.h
//  YB-YH
//
//  Created by Apple on 2018/6/14.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarketSlidingView;

typedef void (^MarketSliding)(float index);

@interface MarketSlidingView : UIScrollView

+(MarketSlidingView *)showWithFrame:(CGRect)frame index:(float)index sliding:(MarketSliding)sliding;

-(void)setIndex:(float)index;

@end
