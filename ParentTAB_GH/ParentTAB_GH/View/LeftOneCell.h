//
//  LeftOneCell.h
//  ParentTAB_GH
//
//  Created by 苟应航 on 2018/4/10.
//  Copyright © 2018年 GouHang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ObjectMode;
@interface LeftOneCell : UITableViewCell
@property(nonatomic,strong)ObjectMode *model;
@property(nonatomic,strong)UILabel *leanlabe;
@property(nonatomic,strong)UIImageView *backimage;
@property(nonatomic,assign)BOOL types;
@property(nonatomic,strong)UILabel *titilelabe;
+(instancetype)initWithtabelviewcell:(UITableView *)tableview;
@end
