//
//  InvitingCardVC.m
//  YB-YH
//
//  Created by admin on 2018/7/27.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "InvitingCardVC.h"

@interface InvitingCardVC ()

@end

@implementation InvitingCardVC

-(void)createNavView{}
-(void)createView{
    [self.view addSubview:JnImageView(self.view.bounds, MYimageNamed(@"yaoqingtu"))];
    [self.view addSubview:JnButtonImageTag(CGRectMake(10, CGNavView_20h(), 44, 44), MYimageNamed(@"back1"), self, @selector(clickonReturn), 0)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
