//
//  JNCoinView.h
//  YB-YH
//
//  Created by Apple on 2018/7/9.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface JNCoinView : UIView

@property(nonnull,assign)id <JNBaseViewDelegate>delegate;

@property(nonatomic,retain)UILabel * titleLabel;

@property(nonatomic,retain)UIImageView * imageView;

@end
NS_ASSUME_NONNULL_END
