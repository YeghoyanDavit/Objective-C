//
//  RequestManager.h
//  Request
//
//  Created by Davit on 3/11/18.
//  Copyright © 2018 DavitYeghoyan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBaseUrl @"https://developers.ria.com/auto/categories/1/marks"
#define kApiUrl @"?api_key=CSEonvpeqz8SCxPmV80HGH6xpbGeJ2gWdcnJXJf8"

typedef void(^SuccessBlock)(id response);
typedef void(^FailureBlock)(NSError *error);

@interface RequestManager : NSObject

- (void)searchMusicWithTerm:(NSString *)searchTerm
                withSuccess:(SuccessBlock)success
                withFailure:(FailureBlock)failure;

@end
