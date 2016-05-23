//
//  ShopCarModel.h
//  MobileBusiness
//
//  Created by SINOKJ on 16/5/20.
//  Copyright © 2016年 中嘉信诺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCarDetailModel.h"

@interface ShopCarModel : NSObject
@property (nonatomic, strong) NSMutableArray<ShopCarDetailModel *> *productList;
@end
