//
//  MIPickerView.h
//  duwen
//
//  Created by Apple on 17/4/7.
//  Copyright © 2017年 duwen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MIPickerimage.h"
#import "MITYPE.h"
#import "MIHelpr.h"


@interface MIPickerView : UIView
//初始化
+(instancetype)showWithType:(MIView_TYPE)type MIPickerimage:(selectPickerImage)MIPickerimage timer:(float)timer;
//初始化
+(instancetype)showWithType:(MIView_TYPE)type MIPickerimage:(selectPickerImage)MIPickerimage;
//初始化
-(instancetype)initWithType:(MIView_TYPE)type MIPickerimage:(selectPickerImage)MIPickerimage timer:(float)timer;



@end
