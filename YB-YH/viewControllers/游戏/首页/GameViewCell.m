//
//  GameViewCell.m
//  YB-YH
//
//  Created by Apple on 2018/7/5.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "GameViewCell.h"
#import "GameModel.h"
#import "PentagramView.h"

@interface GameViewCell()
{
    GameModel * _gameModel;
}

@property(nonatomic,retain)UIImageView * bgImageView;

@property(nonatomic,retain)UIImageView * hearImageView;

@property(nonatomic,retain)UILabel * titleLabel;

@property(nonatomic,retain)UIButton * downBtn;

@property(nonatomic,retain)PentagramView * pentagramView;

@end


@implementation GameViewCell

-(void)createCell
{
    self.backgroundColor = COLOR_B6;
    self.bgImageView = JnImageView(CGRectMake(JN_HH(15), JN_HH(10), SCREEN_WIDTH - JN_HH(30), SCREEN_WIDTH * 0.8 - JN_HH(15)), MYimageNamed(@" "));
    JNViewStyle(self.bgImageView, JN_HH(10), nil, 0);
    [self addSubview:self.bgImageView];

    UIImage * image = [UIImage makeImageWithView:JnUIView(CGRectMake(0, 0, self.bgImageView.width, self.bgImageView.height * 0.3), [[UIColor blackColor]colorWithAlphaComponent:0.5])withSize:CGSizeMake(self.bgImageView.width, self.bgImageView.height * 0.3)];
    [self.bgImageView addSubview:JnImageView(CGRectMake(0, self.bgImageView.height * 0.7, self.bgImageView.width, self.bgImageView.height * 0.3), image) ];

     self.hearImageView = JnImageView(CGRectMake(JN_HH(15), JN_HH(15) + self.bgImageView.height * 0.7, self.bgImageView.height * 0.3 - JN_HH(30), self.bgImageView.height * 0.3 - JN_HH(30)), MYimageNamed(@"xb_grh"));
    JNViewStyle(self.hearImageView, JN_HH(5), nil, 0);
    [self.bgImageView addSubview:self.hearImageView];

    self.titleLabel = JnLabel(CGRectMake(self.bgImageView.height * 0.3 , self.bgImageView.height * 0.75, SCREEN_WIDTH - self.bgImageView.height * 0.3, self.bgImageView.height * 0.1), @"xb_grh", JN_HH(16.5), COLOR_WHITE, 0);
    [self.bgImageView addSubview:self.titleLabel];
    [self.bgImageView addSubview:JnLabel(CGRectMake(self.bgImageView.height * 0.3 , self.bgImageView.height * 0.85, SCREEN_WIDTH - self.bgImageView.height * 0.3, self.bgImageView.height * 0.1), @"游戏评分:", JN_HH(12.5), COLOR_WHITE, 0)];

    _pentagramView = [[PentagramView alloc]initWithFrame:CGRectMake(self.bgImageView.height * 0.3 + JN_HH(60),  self.bgImageView.height * 0.85 + JN_HH(3), JN_HH(100), self.bgImageView.height * 0.1)];
    [self.bgImageView addSubview:_pentagramView];

    _downBtn = JnButtonTextType(CGRectMake(self.bgImageView.width - JN_HH(60), self.bgImageView.height * 0.8, JN_HH(50), self.bgImageView.height * 0.1), @"下载", 0, self, @selector(btnClick));
    JNViewStyle(_downBtn, self.bgImageView.height * 0.05, nil, 0);
    [self.bgImageView addSubview:_downBtn];
}



-(void)setTableViewModel:(DwTableViewModel *)tableViewModel
{
    [super setTableViewModel:tableViewModel];
    _gameModel = (GameModel *)tableViewModel;
    [self.bgImageView setimage:nil withurl:_gameModel.icon];
    [self.hearImageView setimage:nil withurl:_gameModel.icon];
    self.titleLabel.text = _gameModel.name;
    [_pentagramView showScore:[_gameModel.score floatValue]/10.00];
    [self createcell_h:SCREEN_WIDTH * 0.8 BgColor:COLOR_B6 xian_h:1];
}

-(void)btnClick
{
    if ([self.delegate respondsToSelector:@selector(didsel:btn:model:)]) {
        [self.delegate didsel:self btn:_downBtn model:_gameModel];
    }
}

@end
