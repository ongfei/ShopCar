//
//  ShopCarDetailModel.h
//  MobileBusiness
//
//  Created by dyf on 16/5/20.
//  Copyright © 2016年 dyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarDetailModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *nowPrice;

@property (nonatomic, copy) NSString *picture;

@property (nonatomic, copy) NSString *cartId;

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, copy) NSString *specSize;

@property (nonatomic, copy) NSString *specColor;

@property (nonatomic, assign) NSInteger buyCount;

@property (nonatomic, copy) NSString *buySpecId;

@property (nonatomic, assign) NSInteger stock;

@end
