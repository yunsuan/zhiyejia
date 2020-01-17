//
//  SecHouseBuyDemandDoingDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyDemandDoingDetailVC.h"

#import "SecHouseCompanyDetailVC.h"
#import "SecHouseBuyDemandDetailRecommendVC.h"

#import "RightBtnColorHeader.h"
#import "SecHouseBuyDetailCell.h"
#import "SecHouseBuyDemandDetailRecommendCell.h"
#import "SecHouseBuyDemandDetailAgentCell.h"
#import "SecHouseBuyDemandDetailHouseCell.h"

@interface SecHouseBuyDemandDoingDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_recommend_id;
    
    NSDictionary *_dataDic;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation SecHouseBuyDemandDoingDetailVC

- (instancetype)initWithRecomendId:(NSString *)recommend_id
{
    self = [super init];
    if (self) {
        
        _recommend_id = recommend_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"发布详情";
    [self RequestMethod];
}

- (void)RequestMethod{

    [BaseRequest GET:NeedBuyValueDeail_URL parameters:@{@"recommend_id":_recommend_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataDic = resposeObject[@"data"];
            [self->_table reloadData];
            
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
        [self initUI];
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    FailView *view = [[FailView alloc] initWithFrame:self.view.bounds];
    view.failViewBlock = ^(NSString *str) {
        
        NSString *reason;
        if (str.length) {
            
            reason = str;
        }else{
            
            reason = @" ";
        }
        [BaseRequest POST:NeedBuyBuyCancel_URL parameters:@{@"recommend_id":self->_recommend_id,@"disabled_reason":reason} success:^(id  _Nonnull resposeObject) {

            if ([resposeObject[@"code"] integerValue] == 200) {

                [self showContent:@"取消成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                    if (self.secHouseBuyDemandDoingDetailVCBlock) {

                        self.secHouseBuyDemandDoingDetailVCBlock();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{

                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {

            [self showContent:@"网络错误"];
        }];
    };
    [self.view addSubview:view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }
    return 40 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    RightBtnColorHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RightBtnColorHeader"];
    if (!header) {
        
        header = [[RightBtnColorHeader alloc] initWithReuseIdentifier:@"RightBtnColorHeader"];
    }
    
    header.titleL.text = @"服务经纪人";
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        SecHouseBuyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseBuyDetailCell"];
        if (!cell) {
            
            cell = [[SecHouseBuyDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseBuyDetailCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _dataDic[@"client"];
        return cell;
    }else{
        
        SecHouseBuyDemandDetailAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseBuyDemandDetailAgentCell"];
        if (!cell) {
            
            cell = [[SecHouseBuyDemandDetailAgentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseBuyDemandDetailAgentCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = @{};
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        SecHouseBuyDemandDetailRecommendVC *nextVC = [[SecHouseBuyDemandDetailRecommendVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.rightBtn.hidden = NO;
    if ([self.status integerValue]) {
        
        self.rightBtn.hidden = YES;
    }
    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
    [self.rightBtn setTitle:@"取消发布" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
