//
//  ShopCarModel.m
//  MobileBusiness
//
//  Created by dyf on 16/5/20.
//  Copyright © 2016年 dyf. All rights reserved.
//

#import "ShopCarModel.h"

@implementation ShopCarModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"productList" : @"ShopCarDetailModel"
             };
}

@end
