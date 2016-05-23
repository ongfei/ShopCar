//
//  ShopCarModel.h
//  MobileBusiness
//
//  Created by dyf on 16/5/20.
//  Copyright © 2016年 dyf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCarDetailModel.h"

@interface ShopCarModel : NSObject
@property (nonatomic, strong) NSMutableArray<ShopCarDetailModel *> *productList;
@end
