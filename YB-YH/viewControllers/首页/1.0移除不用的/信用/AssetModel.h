//
//  AssetModel.h
//  YB-YH
//
//  Created by Apple on 2018/6/20.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseModel.h"

@interface AssetModel : BaseModel

@property(nonatomic,copy)NSString * title;

@property(nonatomic,copy)NSString * imageUrl;

@property(nonatomic,copy)NSString * num;

@end


@interface AssetGaojiModel : BaseModel

@property(nonatomic,copy)NSString * imageUrl;

@property(nonatomic,copy)NSString * title;

@property(nonatomic,copy)NSString * num;

@property(nonatomic,retain)NSNumber * selNum;

@end
