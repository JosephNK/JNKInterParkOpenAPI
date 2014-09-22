//
//  JNKInterParkBookSearchQuery.h
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
#import "JNKInterParkOpenAPIConf.h"

@interface JNKInterParkBookSearchQuery : NSObject

/**
* @brief 키
* @see 필수
* @author
**/
@property (nonatomic, strong) NSString *key;

/**
 * @brief 검색어를 입력합니다.
 * @see 상세 검색에서 각 요청 변수의 기본 값을 기준으로 검색결과를 표시합니다.
 * @author
 **/
@property (nonatomic, strong) NSString *query;

/**
 * @brief 검색어 종류에 따른 세부 설정을 합니다.
 * @see title(기본값) : 제목검색
        author : 저자검색
        publisher : 출판사검색
        isbn : Isbn검색
        productNumber : 상품번호
        all : 제목, 저자, 출판사,ISBN 검색 대상
 * @author
 **/
@property (nonatomic, strong) NSString *queryType;

/**
 * @brief 검색하고자 하는 상품 구분을 설정합니다.
 * @see book(기본값) : 국내도서
        foreign : 외국도서
        cd : 음반 / dvd
 * @author
 **/
@property (nonatomic, strong) NSString *searchTarget;

/**
 * @brief 검색 결과의 시작 페이지의 페이지 번호를 설정합니다.
 * @see 1이상, 양의 정수(기본값:1)
 * @author
 **/
@property (nonatomic)         NSInteger start;

/**
 * @brief 검색 결과의 한페이지당 최대 출력 개수를 설정합니다.
 * @see 1이상 100이하, 양의 정수(기본값:10)
 * @author
 **/
@property (nonatomic)         NSInteger maxResults;

/**
 * @brief 검색 결과의 정렬 방법을 설정합니다.
 * @see accuracy(기본값) : 정확도순
        publishTime : 출간일
        title : 제목
        salesPoint : 판매량
        customerRating : 고객평점
        reviewCount : 리뷰갯수
        price : 가격오름순
        priceDesc : 가격내림순
 * @author
 **/
@property (nonatomic, strong) NSString *sort;

/**
 * @brief 지정한 카테고리에서만 검색 되도록 설정합니다.
 * @see searchTarget를 설정 하였을 경우, searchTarget의 변수종류 하위에 속하지 않는 분야번호는 검색되지 않습니다.
        분야의 고유 번호(기본값:100 )
 * @author
 **/
@property (nonatomic)         NSInteger categoryId;

/**
 * @brief 검색 결과의 출력 방식을 설정합니다.
 * @see xml(기본값) : REST XML형식
        json : JSON방식
 * @author
 **/
@property (nonatomic, strong) NSString *output;

/**
 * @brief 검색의의 인코팅 값을 설정합니다.
 * @see utf-8(기본값)
        euc-kr
 * @author
 **/
@property (nonatomic, getter = inputEncoding) NSString *inputEncoding;
//@property (nonatomic, strong) NSString *callback;

/**
 * @brief 성인 이미지의 노출 여부를 설정합니다.
 * @see n(기본값) : 노출안함
        y : 노출함
 * @author
 **/
@property (nonatomic, strong) NSString *adultImageExposure;

/**
 * @brief 품절/절판 상품 노출 여부를 설정합니다.
 * @see y(기본값) : 품절/절판함께보기
        n : 품절/절판빼고보기
 * @author
 **/
@property (nonatomic, strong) NSString *soldOut;

- (NSURL *)getURLRequestSearchBase;
- (NSURL *)getURLRequestSearchDetail;
- (BOOL)checkSumDefaultParam;

@end
