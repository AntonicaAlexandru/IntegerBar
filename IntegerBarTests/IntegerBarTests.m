//
//  IntegerBarTests.m
//  IntegerBarTests
//
//  Created by Mihai Honceriu on 21/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AFNetworking/AFNetworking.h>


@interface IntegerBarTests : XCTestCase

@end

@implementation IntegerBarTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    /*
    {
        "provider": "email",
        "user": {
            "phone": "0723456789",
            "firstname": "john",
            "lastname": "doe",
            "email": "john@doe.org",
            "password": "newpassword123"
        }
    }
    */
     
    //NSLog(@"Testaaaaaaaaaaaa");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://polls.apiblueprint.org/api/v1/accounts" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
