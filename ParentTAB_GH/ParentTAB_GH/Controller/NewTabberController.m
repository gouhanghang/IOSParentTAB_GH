//
//  NewTabberController.m
//  ParentTAB_GH
//
//  Created by 苟应航 on 2018/4/11.
//  Copyright © 2018年 GouHang. All rights reserved.
//
#import "MultilevelMenus.h"
//#import "rightMeuns.h"
#import "NewTabberController.h"
#import "MultilevelMenuright.h"
@interface NewTabberController ()<MultilevelMenurightDelegates>
@property(nonatomic,strong)NSMutableArray *liss;
@property(nonatomic,strong)MultilevelMenuright *right;
@end

@implementation NewTabberController
- (void)viewDidLoad {
    [super viewDidLoad];
    _liss=@[].mutableCopy;
    self.view.backgroundColor=WiteColors;
    [self loaddateleft];
    [self classrightview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddateleft{
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Fabircplist" ofType:@"plist"]];
    // 遍历,把字典转模型
    for (NSDictionary *dict in dictArr) {
        //        NSLog(@"%@",dict[@"firstTabCate"]);
        
        NSArray *firstTabCate_arr=dict[@"firstTabCate"];
        NSInteger coun=firstTabCate_arr.count;
        //        NSLog(@"%ld",coun);
        for (int i=0; i<coun; i++) {
            NSDictionary *name_dict=firstTabCate_arr[i];
            rightMeuns *meum=[[rightMeuns alloc]init];
            
            meum.meunName=[NSString stringWithFormat:@"%@",name_dict[@"name"]];
            NSMutableArray * sub=[NSMutableArray arrayWithCapacity:0];
            NSArray *firstTabCate_arr=name_dict[@"groupList"];
            NSInteger tabcate_count =firstTabCate_arr.count;
            
            
            for (int j=0; j<tabcate_count; j++) {
                
                NSDictionary *Frist_name_Dict=firstTabCate_arr[j];
                
                rightMeuns * meun1=[[rightMeuns alloc] init];
                
                meun1.meunName=[NSString stringWithFormat:@"%@",Frist_name_Dict[@"name"]];
                [sub addObject:meun1];
                
                
                NSArray *tabCateList_arr=Frist_name_Dict[@"tabCateList"];
                NSInteger tabCateList_Cont=tabCateList_arr.count;
                
                NSMutableArray *zList=[NSMutableArray arrayWithCapacity:0];
                
                for (int i=0; i<tabCateList_Cont; i++) {
                    
                    NSDictionary *end_name=tabCateList_arr[i];
                    
                    
                    rightMeuns * meun2=[[rightMeuns alloc] init];
                    
                    meun2.meunName=[NSString stringWithFormat:@"%@",end_name[@"name"]];
                    
                    [zList addObject:meun2];
                }
                
                meun1.nextArray=zList;
                
            }
            
            
            meum.nextArray=sub;
            
            [_liss addObject:meum];
        }
    }
}

-(void)classrightview{
    
    _right=[[MultilevelMenuright alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) WithData:_liss withSelectIndex:^(NSInteger left, NSInteger right,rightMeunight* info) {
        
        
        
    }];
    _right.delegate=self;
//    _right.backgroundColor=kRedColor;
    _right.isRecordLastScroll=YES;
    
    [self.view addSubview:_right];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
