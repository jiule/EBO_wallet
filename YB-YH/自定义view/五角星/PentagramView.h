//
//  PentagramView.h
//  i-qlady
//
//  Created by Apple on 2018/2/27.
//  Copyright © 2018年 i-qlady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PentagramView : UIView

//设置上面下面图片
-(void)showUpImage:(UIImage *)upImage downImage:(UIImage *)downImage;
// 0-1.....
-(void)showScore:(float)score;
//代理i
@property(nonatomic,assign)id <JNBaseViewDelegate>delegate;
//一共有几张图 默认 5个
@property(nonatomic,assign)int maxIndex;

@end
