//
//  CarCell.m
//  MobileBusiness
//
//  Created by 中嘉信诺 on 15/12/7.
//  Copyright © 2015年 中嘉信诺. All rights reserved.
//

#import "ShopCarCell.h"
#import "UIViewExt.h"


@interface ShopCarCell ()
@property (nonatomic,strong) UIButton *checkBtn;

@property (nonatomic,strong) UIImageView *shopImageView;

@property (nonatomic,strong) UILabel *shopNameLab;

@property (nonatomic,strong) UILabel *nowpriceLab;

@property (nonatomic,strong) UILabel *shopTypeLab;//商品类型

@property (strong, nonatomic) UIButton *jianBtn;
@property (strong, nonatomic) UIButton *addBtn;
@property (strong, nonatomic) UITextField *numberLab;

@end
@implementation ShopCarCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    self.checkBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.checkBtn.frame = CGRectMake(10, (100-20)/2.0, 20, 20);
    [self.checkBtn setImage:[UIImage imageNamed:@"check_n"] forState:(UIControlStateNormal)];
    [self.checkBtn setImage:[UIImage imageNamed:@"check_p"] forState:(UIControlStateSelected)];
    [self.checkBtn addTarget:self action:@selector(checkBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.checkBtn];
    
    self.shopImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.checkBtn.right+5,20, 60, 60)];
    self.shopImageView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.shopImageView];
    
    self.shopNameLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopImageView.right+10,self.shopImageView.top-10,[UIScreen mainScreen].bounds.size.width-self.shopImageView.right-20, 40)];
    self.shopNameLab.text = @"合生元金装3段1-3岁s阿基哦打击哦是激动啊jojo啊四季豆家啊送到家就是多菩萨将打破啊时间";
    self.shopNameLab.numberOfLines = 0;
    self.shopNameLab.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.shopNameLab];
    
    self.shopTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopNameLab.left,self.shopNameLab.bottom,self.shopNameLab.width, 20)];
    self.shopTypeLab.text = @"通用型号";
    self.shopTypeLab.textColor = [UIColor darkGrayColor];
    self.shopTypeLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.shopTypeLab];
    
    self.nowpriceLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopTypeLab.left, self.shopTypeLab.bottom, 100, 20)];
    self.nowpriceLab.textColor = [UIColor redColor];
    self.nowpriceLab.text = @"￥123.00";
    self.nowpriceLab.textAlignment = NSTextAlignmentLeft;
    self.nowpriceLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.nowpriceLab];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(self.nowpriceLab.right+5, _nowpriceLab.top-2, 93, 22)];
    view.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:view];
    
    self.jianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.jianBtn.frame = CGRectMake(0,0, 26, 22);
    [self.jianBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.jianBtn.tag = 1001;
    [self.jianBtn setImage:[UIImage imageNamed:@"edit_remove"] forState:UIControlStateNormal];
    
    [view addSubview:self.jianBtn];
    
    
    self.numberLab = [[UITextField alloc]initWithFrame:CGRectMake(self.jianBtn.right, 0, 50, 22)];
    self.numberLab.borderStyle = UITextBorderStyleRoundedRect;
    self.numberLab.textAlignment = NSTextAlignmentCenter;
    self.numberLab.textColor = [UIColor darkGrayColor];
    self.numberLab.font = [UIFont systemFontOfSize:12];
    [view addSubview:self.numberLab];
    
    
    
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(self.numberLab.right,self.jianBtn.top, 26, 22);
    self.addBtn.tag = 1002;
    [self.addBtn setImage:[UIImage imageNamed:@"edit_add"] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.addBtn];
    
}

- (void)setShopCarM:(ShopCarDetailModel *)shopCarM {
//    if (_shopCarM != shopCarM) {
        _shopCarM = nil;
        _shopCarM = shopCarM;
        
//        [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:shopCarM.picture] placeholderImage:nil];
        self.shopNameLab.text = self.shopCarM.name;
        if (shopCarM.specSize == nil || [shopCarM.specSize isEqualToString:@""] ||shopCarM.specColor == nil || [shopCarM.specColor isEqualToString:@""]) {
            self.shopTypeLab.text = @"";
        }else {
            self.shopTypeLab.text = [NSString stringWithFormat:@"颜色:%@    尺寸:%@",shopCarM.specColor,shopCarM.specSize];
        }
        self.nowpriceLab.text = [NSString stringWithFormat:@"￥%@元",shopCarM.nowPrice];
        NSLog(@"%ld",shopCarM.buyCount);
        self.numberLab.text = [NSString stringWithFormat:@"%ld",shopCarM.buyCount];
//    }
}
- (void)deleteBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(btnClick:andFlag:)]) {
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    }
}
- (void)setIsCheck:(BOOL)isCheck {
    self.checkBtn.selected = isCheck;
}
- (BOOL)isCheck {
    return self.checkBtn.selected;
}
- (void)addBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(btnClick:andFlag:)]) {
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    }
}

- (void)checkBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(btnClick:andBool:)]) {
        float money = [self.shopCarM.nowPrice floatValue]*[self.numberLab.text integerValue];
        [self.delegate btnClick:money andBool:sender.selected];
    }
}
@end
