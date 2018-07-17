//
//  DatePickerView.h
//  Q-Lady
//
//  Created by Apple on 17/1/4.
//  Copyright © 2017年 Q-Lady. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatePickerView ;

typedef void (^selPickView)(DatePickerView * DatePickerView,int year,int month,int day);

@interface DatePickerView : UIView

-(void)showWithSelPickView:(selPickView)PickView;

@end
