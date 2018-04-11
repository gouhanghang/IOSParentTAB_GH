//
//  ViewController.m
//  ParentTAB_GH
//
//  Created by 苟应航 on 2018/4/9.
//  Copyright © 2018年 GouHang. All rights reserved.
//
#import "HeadView.h"
#import "ViewController.h"
#import "NewTabberController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _cellnumber;
    NSArray *_listarr;
    HeadView *_headview;
}
@property (nonatomic, assign) CGSize textSize;
@property(assign,nonatomic)NSInteger selectIndex;
@property(nonatomic,assign)NSInteger getClickNum;

@property(nonatomic,strong)NSMutableArray *leftobjectarr;
@property(nonatomic,strong)NSMutableArray *rightobjectarr;

@property(nonatomic,strong)UILabel *leanlabe;
@property(nonatomic,strong)UITableView *lefttableview;
@property(nonatomic,strong)UITableView *righttableview;
@property(nonatomic,strong)UIButton *selectBtn;
@end

@implementation ViewController
-(UITableView *)lefttableview{
    if (_lefttableview==nil) {
        _lefttableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100,SCREEN_HEIGHT) style:UITableViewStylePlain];
        _lefttableview.backgroundColor=WiteColors;
        _lefttableview.showsVerticalScrollIndicator=NO;
        _lefttableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _lefttableview.dataSource=self;
        _lefttableview.delegate=self;
        [self.view addSubview:_lefttableview];
    }
    return _lefttableview;
}
-(UITableView *)righttableview{
    if (_righttableview==nil) {
        _righttableview=[[UITableView alloc]initWithFrame:CGRectMake(101, 0, SCREEN_WIDTH-101,SCREEN_HEIGHT) style:UITableViewStylePlain];
        _righttableview.showsVerticalScrollIndicator=NO;
        _righttableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _righttableview.dataSource=self;
        _righttableview.delegate=self;
        [self.view addSubview:_righttableview];
    }
    return _righttableview;
}
-(UILabel *)leanlabe{
    if (_leanlabe==nil) {
        _leanlabe=[UILabel new];
        _leanlabe.backgroundColor=GHhax(@"#f2f3f4");
        [self.view addSubview:_leanlabe];
        [_leanlabe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(_lefttableview.mas_right);
            make.width.mas_equalTo(0.5);
        }];
    }
    return _leanlabe;
}
-(UIButton *)selectBtn{
    if (_selectBtn==nil) {
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setTitleColor:selectcolor forState:UIControlStateNormal];
        [_selectBtn setTitle:@"点击 UITableView+UICollectionView 选项卡" forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(puchvc) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_selectBtn];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-100);
            make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        }];
    }
    return _selectBtn;
}
-(void)puchvc{
    NewTabberController *vc=[NewTabberController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"一个简单的选项卡";
    _leftobjectarr=@[].mutableCopy;
    _rightobjectarr=@[].mutableCopy;
    _selectIndex=0;
    _cellnumber=180;
    [self Jsonarr];
    [self lefttableview];
    [self leanlabe];
    [self righttableview];
    [self selectBtn];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tableView==_lefttableview ? 1 : _rightobjectarr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableView==_lefttableview ? _leftobjectarr.count : _cellnumber==section ? 1 : 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_lefttableview) {
        ObjectMode *model=_leftobjectarr[indexPath.row];
        LeftOneCell *cell=[LeftOneCell initWithtabelviewcell:tableView];
        cell.model=model;
        cell.types=indexPath.row==self.selectIndex ? YES:NO;
        return cell;
    }else{
        ObjectMode *model=_rightobjectarr[indexPath.section];
        RightOneCell *cell=[RightOneCell WithRightOneCell:tableView];
        cell.model=model;
        self.textSize=[self getLabelSizeFortextFont:GHxiti(12) textLabel:model.newsPhoneBody];
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView==_lefttableview ? 60 : self.textSize.height+5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_lefttableview) {
    _cellnumber = 180;
    LeftOneCell *cell=(LeftOneCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.types=YES;
    ObjectMode *model=_leftobjectarr[indexPath.row];
    NSString *newsTypeIdstr=model.newsTypeId;
    [_rightobjectarr removeAllObjects];
    for (NSDictionary *dic in _listarr) {
        ObjectMode *model=[ObjectMode mj_objectWithKeyValues:dic];
        if ([newsTypeIdstr isEqualToString:model.newsTypeId]) {
            [_rightobjectarr addObject:model];
        }
    }
     _selectIndex=indexPath.row;
    [_lefttableview reloadData];
    [_righttableview reloadData];
    }
}
// 取消选择
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftOneCell *cell=(LeftOneCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.types=NO;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ObjectMode *model=_rightobjectarr[section];
    _headview=[[HeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-101, 50)];
    _headview.titilestr=model.newsTitle;
    _headview.tag=section;
    _headview.imageview.transform =_cellnumber!=section ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_headview addGestureRecognizer:taps];
    _headview.lenad.hidden=_cellnumber!=section ? NO : YES;
    return tableView==_lefttableview ? nil:_headview;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return tableView==_righttableview ? 50 : 0.0001;
}
//添加手势方法
-(void)tap:(UITapGestureRecognizer *)sender
{
    _cellnumber = sender.view.tag;
    if (_cellnumber == self.getClickNum) {
        _cellnumber = 180;
    }
    [_righttableview reloadData];
    self.getClickNum = _cellnumber;
}
-(void)Jsonarr{
    NSArray *json=@[
                    @{
                        @"listBtn":@[
                                @{
                                  @"newsTypeId":@"78",
                                  @"newsName":@"我是PHP"
                                  },
                                @{
                                    @"newsTypeId":@"79",
                                    @"newsName":@"我是IOS"
                                    },
                                @{
                                    @"newsTypeId":@"80",
                                    @"newsName":@"我是安卓"
                                    },
                                @{
                                    @"newsTypeId":@"81",
                                    @"newsName":@"我是java"
                                    },
                                @{
                                    @"newsTypeId":@"82",
                                    @"newsName":@"我是Vue"
                                    },
                                ],
                        @"list":@[
                                @{
                                    @"newsTypeId":@"78",
                                    @"newsTitle":@"自学PHP      点击我",
                                    @"newsPhoneBody":@"PHP 是一种创建动态交互性站点的强有力的服务器端脚本语言。PHP 是免费的，并且使用广泛。对于像微软 ASP 这样的竞争者来说，PHP 无疑是另一种高效率的选项",
                                    },
                                @{
                                    @"newsTypeId":@"78",
                                    @"newsTitle":@"自学PHP      点击我",
                                    @"newsPhoneBody":@"PHP 是一种创建动态交互性站点的强有力的服务器端脚本语言。PHP 是免费的，并且使用广泛。对于像微软 ASP 这样的竞争者来说，PHP 无疑是另一种高效率的选项",
                                    },
                                @{
                                    @"newsTypeId":@"78",
                                    @"newsTitle":@"培训出来      点击我",
                                    @"newsPhoneBody":@"通过在线实例学习 PHP我们的 “运行实例” 工具降低了 PHP 的学习难度，它可以同时显示出 PHP 源代码以及代码的 HTML 输出",
                                    },
                                @{
                                    @"newsTypeId":@"79",
                                    @"newsTitle":@"提现后多久到账？",
                                    @"newsPhoneBody":@"工作日到账（提现后的第二个工作日）到账；周末及节假日银行暂不处理提现，到账时间需顺延至下一工作日",
                                    },
                                    @{
                                    @"newsTypeId":@"80",
                                    @"newsTitle":@"充值费用是多少？",
                                    @"newsPhoneBody":@"您好，您的账户资金将通过第三方平台进行充值，充值金额小于100元时，将由资金存管银行收取一定的手续费，充值手续费按充值金额的",
                                    },
                                @{
                                    @"newsTypeId":@"81",
                                    @"newsTitle":@"提现后多久到账？",
                                    @"newsPhoneBody":@"工作日到账（提现后的第二个工作日）到账；周末及节假日银行暂不处理提现，到账时间需顺延至下一工作日",
                                    },
                                @{
                                    @"newsTypeId":@"82",
                                    @"newsTitle":@"充值费用是多少？",
                                    @"newsPhoneBody":@"您好，您的账户资金将通过第三方平台进行充值，充值金额小于100元时，将由资金存管银行收取一定的手续费，充值手续费按充值金额的",
                                    },
                                ]
                        }
                    ];

    for (NSDictionary *dic in json) {
        NSArray *listBtnarr=dic[@"listBtn"];
        _listarr=dic[@"list"];
        NSString *newsTypeId=[NSString stringWithFormat:@"%@",listBtnarr[0][@"newsTypeId"]];
        for (NSDictionary *btndic in listBtnarr) {
                ObjectMode *model=[ObjectMode mj_objectWithKeyValues:btndic];
                [_leftobjectarr addObject:model];
        } for (NSDictionary *listdic in _listarr) {
            ObjectMode *model=[ObjectMode mj_objectWithKeyValues:listdic];
            if ([newsTypeId isEqualToString:model.newsTypeId]) {
                [_rightobjectarr addObject:model];
            }
        }
    }
    [_lefttableview reloadData];
    [_righttableview reloadData];
}

- (CGSize)getLabelSizeFortextFont:(UIFont *)font textLabel:(NSString *)text{
    CGSize titleSize = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-120, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return titleSize;
}

@end
