//
//  SecHouseSaleDemandMaintainVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseSaleDemandMaintainVC.h"

#import "BaseColorHeader.h"
#import "SecHouseDemandMaintainCell.h"

@interface SecHouseSaleDemandMaintainVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_dataArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation SecHouseSaleDemandMaintainVC

- (instancetype)initWithDataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _dataArr = dataArr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return UITableViewAutomaticDimension;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseColorHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseColorHeader"];
    if (!header) {

        header = [[BaseColorHeader alloc] initWithReuseIdentifier:@"BaseColorHeader"];
    }

    header.titleL.text = [NSString stringWithFormat:@"总维护量：%ld",_dataArr.count];;
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecHouseDemandMaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseDemandMaintainCell"];
    if (!cell) {
        
        cell = [[SecHouseDemandMaintainCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseDemandMaintainCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    cell.secHouseDemandMaintainCellPhoneBlock = ^{
        
        NSString *phone = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"agent_tel"]];
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
}

- (void)initUI{
    
    self.titleLabel.text = @"房源维护记录";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
