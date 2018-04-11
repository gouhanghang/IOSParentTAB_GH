//
//  LeftOneCell.m
//  ParentTAB_GH
//
//  Created by 苟应航 on 2018/4/10.
//  Copyright © 2018年 GouHang. All rights reserved.
//

#import "LeftOneCell.h"
@interface LeftOneCell()
@end
@implementation LeftOneCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadUi];
    }
    return self;
}
-(void)loadUi{
//    self.backgroundColor=GHhax(@"#f2f3f4");
    
   
    
//    _leanback =[UILabel new];
////    _leanback.backgroundColor=GHColor(59, 65, 73);
//    [self.contentView addSubview:_leanback];
//    [_leanback mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.mas_left);
//        make.top.mas_equalTo(self.mas_top).mas_offset(10);
//        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
//        make.width.mas_equalTo(5);
//    }];
    _backimage=[UIImageView new];
    _backimage.image=[UIImage imageNamed:@"btnBg"];
    _backimage.contentMode=UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_backimage];
    [_backimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    _titilelabe=[UILabel new];
    _titilelabe.text=@"我是坚决";
    _titilelabe.font=GHxiti(12);
    [self.contentView addSubview:_titilelabe];
    [_titilelabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    _leanlabe=[UILabel new];
    _leanlabe.hidden=NO;
//    _leanlabe.backgroundColor=[UIColor blackColor];
    [self.contentView addSubview:_leanlabe];
    [_leanlabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}
+(instancetype)initWithtabelviewcell:(UITableView *)tableview{
    NSString *const ID = @"LeftOneCell";
    LeftOneCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LeftOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(ObjectMode *)model{
    _model=model;
    _titilelabe.text=model.newsName;
}
-(void)setTypes:(BOOL)types{
    _types=types;
    _backimage.hidden=types==YES?NO:YES;
    _titilelabe.textColor=types==YES?WiteColors:noselectcolor;
    _leanlabe.backgroundColor=types==YES?selectcolor:GHhax(@"#f2f3f4");
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
