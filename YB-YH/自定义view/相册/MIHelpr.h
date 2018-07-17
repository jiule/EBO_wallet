//
//  MIHelpr.h
//  duwen
//
//  Created by Apple on 17/4/7.
//  Copyright © 2017年 duwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MITYPE.h"

@interface MIHelpr : NSObject

//根据view的弹出方式 获取view初使frame
FOUNDATION_EXPORT CGRect MIFrameWithMIType(MIView_TYPE type);

//MIView_TYPE 的弹出动画时间 默认1.5
FOUNDATION_EXPORT float  MIView_timer;
@end
