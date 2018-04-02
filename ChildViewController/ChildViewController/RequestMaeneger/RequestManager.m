//
//  RequestManager.m
//  Request
//
//  Created by Davit on 3/11/18.
//  Copyright © 2018 DavitYeghoyan. All rights reserved.
//

#import "RequestManager.h"

@interface RequestManager ()

@property (nonatomic) NSURLSession * urlSession;

@end



@implementation RequestManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlSession = [NSURLSession sharedSession];
    }
    return self;
}



- (void)searchMusicWithTerm:(NSString *)searchTerm
                withSuccess:(SuccessBlock)success
                withFailure:(FailureBlock)failure {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:searchTerm]
                                                              cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.f];
    
    NSURLSessionDataTask *datatask = [self.urlSession dataTaskWithRequest:urlRequest
                                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                if (error && failure) {
                                                                    failure(error);
                                                                } else {
                                                                    NSError *jsonError = nil;
                                                                    NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                                 options:NSJSONReadingMutableContainers
                                                                                                                                   error:&jsonError];
                                                                    if (jsonError && failure) {
                                                                        failure(jsonError);
                                                                    } else if (success) {
                                                                        success(responseData);
                                                                    }
                                                                }
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                                                });
                                                            });
                                                        }];
    [datatask resume];
    
}

@end
