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

#import "ETHManager.h"

@interface GameJNViewController ()<DwTableViewDelegate,DwTableViewCellDelegate>
{
    BOOL _isDown;
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

    _tableView = [DwTableView initWithFrame:CGRectMake(0, self.nav_h, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h -Tabbar_49h()) url:@"http://waiguamobi.com/index.php?s=/Api/Game/game_list" modelName:@"GameModel" cellName:@"GameViewCell" delegate:self];
    _tableView.is_data = YES;
    _tableView.data1 = @"data";
    [self.view addSubview:[_tableView readTableView]];
}

-(void)downData
{
    [self tableViewDownWithPage:1];

}

-(void)tableViewDownWithPage:(int)page
{
    if (page > 1 && _isDown == NO) {
        return;
    }
    [_tableView downWithdict:@{@"page":[NSString stringWithFormat:@"%d",page]} index:page];
}

-(void)clickonReturn
{
    [self popControllerwithstr:@"GameMyViewController" title:@"账户记录"];
}

#pragma mark-----tableview 点击
-(void)DwtableView:(DwTableView *)tableView model:(DwTableViewModel *)myTableViewModel indexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",[MyUserDefaultsManager JNobjectForKey:@"ADDRESS"]);
    NSLog(@"%@",[MyUserDefaultsManager JNobjectForKey:@"ADDRESSSS"]);

    return ;
    [ETHManager createAccountPassword:@"123456" responseCallback:^(id responseData) {
        NSString * res = [NSString stringWithFormat:@"%@",responseData];
        NSDictionary * dict  = [res dictionaryWithJson];
          NSLog(@"address------%@",dict);
        [ETHManager createKeyWithPassword:@"123456" account:responseData responseCallback:^(id responseData1)
        {
             [MyUserDefaultsManager setJNObject:responseData1 forkey:@"ADDRESSSS"];
        }];

        [MyUserDefaultsManager setJNObject:responseData forkey:@"ADDRESS"]; //保存地址
        
        NSString * species = [CurrencyManager readspeciesWithName:BI_A1];
         NSLog(@"species------%@",species);
        if (species) {
            [self postdownDatas:@"/transfer/wallet/bindAddress" withdict:@{@"address":dict[@"address"],@"coin_species":species} index:1];
        }
    
    }];
    GameModel * ganmeModel = (GameModel *)myTableViewModel;
    NSLog(@"%@----%@------11111",ganmeModel.ios,ganmeModel.game_id);
}

-(void)didsel:(DwTableViewCell *)Mycell btn:(UIButton *)btn model:(DwTableViewModel *)MyModel
{
    GameModel * ganmeModel = (GameModel *)MyModel;
    NSLog(@"%@----%@",ganmeModel.ios,ganmeModel.game_id);
}

-(void)DwtableView:(DwTableView *)tableView downDatasWithDict:(NSDictionary *)dict index:(int)index
{
    NSDictionary * dataDict = dict[@"data"];
    NSString * flag = dataDict[@"flag"];
    NSLog(@"dataDict=====%@",dataDict);
    if ([flag intValue] ==  1) {
        _isDown = YES;
    }else {
        _isDown = NO;
    }
}

-(void)DwtableView:(DwTableView *)tableview refresh:(int)page
{
    [self tableViewDownWithPage:page];
}

-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 1) {
        [[CurrencyManager sharedInstance]Initialize];
    }
}



@end
