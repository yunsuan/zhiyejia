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

//租房
#import "RentHouseDemandVC.h"
#import "RentStoreDemandVC.h"
#import "RentOfficeDemandVC.h"

#import "BaseColorHeader.h"
#import "DeamandSaleCell.h"
#import "DemandBuyCell.h"

@interface DemandVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation DemandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
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
