//
//  JNKInterParkTBXMLParser.m
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

#import "JNKInterParkTBXMLParser.h"
#import "JNKMacro.h"
#import "TBXML.h"

NSString *const InterParkOpenAPIParserErrorDomain = @"com.error.InterParkOpenAPI-TBXMLParser";

@implementation JNKInterParkTBXMLParser

- (void)dealloc
{
    JNK_SUPER_DEALLOC();
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (NSDictionary *)pasingFromBookSearchData:(NSData *)data
{
    NSMutableDictionary *dicData = [NSMutableDictionary new];
    
    TBXML *sourceXML = [[TBXML alloc] initWithXMLData:data error:nil];
    TBXMLElement *rootElement = sourceXML.rootXMLElement;
    NSString *rootString = [TBXML elementName:rootElement];
    LLog(@"ROOT: %@", rootString);
    
    TBXMLElement *returnCodeElement = [TBXML childElementNamed:@"returnCode" parentElement:rootElement];
    NSString *returnCodeElementString = [TBXML textForElement:returnCodeElement];
    
    if (![returnCodeElementString isEqualToString:@"000"]) {
        TBXMLElement *messageElement = [TBXML childElementNamed:@"returnMessage" parentElement:rootElement];
        NSString *messageElementString = [TBXML textForElement:messageElement];
        TBXMLElement *errorCodeElement = [TBXML childElementNamed:@"returnCode" parentElement:rootElement];
        NSString *errorCodeElementString = [TBXML textForElement:errorCodeElement];
        
        NSError *error = [self errorWithStatus:[errorCodeElementString intValue] Reason:messageElementString];
        
        [dicData setObject:error forKey:@"Error"];
        [dicData setObject:[NSNull null] forKey:@"Items"];
    }else {
        
        TBXMLElement *itemElement = [TBXML childElementNamed:@"item" parentElement:rootElement];
        
        NSMutableArray *items = [NSMutableArray new];
        
        if (itemElement) {
            do
            {
                NSArray *keys = @[@"itemId", @"title", @"description", @"pubDate", @"priceStandard",
                                  @"priceSales", @"discountRate", @"saleStatus", @"mileage", @"mileageRate",
                                  @"coverSmallUrl", @"coverLargeUrl", @"categoryId", @"categoryName",
                                  @"publisher", @"customerReviewRank", @"reviewCount", @"author",
                                  @"isbn", @"link", @"mobileLink", @"additionalLink"];
                NSDictionary *dicItem = [self getDictParsingFromXML:keys parentElement:itemElement];
                [items addObject:dicItem];
                
            } while ((itemElement = itemElement->nextSibling));
        }
        
        [dicData setObject:[NSNull null] forKey:@"Error"];
        [dicData setObject:items forKey:@"Items"];
    }
    
    return dicData;
}

#pragma mark -
#pragma mark Helper

+ (NSDictionary *)getDictParsingFromXML:(NSArray *)keys parentElement:(TBXMLElement*)aParentXMLElement {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    for (NSString *key in keys) {
        TBXMLElement *element = [TBXML childElementNamed:key parentElement:aParentXMLElement];
        NSString *elementString = [TBXML textForElement:element];
        [dict setObject:elementString forKey:key];
    }
    
    return dict;
}

#pragma mark -
#pragma mark Error Method

+ (NSError *)errorWithStatus:(int)errorCode Reason:(NSString *)reasonMessage {
    NSString * description = nil, * reason = nil;
    
    description = NSLocalizedString(@"ResponseData Error", @"Error description");
    reason = NSLocalizedString(reasonMessage, @"Error reason");
    
    NSMutableDictionary * userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject: description forKey: NSLocalizedDescriptionKey];
    
    if (reason != nil) {
        [userInfo setObject: reason forKey: NSLocalizedFailureReasonErrorKey];
    }
    
    return [NSError errorWithDomain:InterParkOpenAPIParserErrorDomain
                               code:errorCode
                           userInfo:userInfo];
    
}

@end
