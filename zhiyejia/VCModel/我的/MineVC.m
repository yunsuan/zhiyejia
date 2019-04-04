//
//  MineVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/20.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MineVC.h"

#import "LoginVC.h"
#import "PersonalVC.h"
#import "MyMessageVC.h"
#import "MyAppointVC.h"
#import "MySubscibeVC.h"
#import "FeedbackVC.h"
#import "MyAttentionAgentVC.h"
#import "AttentionHouseVC.h"


#import "MineHeader.h"
#import "MineCell.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_imgArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}


- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReloadUserInfo) name:@"reloadUser" object:nil];
    _titleArr = @[@"个人资料",@"我的消息",@"我的预约",@"我的订阅",@"意见反馈",@"关于宜家"];
    _imgArr = @[@"personaldata",@"work",@"makeanappointment",@"subscribe",@"opinion",@"about"];
}

- (void)ReloadUserInfo{
    
    if ([UserModel defaultModel].token) {
        
        
    }else{
        
        
    }
}

- (void)GotoLogin{
    
    LoginVC *nextVC = [[LoginVC alloc] init];
    nextVC.loginVCBlock = ^{
        
        [BaseRequest GET:PersonalGetAgentInfo_URL parameters:@{} success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:resposeObject[@"data"]];
                [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass:[NSNull class]]) {
                        
                        [tempDic setObject:@"" forKey:key];
                    }
                }];
                [UserModel defaultModel].absolute_address = tempDic[@"absolute_address"];
                [UserModel defaultModel].account = tempDic[@"account"];
                [UserModel defaultModel].birth = tempDic[@"birth"];
                [UserModel defaultModel].city = tempDic[@"city"];
                [UserModel defaultModel].district = tempDic[@"district"];
                [UserModel defaultModel].head_img = tempDic[@"head_img"];
                [UserModel defaultModel].name = tempDic[@"name"];
                [UserModel defaultModel].sex = tempDic[@"sex"];
                [UserModel defaultModel].tel = tempDic[@"tel"];
                [UserModel defaultModel].province = tempDic[@"province"];
                [UserModelArchiver archive];
                [self->_table reloadData];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"未获取到用户信息，请重试"];
        }];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    MineHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MineHeader"];
    if (!header) {
        
        header = [[MineHeader alloc] initWithReuseIdentifier:@"MineHeader"];
    }
    
    if ([UserModel defaultModel].token.length) {
        
        [header.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,[UserModel defaultModel].head_img]] placeholderImage:IMAGE_WITH_NAME(@"def_head") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
           
            if (error) {
                
                header.headerImg.image = IMAGE_WITH_NAME(@"def_head");
            }
        }];
        
        header.nameL.text = [UserModel defaultModel].name;
    }else{
        
        header.headerImg.image = IMAGE_WITH_NAME(@"def_head");
        header.nameL.text = @"登录/注册";
    }
    
    header.mineHeaderNameBlock = ^{
        
        if ([UserModel defaultModel].token.length) {
            
            
        }else{
            
            [self GotoLogin];
        }
    };
    
    header.mineHeaderImgBlock = ^{
      
        if ([UserModel defaultModel].token.length) {
            
            
        }else{
            
            [self GotoLogin];
        }
    };
    
    header.mineHeaderRoomBtnBlock = ^{
        
        if ([UserModel defaultModel].token.length) {
            
            AttentionHouseVC *nextVC = [[AttentionHouseVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            [self GotoLogin];
        }
    };
    
    header.mineHeaderAgentBtnBlock = ^{
      
        if ([UserModel defaultModel].token.length) {
        
            MyAttentionAgentVC *nextVC = [[MyAttentionAgentVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            [self GotoLogin];
        }
    };
    
    header.mineHeaderHistoryBtnBlock = ^{
        
        if ([UserModel defaultModel].token.length) {
            
//            MyAttentionAgentVC *nextVC = [[MyAttentionAgentVC alloc] init];
//            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            [self GotoLogin];
        }
    };
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    if (!cell) {
        
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleL.text = _titleArr[indexPath.row];
    cell.titleImg.image = IMAGE_WITH_NAME(_imgArr[indexPath.row]);
    cell.rightImg.image = IMAGE_WITH_NAME(@"rightarrow");
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            if ([UserModel defaultModel].token.length) {
                
                PersonalVC *nextVC = [[PersonalVC alloc] init];
                nextVC.personalVCBlock = ^{
                    
                    [tableView reloadData];
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                [self GotoLogin];
            }
            break;
        }
            
        case 1:{
            
            if ([UserModel defaultModel].token.length) {
            
                MyMessageVC *nextVC = [[MyMessageVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                [self GotoLogin];
            }
            break;
        }
        case 2:{
            
            if ([UserModel defaultModel].token.length) {
           
                MyAppointVC *nextVC = [[MyAppointVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                [self GotoLogin];
            }
            break;
        }
        case 3:{
            
            if ([UserModel defaultModel].token.length) {
            
                MySubscibeVC *nextVC = [[MySubscibeVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                [self GotoLogin];
            }
            break;
        }
        case 4:{
            
            if ([UserModel defaultModel].token.length) {
                
                FeedbackVC *nextVC = [[FeedbackVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                [self GotoLogin];
            }
            break;
        }
        default:
            break;
    }
}

- (void)initUI{
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.bounces = NO;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 40 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 220 *SIZE;
    _table.backgroundColor = CLWhiteColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
