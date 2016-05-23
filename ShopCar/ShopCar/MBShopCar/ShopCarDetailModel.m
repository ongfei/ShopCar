//
//  ShopCarDetailModel.m
//  MobileBusiness
//
//  Created by SINOKJ on 16/5/20.
//  Copyright © 2016年 中嘉信诺. All rights reserved.
//

#import "ShopCarDetailModel.h"
#import "MJExtension.h"

@implementation ShopCarDetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"specColor":@"buySpecInfo.specColor",
             @"specSize":@"buySpecInfo.specSize",
             @"productId":@"id",
             @"buySpecId":@"buySpecInfo.id"
             };
}
@end
