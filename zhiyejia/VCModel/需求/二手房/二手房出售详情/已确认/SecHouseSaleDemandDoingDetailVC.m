//
//  SecHouseSaleDemandDoingDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/16.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseSaleDemandDoingDetailVC.h"

#import "SecHouseSaleDemandTakeLookVC.h"
#import "SecHouseSaleDemandMaintainVC.h"
#import "SecHouseSaleDemandDealVC.h"

#import "BaseColorHeader.h"
#import "SecHouseSaleDemandDetailHouseCell.h"
#import "SecHouseSaleDemandDetailDymCell.h"
#import "TitleContentRightBtnCell.h"
#import "SecHouseSaleDemandDetailCompanyCell.h"
#import "SecHouseSaleDemandDetailAgentCell.h"

@interface SecHouseSaleDemandDoingDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_recommend_id;
    
    NSDictionary *_dataDic;
    
    NSArray *_recordArr;
    NSMutableArray *_serviceArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation SecHouseSaleDemandDoingDetailVC

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

    [BaseRequest GET:NeedSaleValueDeail_URL parameters:@{@"recommend_id":_recommend_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataDic = resposeObject[@"data"];
            self->_recordArr = @[self->_dataDic[@"take_info"],self->_dataDic[@"survey_log"],self->_dataDic[@"deal"]];
            self->_serviceArr = [[NSMutableArray alloc] initWithArray:@[self->_dataDic[@"survey"],self->_dataDic[@"house"],self->_dataDic[@"deal"]]];
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
        [BaseRequest POST:NeedSaleCancel_URL parameters:@{@"recommend_id":self->_recommend_id,@"disabled_reason":reason} success:^(id  _Nonnull resposeObject) {

            if ([resposeObject[@"code"] integerValue] == 200) {

                [self showContent:@"取消成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                    if (self.secHouseSaleDemandDoingDetailVCBlock) {

                        self.secHouseSaleDemandDoingDetailVCBlock();
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
    
    return 40 *SIZE;
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
    
    header.contentL.text = @"";
    if (section == 0) {
        
        header.titleL.text = @"房源详情";
        header.contentL.text = self->_dataDic[@"current_state_name"];
    }else if (section == 1){
        
        header.titleL.text = @"房源动态";
    }else{
        
        header.titleL.text = @"中介服务详情";
    }
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        
        if ([self->_dataDic[@"take"] count]) {
            
            return 4;
        }
        return 0;
    }else if (section == 2){
        
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        SecHouseSaleDemandDetailHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseSaleDemandDetailHouseCell"];
        if (!cell) {
            
            cell = [[ SecHouseSaleDemandDetailHouseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseSaleDemandDetailHouseCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = self->_dataDic[@"recommend"];
        return cell;
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            SecHouseSaleDemandDetailDymCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseSaleDemandDetailDymCell"];
            if (!cell) {
                
                cell = [[ SecHouseSaleDemandDetailDymCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseSaleDemandDetailDymCell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = self->_dataDic[@"take"];
            return cell;
        }else{
         
            TitleContentRightBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleContentRightBtnCell"];
            if (!cell) {

                cell = [[ TitleContentRightBtnCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TitleContentRightBtnCell"];
            }

            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            [cell.titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(10 *SIZE);
                make.top.equalTo(cell.contentView).offset(14 *SIZE);
                make.width.mas_equalTo(100 *SIZE);
            }];
            
            [cell.contentL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(100 *SIZE);
                make.top.equalTo(cell.contentView).offset(14 *SIZE);
                make.right.equalTo(cell.contentView).offset(-70 *SIZE);
            }];
            
            cell.contentL.textAlignment = NSTextAlignmentRight;
            if (indexPath.row == 1) {
                
                if ([_recordArr[0] count]) {
                    
                    cell.hidden = NO;
                }else{
                    
                    cell.hidden = YES;
                }
                cell.titleL.text = @"带看记录";
                cell.contentL.text = [NSString stringWithFormat:@"最近带看 %@",[_recordArr[0][0][@"take_time"] componentsSeparatedByString:@" "][0]];
            }else if (indexPath.row == 2) {
                
                if ([_recordArr[1] count]) {
                    
                    cell.hidden = NO;
                }else{
                    
                    cell.hidden = YES;
                }
                cell.titleL.text = @"房源维护记录";
                cell.contentL.text = [NSString stringWithFormat:@"最近维护 %@",[_recordArr[1][0][@"create_time"]  componentsSeparatedByString:@" "][0]];
            }else{
                
                if ([_recordArr[2] count]) {
                    
                    cell.hidden = NO;
                }else{
                    
                    cell.hidden = YES;
                }
                cell.titleL.text = @"成交详情";
                cell.contentL.text = @"";
            }
            return cell;
        }
    }else{
        
        SecHouseSaleDemandDetailAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecHouseSaleDemandDetailAgentCell"];
        if (!cell) {
            
            cell = [[ SecHouseSaleDemandDetailAgentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecHouseSaleDemandDetailAgentCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        if (indexPath.row == 0) {
            
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_serviceArr[0][@"survey_agent_img"]]] placeholderImage:IMAGE_WITH_NAME(@"def_head") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
               
                if (error) {
                    
                    cell.headImg.image = IMAGE_WITH_NAME(@"def_head");
                }
            }];
            cell.nameL.text = _serviceArr[0][@"survey_agent_name"];
            cell.professionL.text = @"专业评分";
            cell.serviceL.text = @"服务评分";
            cell.typeL.text = @"勘察经纪人";
            
            cell.secHouseSaleDemandDetailAgentCellPhoneBlock = ^{
                
                NSString *phone = [NSString stringWithFormat:@"%@",self->_serviceArr[0][@"survey_agent_tel"]];
                if (phone.length) {
                    
                    //获取目标号码字符串,转换成URL
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                    //调用系统方法拨号
                    [[UIApplication sharedApplication] openURL:url];
                }else{
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
                }
            };
        }else if (indexPath.row == 1){
            
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_serviceArr[1][@"house_agent_img"]]] placeholderImage:IMAGE_WITH_NAME(@"def_head") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
               
                if (error) {
                    
                    cell.headImg.image = IMAGE_WITH_NAME(@"def_head");
                }
            }];
            cell.nameL.text = _serviceArr[1][@"house_agent_name"];
            cell.professionL.text = @"专业评分";
            cell.serviceL.text = @"服务评分";
            cell.typeL.text = @"房源维护经纪人";
            
            cell.secHouseSaleDemandDetailAgentCellPhoneBlock = ^{
                
                NSString *phone = [NSString stringWithFormat:@"%@",self->_serviceArr[1][@"house_agent_tel"]];
                if (phone.length) {
                    
                    //获取目标号码字符串,转换成URL
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                    //调用系统方法拨号
                    [[UIApplication sharedApplication] openURL:url];
                }else{
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
                }
            };
        }else{
            
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_serviceArr[2][@"deal_agent_img"]]] placeholderImage:IMAGE_WITH_NAME(@"def_head") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
               
                if (error) {
                    
                    cell.headImg.image = IMAGE_WITH_NAME(@"def_head");
                }
            }];
            cell.nameL.text = _serviceArr[2][@"deal_agent_name"];
            cell.professionL.text = @"专业评分";
            cell.serviceL.text = @"服务评分";
            cell.typeL.text = @"成交经纪人";
            
            cell.secHouseSaleDemandDetailAgentCellPhoneBlock = ^{
                
                NSString *phone = [NSString stringWithFormat:@"%@",self->_serviceArr[2][@"deal_agent_tel"]];
                if (phone.length) {
                    
                    //获取目标号码字符串,转换成URL
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                    //调用系统方法拨号
                    [[UIApplication sharedApplication] openURL:url];
                }else{
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
                }
            };
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {

        if (indexPath.row == 1) {

            SecHouseSaleDemandTakeLookVC *nextVC = [[SecHouseSaleDemandTakeLookVC alloc] initWithDataArr:_recordArr[0]];
            nextVC.takeDic = self->_dataDic[@"take"];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 2){

            SecHouseSaleDemandMaintainVC *nextVC = [[SecHouseSaleDemandMaintainVC alloc] initWithDataArr:_recordArr[1]];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 3){

            SecHouseSaleDemandDealVC *nextVC = [[SecHouseSaleDemandDealVC alloc] init];
            nextVC.dealDic = self->_dataDic[@"deal"];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
//    if (indexPath.section == 2) {
//
//        SecHouseCompanyDetailVC *nextVC = [[SecHouseCompanyDetailVC alloc] init];
//        [self.navigationController pushViewController:nextVC animated:YES];
//    }
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
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
