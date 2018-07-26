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
    self.backgroundColor = COLOR_WHITE;
//    self.bgImageView = JnImageView(CGRectMake(JN_HH(15), JN_HH(10), SCREEN_WIDTH - JN_HH(30), SCREEN_WIDTH * 0.8 - JN_HH(15)), MYimageNamed(@" "));
//    JNViewStyle(self.bgImageView, JN_HH(10), nil, 0);
//    [self addSubview:self.bgImageView];
//
//    UIImage * image = [UIImage makeImageWithView:JnUIView(CGRectMake(JNVIEW_X0, JN_HH(10), JN_HH(60), JN_HH(60)), [[UIColor blackColor]colorWithAlphaComponent:0.5])withSize:CGSizeMake(self.bgImageView.width, self.bgImageView.height * 0.3)];
//    [self.bgImageView addSubview:JnImageView(CGRectMake(0, self.bgImageView.height * 0.7, self.bgImageView.width, self.bgImageView.height * 0.3), image) ];

     self.hearImageView = JnImageView(CGRectMake(JN_HH(15), JN_HH(10), JN_HH(60), JN_HH(60)), MYimageNamed(@"xb_grh"));
    JNViewStyle(self.hearImageView, JN_HH(5), nil, 0);
    [self addSubview:self.hearImageView];

    self.titleLabel = JnLabelType(CGRectMake(JN_HH(85) , JN_HH(10), SCREEN_WIDTH - JN_HH(100), JN_HH(30)),UILABEL_2, @"",  0);
    [self addSubview:self.titleLabel];
    [self addSubview:JnLabelType(CGRectMake(JN_HH(85), JN_HH(40), SCREEN_WIDTH - JN_HH(100), JN_HH(30)), UILABEL_4,@"游戏评分:",  0)];

    _pentagramView = [[PentagramView alloc]initWithFrame:CGRectMake(JN_HH(150),  JN_HH(45), JN_HH(100), JN_HH(30))];
    [self addSubview:_pentagramView];

    _downBtn = JnButtonTextType(CGRectMake(SCREEN_WIDTH - JN_HH(60), JN_HH(40), JN_HH(50), JN_HH(30)), @"获取", 0, self, @selector(btnClick));
    JNViewStyle(_downBtn, _downBtn.height * 0.5, nil, 0);
    [self addSubview:_downBtn];
}

-(void)setTableViewModel:(DwTableViewModel *)tableViewModel
{
    [super setTableViewModel:tableViewModel];
    _gameModel = (GameModel *)tableViewModel;
    [self.bgImageView setimage:nil withurl:_gameModel.icon];
    [self.hearImageView setimage:nil withurl:_gameModel.icon];
    self.titleLabel.text = _gameModel.name;
//    NSLog(@"%d",[_gameModel.score intValue]);
    [_pentagramView showScore:[_gameModel.score floatValue]/10.00];
//    _pentagramView.backgroundColor = [UIColor redColor];
    [self createcell_h:JN_HH(80) BgColor:COLOR_B6 xian_h:1];
}

-(void)btnClick
{
    if ([self.delegate respondsToSelector:@selector(didsel:btn:model:)]) {
        [self.delegate didsel:self btn:_downBtn model:_gameModel];
    }
}

@end
