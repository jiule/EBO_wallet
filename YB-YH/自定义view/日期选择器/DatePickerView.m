//
//  DatePickerView.m
//  Q-Lady
//
//  Created by Apple on 17/1/4.
//  Copyright © 2017年 Q-Lady. All rights reserved.
//


#define CHUSHI_YEAR 1900
#define CHUSHI_QUAN 102


#import "DatePickerView.h"

@interface DatePickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
//保存 所有 年的数组
@property(nonatomic,retain)NSArray * yearArray;
//保存 所有月的数组
@property(nonatomic,retain)NSArray * monthArray;
//保存 当前选中月的数组
@property(nonatomic,retain)NSArray * dayArray;
//  用户选中的年
@property(nonatomic,assign)int selyear;
//用户选中的月
@property(nonatomic,assign)int selmonth;
//用户选中的天
@property(nonatomic,assign)int selday;

@property(nonatomic,assign)int month_day;

//今天的日期
@property(nonatomic,retain)NSDictionary * riqiDict;

@property (nonatomic, retain) UIPickerView *pv;

@property(nonatomic,copy)selPickView selPickView;
@end


@implementation DatePickerView

-(NSArray *)yearArray
{
    if (!_yearArray) {
        NSMutableArray *  yearArray = [NSMutableArray arrayWithCapacity:10];
        for (int i = CHUSHI_YEAR; i < 2100; i++) {
            [yearArray addObject:[NSString stringWithFormat:@"%04d年",i]];
        }
        _yearArray = [NSArray arrayWithArray:yearArray];
    }
    return _yearArray;
}

-(NSArray *)monthArray
{
    if (!_monthArray) {
        NSMutableArray *  monthrArray = [NSMutableArray arrayWithCapacity:10];
        for (int j = 0; j < CHUSHI_QUAN; j++) {
            for (int i = 1; i <= 12; i++) {
                [monthrArray addObject:[NSString stringWithFormat:@"%02d月",i]];
            }
        }
        _monthArray = [NSArray arrayWithArray:monthrArray];
    }
    return _monthArray;
}

-(NSArray *)dayArray
{
    NSMutableArray * dayArray = [NSMutableArray arrayWithCapacity:10];
    _month_day = 31;
    int month = _selmonth % CHUSHI_QUAN ;
        if (month == 4 || month == 6 || month == 9 || month == 11) {
            _month_day = 30;
        }else if(month == 2){
            if ((_selyear % 4 == 0 && _selyear % 100 != 0) || (_selyear % 400 == 0)) {
                _month_day = 29;
            }else {
                _month_day = 28;
            }
        }else {
            _month_day = 31;
        }
    
    for (int j = 0; j < CHUSHI_QUAN; j++) {
        for (int i = 1; i <= _month_day; i++) {
             [dayArray addObject:[NSString stringWithFormat:@"%02d日",i]];
        }
    }
    _dayArray = [NSArray arrayWithArray:dayArray];
    return _dayArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    _riqiDict = [NSDictionary getTodayDate];
    _selyear = [_riqiDict[@"year"] intValue];
    _selmonth = [_riqiDict[@"month"] intValue];
    _selday = [_riqiDict[@"day"] intValue];
    if (self =  [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
    }
    return self ;
}

-(void)showWithSelPickView:(selPickView)PickView
{
    _selPickView = PickView;
    // 创建拾取视图
    UIPickerView *pv = [[UIPickerView alloc] init];
    //拾取视图的高度值: 162 180 216
    pv.frame = CGRectMake(10, 40, SCREEN_WIDTH , 216);
    // 设置数据源代理
    pv.dataSource = self;
    // 设置普通代理
    pv.delegate = self;
    
    pv.showsSelectionIndicator = YES ;
    [self addSubview:pv];
    self.pv = pv;
    
    [_pv selectRow: _selyear - CHUSHI_YEAR inComponent:0 animated:NO];
    
    [_pv selectRow: _selmonth + self.monthArray.count / CHUSHI_QUAN * 2 - 1 inComponent:1 animated:NO];
    [_pv selectRow: _selday + self.dayArray.count / CHUSHI_QUAN * 2 -1 inComponent:2 animated:NO];
    _selPickView(self,_selyear,_selmonth,_selday);
}

// 返回拾取视图由多少个分组(列)
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

#pragma mark - UIPickerViewDataSource协议方法
// 返回指定分组的数据的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearArray.count;
    }else if(component == 1)
    {
        return self.monthArray.count;
    }else if(component == 2)
    {
        return self.dayArray.count ;
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate 协议方法
// 返回拾取视图上，指定列，指定行的显示文字
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearArray[row];
    }else if(component == 1)
    {
        return self.monthArray[row];
        
    }else if(component == 2)
    {
        return self.dayArray[row];
    }
    return nil;
}

// 返回拾取视图中指定组的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component==0) {
        return self.bounds.size.width / 3 -20;
    }else if(component==1)
    {
        return self.bounds.size.width / 3 -20;
    }else
    {
        return self.bounds.size.width / 3 -20 ;
    }
}

// 返回拾取视图上指定分组的行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return JN_HH(34);
}

// 用户选中了拾取视图上指定列，指定行时调用的方法。
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0) {
        _selyear = (int)row + CHUSHI_YEAR ;
    }else if(component == 1)
    {
        row = self.monthArray.count / 2 + row % 12;
        [_pv selectRow: row inComponent:1 animated:NO];
        _selmonth = (int)row + 1 ;
    }else
    {
            row = self.dayArray.count / 2 + row % _month_day ;
        [_pv selectRow: row  inComponent:2 animated:NO];
        _selday = (int)row + 1;
    }
    int month = _selmonth % 12;
    if (month == 0) {
        month = 12;
    }
    int day = _selday % _month_day;
    if (day ==0) {
        day = _month_day ;
    }
    _selPickView(self,_selyear,month,day);
    [self.pv reloadAllComponents];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel  alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width / 3, JN_HH(34))];
    if (row >= 0) {
        if (component==0) {
            label.text = self.yearArray[row];
            
        }else if(component==1)
        {
            label.text = self.monthArray[row];
        }else
        {
            label.text = self.dayArray[row];
        }
    }
    label.font=[UIFont systemFontOfSize:15];
    label.textAlignment=NSTextAlignmentCenter;
    return label;
}
@end
