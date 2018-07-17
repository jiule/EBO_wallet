//
//  MyDataView.h
//  i-qlady
//
//  Created by Apple on 17/4/21.
//  Copyright © 2017年 i-qlady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerView.h"

@class MyDataView;

@protocol MyDataViewDelegate <NSObject>

@optional

-(void)didDataView:(MyDataView *)dataView wanchengBtn:(UIButton *)btn;
@end

@interface MyDataView : UIView

@property(nonatomic,assign)id <MyDataViewDelegate>delegate;

-(void)showWithSelTimePickView:(selPickView)selPickerView;

@end
