//
//  MITYPE.h
//  duwen
//
//  Created by Apple on 17/4/7.
//  Copyright © 2017年 duwen. All rights reserved.
//

#ifndef MITYPE_h
#define MITYPE_h

//#import "MIHelpr.h"
//#import "MIPickerView.h"
//#import "MIPickerimage.h"

#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)

// view的弹出方式  
typedef enum : NSUInteger
{
    MIView_Up ,      //从下往上  默认样式
    MIView_Right,    //从右往左
    MIView_DOWN,     //从上往下
    MIView_Left,     //从左到右
    MIView_Normal,   //无
}MIView_TYPE;



#endif /* MITYPE_h */
