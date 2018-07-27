//
//  GameJNViewController.m
//  YB-YH
//
//  Created by Apple on 2018/7/2.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "GameJNViewController.h"
#import "DwTableView.h"
#import "GameModel.h"
#import "GameViewCell.h"
#import "ShufflingView.h"

#import "ETHManager.h"

@interface GameJNViewController ()<DwTableViewDelegate,DwTableViewCellDelegate>
{
    BOOL _isDown;
    ShufflingView * _ffilingView;   //轮播图
    NSArray * _ffilingArrays;
    UIScrollView * _upScrollView;   //新游推荐
    NSArray * _upScrollViewArrays;
}


@property(nonatomic,retain)DwTableView * tableView;

@end

@implementation GameJNViewController

-(void)createNavView
{
    [super createNavView];
    [self.navView setStyle:1];
    [self.navView.fanhuiImageView setImage:MYimageNamed(@"hq_dingdan")];
}

-(void)Initialize
{
    [super Initialize ];
    _isDown = YES ;
}

-(void)createView
{
    [super createView];

    _tableView = [DwTableView initWithFrame:CGRectMake(0, self.nav_h, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h -Tabbar_49h()) url:URL(@"/portal/Slide/newGames") modelName:@"GameModel" cellName:@"GameViewCell" delegate:self];
//    _tableView.is_data = YES;
//    _tableView.data1 = @"data";
    [self.view addSubview:[_tableView readTableView]];

    UIView * upView = JnUIView(CGRectMake(0, 0, SCREEN_WIDTH, JN_HH(200)), COLOR_WHITE);

    _ffilingView = [[ShufflingView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, JN_HH(360) / SCREEN_WIDTH * JN_HH(130)) BgColor:COLOR_WHITE];
    [upView addSubview:_ffilingView];
    float h = _ffilingView.height;
    [upView addSubview:JnLabelType(CGRectMake(JNVIEW_X0, h, SCREEN_WIDTH, JN_HH(40)), UILABEL_1, @"新游推荐", 0)];

    h += JN_HH(40);

    _upScrollView = JnScrollView(CGRectMake(0, h, SCREEN_WIDTH , SCREEN_WIDTH * 0.25 + JN_HH(40)), COLOR_WHITE);
    [upView addSubview:_upScrollView];

    h += SCREEN_WIDTH * 0.25 + JN_HH(50);
    [upView addUnderscoreWihtFrame:CGRectMake(0, h, SCREEN_WIDTH, 1)];
    [upView addSubview:JnLabelType(CGRectMake(JNVIEW_X0, h, SCREEN_WIDTH, JN_HH(40)), UILABEL_1, @"全部游戏", 0)];
    h += JN_HH(40);
    [upView setH:h];
    [_tableView setTableViewHearView:upView];
}

-(void)downData
{
    [self tableViewDownWithPage:1];
    [self postdownDatas:@"/portal/Slide/gameSlideList" withdict:@{} index:-1];  //获取轮播
    [self postdownDatas:@"/portal/Slide/newGames" withdict:@{@"page":@"1",@"num":@"8",@"orderby":@"name"} index: -2];
}

-(void)tableViewDownWithPage:(int)page
{
    if (page > 1 && _isDown == NO) {
        return;
    }
    [_tableView downWithdict:@{@"page":[NSString stringWithFormat:@"%d",page],@"num":@"10",@"orderby":@"timedesc"} index:page];
}

-(void)clickonReturn
{
    [self popControllerwithstr:@"GameMyViewController" title:@"账户记录"];
}

#pragma mark-----tableview 点击


-(void)didsel:(DwTableViewCell *)Mycell btn:(UIButton *)btn model:(DwTableViewModel *)MyModel
{
    GameModel * ganmeModel = (GameModel *)MyModel;
    NSLog(@"%@----%@",ganmeModel.ios,ganmeModel.game_id);
}

-(void)DwtableView:(DwTableView *)tableView downDatasWithDict:(NSDictionary *)dict index:(int)index
{
    NSDictionary * dataDict = dict[@"data"];
//    NSString * flag = dataDict[@"flag"];
//    if ([flag intValue] ==  1) {
//        _isDown = YES;
//    }else {
//        _isDown = NO;
//    }
}

