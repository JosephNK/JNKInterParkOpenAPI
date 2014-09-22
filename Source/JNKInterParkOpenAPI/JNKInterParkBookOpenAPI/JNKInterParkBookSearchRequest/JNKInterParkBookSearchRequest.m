//
//  JNKInterParkBookSearchRequest.m
//
//  Copyright (c) 2014-2014 JNKInterParkOpenAPI
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "JNKInterParkBookSearchRequest.h"
#import "JNKAsyncURLConnection.h"
#import "JNKMacro.h"
#import "JNKInterParkBookSearchQuery.h"

#define QUERYTYPE @"QueryType"
#define QUERY @"Query"

@interface JNKInterParkBookSearchRequest()
{
    NSURL *_requestURL;
}
@property (nonatomic, copy) JNKInterParkBookSearchRequestParserHandler parserHandler;
@property (nonatomic, copy) JNKInterParkBookSearchRequestSuccessHandler successHandler;
@property (nonatomic, copy) JNKInterParkBookSearchRequestErrorHandler errorHandler;
@end

@implementation JNKInterParkBookSearchRequest

- (void)dealloc
{
    if (_successHandler)
        JNK_BLOCK_RELEASE(_successHandler); _successHandler = nil;
    if (_errorHandler)
        JNK_BLOCK_RELEASE(_errorHandler); _errorHandler = nil;
    
    JNK_SUPER_DEALLOC();
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark -
#pragma mark Request

- (void)requestBookSearchAPI:(id)queryitem
                     parsing:(JNKInterParkBookSearchRequestParserHandler)parser
                     success:(JNKInterParkBookSearchRequestSuccessHandler)success
                     failure:(JNKInterParkBookSearchRequestErrorHandler)failure
{
    if (_queryObj) {
        queryitem = _queryObj;
    }
    _requestURL = [self getURLRequestSearchOpenAPI:queryitem InputData:nil];
    
    if (_requestURL == nil) {
        NSAssert(NO, @"Request URL must not Nil");
    }
    
    _successHandler = JNK_BLOCK_COPY(success);
    _errorHandler = JNK_BLOCK_COPY(failure);
    
    [JNKAsyncURLConnection requestURL:[_requestURL absoluteString] delegate:nil
                        completeBlock:^(NSData *data) {
                            [self dispatchSuccess:data ParserBlock:parser];
                        } errorBlock:^(NSError *error) {
                            [self dispatchFailure:error];
                        }];
}

- (void)requestBookSearchAPI:(id)queryitem
                       TITLE:(NSString *)title
                     parsing:(JNKInterParkBookSearchRequestParserHandler)parser
                     success:(JNKInterParkBookSearchRequestSuccessHandler)success
                     failure:(JNKInterParkBookSearchRequestErrorHandler)failure
{
    _requestURL = [self getURLRequestSearchOpenAPI:queryitem InputData:@{QUERYTYPE : @"title", QUERY : title}];
    
    if (_requestURL == nil) {
        NSAssert(NO, @"Request URL must not Nil");
    }
    
    _successHandler = JNK_BLOCK_COPY(success);
    _errorHandler = JNK_BLOCK_COPY(failure);
    
    [JNKAsyncURLConnection requestURL:[_requestURL absoluteString] delegate:nil
                        completeBlock:^(NSData *data) {
                            [self dispatchSuccess:data ParserBlock:parser];
                        } errorBlock:^(NSError *error) {
                            [self dispatchFailure:error];
                        }];
}

- (void)requestBookSearchAPI:(id)queryitem
                        ISBN:(NSString *)isbn
                     parsing:(JNKInterParkBookSearchRequestParserHandler)parser
                     success:(JNKInterParkBookSearchRequestSuccessHandler)success
                     failure:(JNKInterParkBookSearchRequestErrorHandler)failure
{
    _requestURL = [self getURLRequestSearchOpenAPI:queryitem InputData:@{QUERYTYPE : @"isbn", QUERY : isbn}];
    
    if (_requestURL == nil) {
        NSAssert(NO, @"Request URL must not Nil");
    }
    
    _successHandler = JNK_BLOCK_COPY(success);
    _errorHandler = JNK_BLOCK_COPY(failure);
    
    [JNKAsyncURLConnection requestURL:[_requestURL absoluteString] delegate:nil
                        completeBlock:^(NSData *data) {
                            [self dispatchSuccess:data ParserBlock:parser];
                        } errorBlock:^(NSError *error) {
                            [self dispatchFailure:error];
                        }];
}

#pragma mark -
#pragma mark Helper

- (NSURL *)getURLRequestSearchOpenAPI:(id)queryItem InputData:(NSDictionary *)dict {
    
    NSURL *request = nil;
    
    if ([queryItem isKindOfClass:[JNKInterParkBookSearchQuery class]]) {
        JNKInterParkBookSearchQuery *query = (JNKInterParkBookSearchQuery *)queryItem;
        if (dict != nil) {
            NSString *qryType = [dict objectForKey:QUERYTYPE];
            NSString *qry = [dict objectForKey:QUERY];
            if ([qryType isEqualToString:@"title"]) {
                query.queryType = qryType;
                query.query = qry;
                request = [query getURLRequestSearchBase];
            }else if ([qryType isEqualToString:@"isbn"]) {
                query.queryType = qryType;
                query.query = qry;
                request = [query getURLRequestSearchDetail];
            }
        }else {
            request = [query getURLRequestSearchDetail];
        }
        [query checkSumDefaultParam];
    }
    
    return request;
}

#pragma mark -
#pragma mark Dispatch Method

- (void)dispatchSuccess:(NSData *)data ParserBlock:(JNKInterParkBookSearchRequestParserHandler)parserBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // on Background Thread
        //NSLog(@"in main thread?: %@", [NSThread isMainThread] ? @"YES" : @"NO");
        
        id pasingData = nil;
        
        if ([data length]) {
            NSString *xml = JNK_AUTORELEASE([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            LLog(@"[GET XML]\n%@", xml);
            
            if (parserBlock) {
                pasingData = parserBlock(self, data);
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // update UI on Main Thread
            if (_successHandler) {
                _successHandler(self, pasingData);
            }
        });
    });
}

- (void)dispatchFailure:(NSError *)error {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // on Background Thread
        //NSLog(@"in main thread?: %@", [NSThread isMainThread] ? @"YES" : @"NO");
        dispatch_async(dispatch_get_main_queue(), ^{
            // update UI on Main Thread
            if (_errorHandler) {
                _errorHandler(self, error);
            }
        });
    });
}

@end
