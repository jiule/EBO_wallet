//
//  AssetsQianView.h
//  YB-YH
//
//  Created by Apple on 2018/6/21.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>


////----------我的钱包

@interface AssetsQianView : UIView

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text imageName:(NSString *)imageName;


-(void)addLabelText:(NSString *)text;

@end

/*
 *   --------------------------------------------华丽的分割线---------------------------
 *   -------------------------------------------- 最近记录  ----------------------------
 *   --------------------------------------------华丽的分割线---------------------------
 */

@interface AssetsjiluView : UIView

-(void)showWithText:(NSString *)text timer:(NSString *)timer title:(NSString *)title;
@end
