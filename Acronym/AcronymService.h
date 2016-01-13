//
//  AcronymService.h
//  Acronym
//
//  Created by Camille Kander on 1/12/16.
//  Copyright © 2016 xzoky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcronymService : NSObject

+ (instancetype)sharedService;

- (void)getMatchesForAcronym:(NSString *)acronym success:(void (^)(NSString *acronym, NSArray *matches))success failure:(void (^)(NSError *error))failure;

@end
