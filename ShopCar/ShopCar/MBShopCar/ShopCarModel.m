//
//  ShopCarModel.m
//  MobileBusiness
//
//  Created by SINOKJ on 16/5/20.
//  Copyright © 2016年 中嘉信诺. All rights reserved.
//

#import "ShopCarModel.h"

@implementation ShopCarModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"productList" : @"ShopCarDetailModel"
             };
}

@end
