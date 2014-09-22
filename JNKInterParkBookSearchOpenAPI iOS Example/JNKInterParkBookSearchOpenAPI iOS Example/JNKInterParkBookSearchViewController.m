//
//  JNKInterParkBookSearchViewController.m
//  JNKInterParkBookSearchOpenAPI iOS Example
//
//  Created by Joseph NamKung on 2014. 9. 23..
//  Copyright (c) 2014년 JosephNK. All rights reserved.
//

#import "JNKInterParkBookSearchViewController.h"
#import "JNKInterParkBookOpenAPI.h"
#import "JNKInterParkTBXMLParser.h"
#import "UIAlertView+JNKInterParkError.h"

@implementation JNKInterParkBookSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    JNKInterParkBookSearchQuery *query = [[JNKInterParkBookSearchQuery alloc] init];
    JNKInterParkBookSearchRequest *api = [[JNKInterParkBookSearchRequest alloc] init];
    [api requestBookSearchAPI:query TITLE:@"삼국지"
                      parsing:^id(JNKInterParkBookSearchRequest *request, NSData *responseData) {
                          return [JNKInterParkTBXMLParser pasingFromBookSearchData:responseData];
                      } success:^(JNKInterParkBookSearchRequest *request, id items) {
                          NSDictionary *dic = (NSDictionary *)items;
                          NSError *dicInfoError = [dic objectForKey:@"Error"];
                          NSArray *dicInfoArr = [dic objectForKey:@"Items"];
                          if (dicInfoError != (NSError *)[NSNull null]) {
                              [UIAlertView showAlertError:dicInfoError];
                          }
                          if (dicInfoArr != (NSArray *)[NSNull null]) {
                              NSLog(@"success %@", [dicInfoArr description]);
                          }
                      } failure:^(JNKInterParkBookSearchRequest *request, NSError *error) {
                          NSLog(@"failure error %@", [error description]);
                      }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
