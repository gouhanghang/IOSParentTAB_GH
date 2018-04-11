//
//  RightOneCell.m
//  ParentTAB_GH
//
//  Created by 苟应航 on 2018/4/11.
//  Copyright © 2018年 GouHang. All rights reserved.
//

#import "RightOneCell.h"
@interface RightOneCell()
@property(nonatomic,strong)UILabel *textlabe;
@end
@implementation RightOneCell
+(instancetype)WithRightOneCell:(UITableView *)tableview{
    NSString *const ID = @"RightOneCell";
    RightOneCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[RightOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadUI];
    }
    return self;
}
-(void)loadUI{
    self.backgroundColor=GHhax(@"#f2f2f2");
    _textlabe=[UILabel new];
    _textlabe.numberOfLines=0;
    _textlabe.font=GHxiti(12);
    [self.contentView addSubview:_textlabe];
    [_textlabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self.mas_top);
    }];
    
   
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setModel:(ObjectMode *)model{
    _model=model;
    _textlabe.text=model.newsPhoneBody;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
