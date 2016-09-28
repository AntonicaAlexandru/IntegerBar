//
//  HttpRequest.h
//  IntegerBar
//
//  Created by Vlad Nussem on 20/04/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface HttpRequest : NSObject
+ (instancetype)instance;
- (void) postWithURL : (NSString *)url andParams : (NSDictionary *)params authorization : (NSString *) authorizationToken callback : (NSString *)callback delegate : (id)delegate;
- (void) getWithURL : (NSString *)url andParams : (NSDictionary *)params authorization : (NSString *) authorizationToken callback : (NSString *)callback delegate : (id)delegate;
- (AFHTTPSessionManager *)prepareHTTPRequest : (NSString *) authorizationToken;
- (void) onHttpRequestSuccesess : (NSDictionary *) responseObject callback : (NSString *)callback delegate : (id)delegate;
@end
