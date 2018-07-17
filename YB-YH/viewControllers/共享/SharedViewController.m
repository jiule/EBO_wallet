//
//  SharedViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/4.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "SharedViewController.h"
#import "ETHManager.h"

@interface SharedViewController ()

@end

@implementation SharedViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [ETHManager createAccountPassword:@"123456" responseCallback:^(id responseData) {
        NSLog(@"address======%@",responseData);
        [ETHManager createKeyWithPassword:@"123456" account:responseData responseCallback:^(id responseData) {
            NSLog(@"key====%@",responseData);
       NSDictionary * dict =  @{@"from":@"0xa983b670e3bce5aaf2ebc6643c8bca245c167cec",
                @"to":@"0x7854C8a4DbC0AB7E639626db2db11A4bD7D59D9E",
                @"value": @"0x8AC7230489E80000",
                @"nonce": @(115),
                @"gas" : @"0x76c0",
                @"gasPrice": @"0x9184e72a000"
                                    };
            [ETHManager createSignWithKey:responseData data:dict responseCallback:^(id responseData) {
                NSLog(@"sign=====%@",responseData);
            }];
        }];

    }];


    return ;
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    //不设置会报-1016或者会有编码问题
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    //不设置会报 error 3840
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    //创建你得请求url、设置请求头
//    NSString *urlString = [NSString stringWithFormat:@"http://10.3.12.185:8183/api/v1/mancong"];
//
//    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:@{@"username":@"1539538970"} error:nil];
//    [request addValue:@"kkkk" forHTTPHeaderField:@"Token"];
//    [request addValue:@"iphone" forHTTPHeaderField:@"Device-Type"];
  //  NSData *body = 你需要提交的data;
  //  [request setHTTPBody:body];


    //发起请求

//    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        NSLog(@"error %@",error);
//        if (!error) {
//
//            NSLog(@"Reply JSON: %@", responseObject);
//
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//
//                //处理你的数据
//
//            }
//
//        } else {
//
//            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
//            id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"%@----%@",responseDict,responseDict[@"msg"]);
//        }

//    }] resume];

//    return;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"Device-Type"];
//    [manager.requestSerializer setValue:@"kkkk" forHTTPHeaderField:@"Token"];

//    [manager GET:@"http://192.168.8.203/api/user/VerificationCode/read" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",responseDict);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];

    [manager POST:@"http://10.3.12.185:8182/api/Registered" parameters:@{@"account":@"1234",@"password":@"1232321"} progress:^(NSProgress * _Nonnull uploadProgress)
    {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);

        id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",responseDict);
        NSDictionary * dict = responseDict[@"data"];
        NSLog(@"dict === %@",dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
//
//    return;
//    [manager POST:@"http://192.168.8.203/api/user/VerificationCode/read" parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//       NSLog(@"%@",responseDict);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
}



@end
