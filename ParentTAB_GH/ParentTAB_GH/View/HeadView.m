//
//  HeadView.m
//  ParentTAB_GH
//
//  Created by 苟应航 on 2018/4/11.
//  Copyright © 2018年 GouHang. All rights reserved.
//

#import "HeadView.h"
@interface HeadView()
@property(nonatomic,strong)UILabel *titlelabe;
@end;
@implementation HeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled=YES;
        [self loadUI];
    }
    return self;
}
-(void)loadUI{
    _titlelabe=[UILabel new];
    _titlelabe.font=GHxiti(12);
    [self addSubview:_titlelabe];
    [_titlelabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    _lenad=[UILabel new];
    _lenad.backgroundColor=GHhax(@"#f1f1f1");
    [self addSubview:_lenad];
    [_lenad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    _imageview=[UIImageView new];
    _imageview.image=[UIImage imageNamed:@"help_arrow_down"];
    [self addSubview:_imageview];
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(10);
    }];
    
}
-(void)setTitilestr:(NSString *)titilestr{
    _titilestr=titilestr;
    _titlelabe.text=titilestr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
