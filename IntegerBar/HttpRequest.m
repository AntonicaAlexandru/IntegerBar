//
//  HttpRequest.m
//  IntegerBar
//
//  Created by Vlad Nussem on 20/04/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "HttpRequest.h"
#import <AFNetworking/AFNetworking.h>

@implementation HttpRequest

+ (instancetype)instance
{
    static HttpRequest *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HttpRequest alloc] init];
    });
    return instance;
}

#pragma HTTP Requests
- (void) postWithURL : (NSString *)url andParams : (NSDictionary *)params authorization : (NSString *) authorizationToken callback : (NSString *)callback delegate : (id)delegate {
    AFHTTPSessionManager *manager = [self prepareHTTPRequest : authorizationToken];
    __weak typeof(delegate) weakDelegate = delegate;
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self onHttpRequestSuccesess : responseObject callback : callback delegate : weakDelegate];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
    }];
}

- (void) getWithURL : (NSString *)url andParams : (NSDictionary *)params authorization : (NSString *) authorizationToken callback : (NSString *)callback delegate : (id)delegate{
    AFHTTPSessionManager *manager = [self prepareHTTPRequest : authorizationToken];
    __weak typeof(delegate) weakDelegate = delegate;
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self onHttpRequestSuccesess : responseObject callback : callback delegate : weakDelegate];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
    }];
}

- (AFHTTPSessionManager *)prepareHTTPRequest : (NSString *) authorizationToken {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (authorizationToken) {
        [manager.requestSerializer setValue:authorizationToken forHTTPHeaderField:@"Authorization"];
    }
    
    return manager;
}

- (void) onHttpRequestSuccesess : (NSDictionary *) responseObject callback : (NSString *)callback delegate : (id) delegate {
    SEL callbackMethod = NSSelectorFromString(callback);
    if ([delegate respondsToSelector:(callbackMethod)]) {
        IMP imp = [delegate methodForSelector:callbackMethod];
        void (*func)(id, SEL, id) = (void *)imp;
        func(delegate, callbackMethod, responseObject);
    }
}

@end
