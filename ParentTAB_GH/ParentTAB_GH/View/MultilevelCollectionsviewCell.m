//
//  NewTabberController.h
//  ParentTAB_GH
//
//  Created by 苟应航 on 2018/4/11.
//  Copyright © 2018年 GouHang. All rights reserved.
//

#import "MultilevelCollectionsviewCell.h"

@implementation MultilevelCollectionsviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _views.layer.masksToBounds=YES;
    _views.layer.cornerRadius=5;
    _views.layer.borderColor=GHColor(123, 123, 123).CGColor;
    _views.layer.borderWidth=0.5;
    
}

@end
