//
//  DemandVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/20.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "DemandVC.h"

#import "DemandListVC.h"

#import "HouseDemandVC.h"
#import "OfficeDemandVC.h"
#import "StoreDemandVC.h"

//二手房
#import "SecHouseSaleDemandDetailVC.h"
#import "SecHouseBuyDemandDetailVC.h"

#import "SecHouseDemandVC.h"
#import "SecStoreDemandVC.h"
#import "SecOfficeDemandVC.h"

//租房
#import "RentHouseDemandVC.h"
#import "RentStoreDemandVC.h"
#import "RentOfficeDemandVC.h"

#import "BaseColorHeader.h"
#import "DeamandSaleCell.h"
#import "DemandBuyCell.h"

#import "SinglePickView.h"

@interface DemandVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_sellArr;
    NSMutableArray *_buyArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation DemandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _sellArr = [@[] mutableCopy];
    _buyArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:NeedBuyList_URL parameters:@{@"type":@"0"} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_buyArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            [self->_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    if ([UserModel defaultModel].agent_id) {
        
        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[@{@"param":@"新房-住宅",@"id":@"1"},@{@"param":@"新房-商铺",@"id":@"2"},@{@"param":@"新房-写字楼",@"id":@"3"},@{@"param":@"二手房-住宅",@"id":@"4"},@{@"param":@"二手房-商铺",@"id":@"5"},@{@"param":@"二手房-写字楼",@"id":@"6"}]];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            
            switch ([ID integerValue]) {
                case 1:
                {
                    HouseDemandVC *nextVC = [[HouseDemandVC alloc] init];
                    [self.navigationController pushViewController:nextVC animated:YES];
                    break;
                }
                case 2:
                {
                    OfficeDemandVC *nextVC = [[OfficeDemandVC alloc] init];
                    [self.navigationController pushViewController:nextVC animated:YES];
                    break;
                }
                case 3:
                {
                    OfficeDemandVC *nextVC = [[OfficeDemandVC alloc] init];
                    [self.navigationController pushViewController:nextVC animated:YES];
                    break;
                }
                case 4:
                {
                    SecHouseDemandVC *nextVC = [[SecHouseDemandVC alloc] init];
                    [self.navigationController pushViewController:nextVC animated:YES];
                    break;
                }
                case 5:
                {
                    SecStoreDemandVC *nextVC = [[SecStoreDemandVC alloc] init];
                    [self.navigationController pushViewController:nextVC animated:YES];
                    break;
                }
                case 6:
                {
                    SecOfficeDemandVC *nextVC = [[SecOfficeDemandVC alloc] init];
                    [self.navigationController pushViewController:nextVC animated:YES];
                    break;
                }
                default:
                    break;
            }
        };
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }else{
        
        [self GotoLogin];
        [self RequestMethod];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseColorHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseColorHeader"];
    if (!header) {
        
        header = [[BaseColorHeader alloc] initWithReuseIdentifier:@"BaseColorHeader"];
    }
    
    header.titleL.text = @"二手房出售";
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        DeamandSaleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeamandSaleCell"];
        if (!cell) {
            
            cell = [[DeamandSaleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DeamandSaleCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = @{};
        
        cell.deamandSaleCellBlock = ^{
          
            NSString *phone = @"15983804766";
            if (phone.length) {
                
                //获取目标号码字符串,转换成URL
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                //调用系统方法拨号
                [[UIApplication sharedApplication] openURL:url];
            }else{
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
            }
        };
        return cell;
    }else{
        
        DemandBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemandBuyCell"];
        if (!cell) {
            
            cell = [[DemandBuyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DemandBuyCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = @{};
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        SecHouseSaleDemandDetailVC *nextVC = [[SecHouseSaleDemandDetailVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        SecHouseBuyDemandDetailVC *nextVC = [[SecHouseBuyDemandDetailVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.view.backgroundColor = CLLineColor;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:IMAGE_WITH_NAME(@"add-1") forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"需求";

    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}


@end
