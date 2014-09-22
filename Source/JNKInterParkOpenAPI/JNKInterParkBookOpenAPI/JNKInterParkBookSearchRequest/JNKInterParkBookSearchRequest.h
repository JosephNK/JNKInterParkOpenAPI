//
//  JNKInterParkBookSearchRequest.h
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

#import <Foundation/Foundation.h>

@class JNKInterParkBookSearchRequest;
typedef id   (^JNKInterParkBookSearchRequestParserHandler) (JNKInterParkBookSearchRequest *request, NSData *responseData);
typedef void (^JNKInterParkBookSearchRequestSuccessHandler)(JNKInterParkBookSearchRequest *request, id items);
typedef void (^JNKInterParkBookSearchRequestErrorHandler)  (JNKInterParkBookSearchRequest *request, NSError *error);

@interface JNKInterParkBookSearchRequest : NSObject

@property (nonatomic) id queryObj;

- (void)requestBookSearchAPI:(id)queryitem
                     parsing:(JNKInterParkBookSearchRequestParserHandler)parser
                     success:(JNKInterParkBookSearchRequestSuccessHandler)success
                     failure:(JNKInterParkBookSearchRequestErrorHandler)failure;

- (void)requestBookSearchAPI:(id)queryitem
                       TITLE:(NSString *)title
                     parsing:(JNKInterParkBookSearchRequestParserHandler)parser
                     success:(JNKInterParkBookSearchRequestSuccessHandler)success
                     failure:(JNKInterParkBookSearchRequestErrorHandler)failure;

- (void)requestBookSearchAPI:(id)queryitem
                        ISBN:(NSString *)isbn
                     parsing:(JNKInterParkBookSearchRequestParserHandler)parser
                     success:(JNKInterParkBookSearchRequestSuccessHandler)success
                     failure:(JNKInterParkBookSearchRequestErrorHandler)failure;

@end
