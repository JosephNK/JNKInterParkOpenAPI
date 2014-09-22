//
//  JNKInterParkBookSearchQuery.m
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

#import "JNKInterParkBookSearchQuery.h"
#import "JNKMacro.h"
#import "NSString+JNKInterParkURLEncode.h"

@implementation JNKInterParkBookSearchQuery

- (void)dealloc
{
    LLog(@"<dealloc> JNKInterParkBookSearchQuery");
    
    if (_key)
        JNK_RELEASE(_key); _key = nil;
    if (_query)
        JNK_RELEASE(_query); _query = nil;
    if (_queryType)
        JNK_RELEASE(_queryType); _queryType = nil;
    if (_searchTarget)
        JNK_RELEASE(_searchTarget); _searchTarget = nil;
    if (_sort)
        JNK_RELEASE(_sort); _sort = nil;
    if (_output)
        JNK_RELEASE(_output); _output = nil;
    if (_inputEncoding)
        JNK_RELEASE(_inputEncoding); _inputEncoding = nil;
    if (_adultImageExposure)
        JNK_RELEASE(_adultImageExposure); _adultImageExposure = nil;
    if (_soldOut)
        JNK_RELEASE(_soldOut); _soldOut = nil;
    
    JNK_SUPER_DEALLOC();
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _key = InterParkOpenAPIKey;
        _query = nil;
        _queryType = @"title";
        _searchTarget = @"book";
        _start = 1;
        _maxResults = 10;
        _sort = @"accuracy";
        //_categoryId = 100;
        _categoryId = 0;
        _output = @"xml";
        _inputEncoding = @"utf-8";
        _adultImageExposure = @"n";
        _soldOut = @"y";
    }
    return self;
}

#pragma mark -
#pragma mark Make URL Method

- (NSString *)getURLRequestBase {
    return [NSString stringWithFormat:@"%@?key=%@", InterParkAPIBookSearchUrl, _key];
}

- (NSURL *)getURLRequestSearchBase {
    NSMutableString *strRequestURL = [NSMutableString stringWithString:[self getURLRequestBase]];
    
    if (_query) {
        [strRequestURL appendFormat:@"&query=%@",
         [NSString URLEncodeWithUnEncodedString:_query withEncoding:NSUTF8StringEncoding]];
    }
    
    //NSString *escaped = [strRequestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return JNK_AUTORELEASE([[NSURL alloc] initWithString:strRequestURL]);
}

- (NSURL *)getURLRequestSearchDetail {
    NSMutableString *strRequestURL = [NSMutableString stringWithString:[self getURLRequestBase]];
    
    if (_query) {
        [strRequestURL appendFormat:@"&query=%@",
         [NSString URLEncodeWithUnEncodedString:_query withEncoding:NSUTF8StringEncoding]];
    }
    if (_queryType) {
        [strRequestURL appendFormat:@"&queryType=%@", _queryType];
    }
    if (_searchTarget) {
        [strRequestURL appendFormat:@"&searchTarget=%@", _searchTarget];
    }
    if (_start) {
        [strRequestURL appendFormat:@"&start=%ld", (long)_start];
    }
    if (_maxResults) {
        [strRequestURL appendFormat:@"&_maxResults=%ld", (long)_maxResults];
    }
    if (_sort) {
        [strRequestURL appendFormat:@"&sort=%@", _sort];
    }
    if (_categoryId) {
        [strRequestURL appendFormat:@"&categoryId=%ld", (long)_categoryId];
    }
    if (_output) {
        [strRequestURL appendFormat:@"&output=%@", _output];
    }
    if (_inputEncoding) {
        [strRequestURL appendFormat:@"&inputEncoding=%@", _inputEncoding];
    }
    if (_adultImageExposure) {
        [strRequestURL appendFormat:@"&adultImageExposure=%@", _adultImageExposure];
    }
    if (_soldOut) {
        [strRequestURL appendFormat:@"&soldOut=%@", _soldOut];
    }
    
    //NSString *escaped = [strRequestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return JNK_AUTORELEASE([[NSURL alloc] initWithString:strRequestURL]);
}

#pragma mark -
#pragma mark Helper Method

- (BOOL)checkSumDefaultParam {
    if (_key == nil || [_key isEqualToString:@""]) {
        NSAssert(NO, @"Key 필수값");
    }
    
    if (_query == nil || [_query isEqualToString:@""]) {
        NSAssert(NO, @"Query 필수값");
    }
    
    if (!(_start >= 1)) {
        NSAssert(NO, @"Start : 1이상");
    }
    
    if (!(_maxResults >= 1 && _maxResults <= 100)) {
        NSAssert(NO, @"MaxResults : 기본값 1, 최대값 : 100");
    }
    
    return YES;
}


@end
