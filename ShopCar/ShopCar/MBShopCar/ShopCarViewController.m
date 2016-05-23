//
//  CarViewController.m
//  MobileBusiness
//
//  Created by 中嘉信诺 on 15/12/7.
//  Copyright © 2015年 中嘉信诺. All rights reserved.
//

#import "ShopCarViewController.h"
#import "UIViewExt.h"
#import "ShopCarCell.h"
#import "ShopCarModel.h"
#import "MJExtension.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ShopCarViewController ()<UITableViewDataSource,UITableViewDelegate,ShopCarDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UIButton *selectAllBtn;//全选按钮

@property (nonatomic,strong) UIButton *jieSuanBtn;//结算按钮
@property (nonatomic,strong) UILabel *totalMoneyLab;//总金额

@property(nonatomic,assign) float allPrice;

@property (nonatomic ,strong) ShopCarModel *shopCarM;
@end

@implementation ShopCarViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//   网络请求
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"a" ofType:nil]] options:(NSJSONReadingMutableContainers) error:nil];

    self.shopCarM = [ShopCarModel mj_objectWithKeyValues:dic];
    [self.tableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareLayout];
}

- (void)prepareLayout {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH, self.view.frame.size.height-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsSelection = NO;
    [self.tableView registerClass:[ShopCarCell class] forCellReuseIdentifier:@"MBShopCarCell"];
    [self.view addSubview:self.tableView];
    
    UIView *buttomV = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height -50, SCREEN_WIDTH, 50)];
    buttomV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomV];
    
    self.selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectAllBtn.frame = CGRectMake(5,5, 80, 40);
    [self.selectAllBtn setImage:[UIImage imageNamed:@"change_select"] forState:UIControlStateNormal];
    [self.selectAllBtn setImage:[UIImage imageNamed:@"change_selected"] forState:UIControlStateSelected];
    [self.selectAllBtn addTarget:self action:@selector(selectAllaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.selectAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selectAllBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.selectAllBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [buttomV addSubview:self.selectAllBtn];
    
    
    
    self.totalMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(self.selectAllBtn.right+5, 15, SCREEN_WIDTH-self.selectAllBtn.right-70,20)];
    
    self.totalMoneyLab.textAlignment = NSTextAlignmentCenter;
    self.totalMoneyLab.font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    self.totalMoneyLab.attributedText = str;
    
    
    [buttomV addSubview:self.totalMoneyLab];
    
    
    self.jieSuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.jieSuanBtn.frame = CGRectMake(self.totalMoneyLab.right,5,40, 40);
    
    [self.jieSuanBtn addTarget:self action:@selector(jieSuanAction) forControlEvents:UIControlEventTouchUpInside];
    self.jieSuanBtn.layer.masksToBounds = YES;
    [self.jieSuanBtn setTitle:@"结算" forState:UIControlStateNormal];
    [self.jieSuanBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.jieSuanBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.jieSuanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [buttomV addSubview:self.jieSuanBtn];
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopCarM.productList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ShopCarCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MBShopCarCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.shopCarM = self.shopCarM.productList[indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//       进行网络请求 根据结果进行以下删除操作
        if (1) {
//                删除成功之后 重新计算总金额
                
                ShopCarCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                if (cell.isCheck) {
                    ShopCarDetailModel *shopCarDetailM = self.shopCarM.productList[indexPath.row];
                    float money = shopCarDetailM.buyCount * [shopCarDetailM.nowPrice floatValue];
                    [self btnClick:money andBool:NO];
                }
                
                [self.shopCarM.productList removeObjectAtIndex:indexPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
//                @"删除成功" 
            }else {
//                @"删除失败"
            }
    }
}

//结算
-(void)jieSuanAction{
    
    NSLog(@"结算");
    
}

//全选
-(void)selectAllaction:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    //改变单元格选中状态
    self.allPrice = 0;
    float money = 0;
    for (int i = 0; i < self.shopCarM.productList.count; i++) {
        ShopCarCell *shopCarCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        shopCarCell.isCheck = sender.selected;
        money += [self.shopCarM.productList[i].nowPrice floatValue] * self.shopCarM.productList[i].buyCount;
    }
    if (sender.selected) {
        
        [self btnClick:money andBool:YES];
    }else {
        
        self.totalMoneyLab.text = [NSString stringWithFormat:@"总金额:￥%.2f元",self.allPrice];
    }
    [self.tableView reloadData];
    
    
}
-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    ShopCarDetailModel *detailM = self.shopCarM.productList[index.row];
    
//    0 不做操作 1 减操作 2 加操作

    int state = 0;
    switch (flag) {
        case 1001:
        {
            //做减法
            //先获取到当期行数据源内容，改变数据源内容，刷新表格
            
            if (detailM.buyCount > 1) {
                detailM.buyCount -- ;
                state = 1;
//                [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:(UITableViewRowAnimationNone)];
            }else {
                state = 0;
//                @"至少为1" 
            }
        }
            break;
        case 1002:
        {
            if (detailM.buyCount < detailM.stock ) {
                detailM.buyCount ++;
                state = 2;
//                [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:(UITableViewRowAnimationNone)];
            }else {
                state = 0;
//                @"库存不足啦" 
            }
        }
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
    if (state != 0) {
//        根据需要是否进行网络请求
//        以下为操作失败 对数据进行回复
//                if (state == 1) {
//                    detailM.buyCount ++;
//                }else if (state == 2) {
//                    detailM.buyCount --;
//                }
//        
    
    }
    //计算总价
    ShopCarCell *shopCarCell = (ShopCarCell *)cell;
    if (shopCarCell.isCheck) {
        if (state == 1) {
            [self btnClick:[detailM.nowPrice floatValue] andBool:NO];
        }else if(state == 2){
            [self btnClick:[detailM.nowPrice floatValue] andBool:YES];
        }
    }
}
/**
 *  计算总金额
 *
 *  @param money 差价
 *  @param b     yes 代表加 no 代表减
 */
-(void)btnClick:(float)money andBool:(BOOL)b{
    if (b) {
        self.allPrice += money;
//        是否所有按钮都选中
        BOOL isAllSelect = YES;
        for (int i = 0; i < self.shopCarM.productList.count; i++) {
            ShopCarCell *shopCarCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if(!shopCarCell.isCheck) {
                isAllSelect = NO;
            }
        }
        if (isAllSelect) {
            self.selectAllBtn.selected = YES;
        }
    }else {
//        全选按钮取消
        self.selectAllBtn.selected = NO;
        self.allPrice -= money;
    }
    self.totalMoneyLab.text = [NSString stringWithFormat:@"总金额:￥%.2f元",self.allPrice];
    
}

@end
