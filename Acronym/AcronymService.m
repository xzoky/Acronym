//
//  AcronymService.m
//  Acronym
//
//  Created by Camille Kander on 1/12/16.
//  Copyright © 2016 xzoky. All rights reserved.
//

#import "AcronymService.h"
#import "AFNetworking/AFNetworking.h"

static NSString * const kBaseURLString = @"http://www.nactem.ac.uk/software/acromine/dictionary.py";

@interface AcronymService ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation AcronymService

+ (instancetype)sharedService {
    
    static AcronymService *sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedService = [AcronymService new];
        sharedService.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL: [NSURL URLWithString:kBaseURLString] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        sharedService.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    });
    return sharedService;
}

- (void)getMatchesForAcronym:(NSString *)acronym success:(void (^)(NSString *acronym, NSArray *matches))success failure:(void (^)(NSError *error))failure {
    
    [self.sessionManager GET:@"" parameters:@{@"sf": acronym} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSDictionary *responseDict = [(NSArray *)responseObject firstObject];
        NSString *abbreviation = responseDict[@"sf"];
        NSArray *definitions = responseDict[@"lfs"];
        
        success(abbreviation, definitions);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
