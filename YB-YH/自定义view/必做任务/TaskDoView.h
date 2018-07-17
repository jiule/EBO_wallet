//
//  TaskDoView.h
//  YB-YH
//
//  Created by Apple on 2018/6/20.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseModel;

@interface TaskDoView : UIView

-(instancetype)initWithFrame:(CGRect)frame textArrays:(NSArray  <BaseModel *>*)textArrays btnClsName:(NSString *)clsNmae;

@property(nonatomic,assign)id <JNBaseViewDelegate>delegate;

-(void)showWtihTextArrays:(NSArray  <BaseModel *> *)textArrays;

-(void)startTimer;

-(void)endTimer;
@end
