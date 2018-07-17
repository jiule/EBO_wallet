//
//  MyNetworkingManager.h
//  Q-Lady
//
//  Created by Apple on 17/2/7.
//  Copyright © 2017年 Q-Lady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "EncryptionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyNetworkingManager : NSObject

XMGSingletoH

// post request
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(nullable id )parameters
                      progress:(nullable void (^)(NSProgress * _Nonnull ))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                withparameters:(nullable nullable id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                withparameters:(nullable nullable id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure type:(Encryption_TYPE)type;

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                withparameters:(nullable nullable id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure type:(Encryption_TYPE)type;
// up image
+(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(nullable id )parameters image:(UIImage *)image  progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure type:(NSString *)type;
+(NSURLSessionDataTask *)POSTImages:(NSString *)URLString parameters:(nullable id)parameters image:(NSArray *)images  progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+(nullable id)dispatchUrl:(NSString *)url  HTTPBody:(NSString *)Body;

NS_ASSUME_NONNULL_END
@end
