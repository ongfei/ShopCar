//
//  ShopCarCell.h
//  MobileBusiness
//
//  Created by 中嘉信诺 on 16/3/7.
//  Copyright © 2016年 中嘉信诺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarDetailModel.h"

@protocol ShopCarDelegate <NSObject>
- (void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;
//yes 代表选中
- (void)btnClick:(float)money andBool:(BOOL) b;

@end

@interface ShopCarCell : UITableViewCell
@property (nonatomic, assign) id<ShopCarDelegate>delegate;
@property (nonatomic, strong) ShopCarDetailModel *shopCarM;
@property (nonatomic, assign) BOOL isCheck;
@end