-(void)DwtableView:(DwTableView *)tableview refresh:(int)page
{
    [self tableViewDownWithPage:page];
}

-(void)readDowndatawithArray:(NSArray *)dataArray index:(int)index
{
    if (index == -1) {
      NSLog(@"dataArray  -1 ===== %@",dataArray); 
        NSMutableArray * ffilingArray = [NSMutableArray array];
        for (int  i =  0 ; i < dataArray.count; i++) {
            NSDictionary * dict = dataArray[i];
            GameffilingModel * ganmeModel = [[GameffilingModel alloc]initWithDict:dict];
            [ffilingArray addObject:ganmeModel.slide_pic];
        }

        if (ffilingArray.count < 3) {
            for (int i = 0 ; i < dataArray.count; i++    ) {
                NSDictionary * dict = dataArray[i];
                GameffilingModel * ganmeModel = [[GameffilingModel alloc]initWithDict:dict];
                [ffilingArray addObject:ganmeModel.slide_pic];
            }
        }
        if (ffilingArray.count < 3) {
            for (int i = 0 ; i < dataArray.count; i++    ) {
                NSDictionary * dict = dataArray[i];
                GameffilingModel * ganmeModel = [[GameffilingModel alloc]initWithDict:dict];
                [ffilingArray addObject:ganmeModel.slide_pic];
            }
        }
        _ffilingArrays = [NSArray arrayWithArray:ffilingArray];
        [_ffilingView showWithImageUrlPaths:ffilingArray didShuffling:^(ShufflingView *shufflingView, int index) {

        }];
    }else if(index == -2)
    {
        NSLog(@"dataArray =====  -2 %@",dataArray);
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0 ; i < dataArray.count; i++) {
            GameModel * model = [[GameModel alloc]initWithDict:dataArray[i]];
            [array addObject:model];
        }
        _upScrollViewArrays = [NSArray arrayWithArray:array];
        [self loadScrollView];
    }
}

-(void)loadScrollView
{
    for (UIView * view in _upScrollView.subviews) {
        [view removeFromSuperview];
    }
    float w = _upScrollView.width / 4;
    float h = _upScrollView.height;
    for (int i = 0 ; i < _upScrollViewArrays.count; i++) {
        UIButton * btn = JnButton_tag(CGRectMake(w * i, 0, w, h), COLOR_WHITE, self, @selector(BtnClick:), 100 + i);
        [_upScrollView addSubview:btn];
        GameModel * model = _upScrollViewArrays[i];
        UIImageView * imageView = JnImageView(CGRectMake(JN_HH(10), JN_HH(10), w - JN_HH(20), w - JN_HH(20)), nil);
        JNViewStyle(imageView, 5, nil, 0);
        [UIImage removeimageWithURL:model.image_url];
        [imageView setimage:nil withurl:model.image_url];
        UILabel * label = JnLabel(CGRectMake(JN_HH(10), w , w - JN_HH(20), JN_HH(20)), model.name, JN_HH(10), COLOR_BL_2, 0);
        if ([model.name widthOfFont:label.font height:label.height] > label.width) {
            [label adjusts];
        }
        [btn addSubview:label];
        [btn addSubview:JnLabel(CGRectMake(JN_HH(10), w + JN_HH(20), w - JN_HH(20), JN_HH(20)), model.category_name, JN_HH(11.5), COLOR_A1, 0)];
        [btn addSubview:imageView];
    }
    _upScrollView.contentSize = CGSizeMake(w * _upScrollViewArrays.count, 1);
}

-(void)BtnClick:(UIButton *)btn
{
    [MYAlertController showTitltle:@"功能暂未开放"];
}

-(void)DwtableView:(DwTableView *)tableView model:(DwTableViewModel *)myTableViewModel indexPath:(NSIndexPath *)indexPath
{
     [MYAlertController showTitltle:@"功能暂未开放"];
}
@end
