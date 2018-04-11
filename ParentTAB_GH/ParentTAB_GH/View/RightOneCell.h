//
//  RightOneCell.h
//  ParentTAB_GH
//
//  Created by 苟应航 on 2018/4/11.
//  Copyright © 2018年 GouHang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ObjectMode;
@interface RightOneCell : UITableViewCell
+(instancetype)WithRightOneCell:(UITableView *)tableview;
@property(nonatomic,strong)ObjectMode *model;
@end
