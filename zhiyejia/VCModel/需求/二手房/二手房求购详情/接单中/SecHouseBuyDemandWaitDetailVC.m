//
//  SecHouseBuyDemandWaitDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyDemandWaitDetailVC.h"

#import "SecHouseCompanyDetailVC.h"
#import "SecRoomDetailVC.h"

#import "BaseColorHeader.h"
#import "SecHouseBuyDetailCell.h"
#import "SecHouseRemindCell.h"
#import "SecHouseBuyDemandDetailRecommendCell.h"
#import "SecHouseBuyDemandDetailAgentCell.h"
#import "SecHouseCell.h"

@interface SecHouseBuyDemandWaitDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_recommend_id;
    
    NSDictionary *_dataDic;
    
    NSMutableArray *_houseArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation SecHouseBuyDemandWaitDetailVC

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
    
    [self initDataSource];
    self.titleLabel.text = @"发布详情";
    [self RequestMethod];
}

- (void)initDataSource{
    
    _houseArr = [@[] mutableCopy];
}

- (void)RequestMethod{

    [BaseRequest GET:NeedBuyWaitDeail_URL parameters:@{@"recommend_id":_recommend_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataDic = resposeObject[@"data"];
            if ([self->_dataDic[@"house"][@"data"] count]) {
                
                for (int i = 0; i < [self->_dataDic[@"house"][@"data"] count]; i++) {
                    
                    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self->_dataDic[@"house"][@"data"][i]];
                    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        
                        if ([obj isKindOfClass:[NSNull class]]) {
                            
                            if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                                
                                [tempDic setObject:@[] forKey:key];
                            }else{
                                
                                [tempDic setObject:@"" forKey:key];
                            }
                        }else{
                            
                            if ([key isEqualToString:@"house_tags"] || [key isEqualToString:@"project_tags"]) {
                                
                                
                            }else{
                                
                                [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                            }
                        }
                    }];
                    SecHouseModel *model = [[SecHouseModel alloc] initWithDictionary:tempDic];
                    [self->_houseArr addObject:model];
                }
                
            }
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

                    if (self.secHouseBuyDemandWaitDetailVCBlock) {

                        self.secHouseBuyDemandWaitDetailVCBlock();
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
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0 || section == 1) {
        
        return 0;
    }else{
        
        if (section == 2) {
            
            if (_houseArr.count) {
                
                return 40 *SIZE;
            }else{
                
                return 0;
            }
        }else{
            
            return 40 *SIZE;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseColorHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseColorHeader"];
    if (!header) {
        
        header = [[BaseColorHeader alloc] initWithReuseIdentifier:@"BaseColorHeader"];
    }
    
    if (section == 0) {
        
//        header.titleL.text = @"房源详情";
//        header.contentL.text = @"已成交";
    }else if (section == 2){
        
//        header.titleL.text = @"金牌经纪人";
//    }else if (section == 3){
        
        header.titleL.text = @"系统匹配房源";
    }
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        
        return _houseArr.count > 3 ? 3:_houseArr.count;
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
        
        cell.dataDic = _dataDic;
        return cell;
    }else if (indexPath.section == 1){
        
        SecHouseRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseRemindCell"];
        if (!cell) {
            
            cell = [[SecHouseRemindCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseRemindCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentL.text = @"发布成功！已通知全城经纪人，请保持手机联络畅通，经纪人将会在周一至周日8:00-20:00给你回电。";
        return cell;
//    }else if (indexPath.section == 2){
//
//        SecHouseBuyDemandDetailAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseBuyDemandDetailAgentCell"];
//        if (!cell) {
//
//            cell = [[SecHouseBuyDemandDetailAgentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseBuyDemandDetailAgentCell"];
//        }
//
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        cell.dataDic = @{};
//        return cell;
    }else{
        
        SecHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseCell"];
        if (!cell) {
                   
            cell = [[SecHouseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseCell"];
        }
            
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
               
        cell.model = _houseArr[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        
        SecHouseModel *model = _houseArr[indexPath.row];
        SecRoomDetailVC *nextVC = [[SecRoomDetailVC alloc] initWithHouseId:model.house_id city:@"0"];
        nextVC.type = [model.type integerValue];
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
