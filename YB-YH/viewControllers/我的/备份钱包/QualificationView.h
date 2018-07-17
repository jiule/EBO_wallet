//
//  QualificationView.h
//  YB-YH
//
//  Created by Apple on 2018/7/17.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface QualificationView : UIView


@property(nonatomic,assign)id <JNBaseViewDelegate>delegate;


-(void)showWithspecies:(NSString *)species;

@end
