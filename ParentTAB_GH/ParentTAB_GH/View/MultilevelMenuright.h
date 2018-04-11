//
//  NewTabberController.h
//  ParentTAB_GH
//
//  Created by 苟应航 on 2018/4/11.
//  Copyright © 2018年 GouHang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLeftWidth 100
@protocol MultilevelMenurightDelegates <NSObject>

- (void)Usertype:(NSMutableArray *)usertype;

@end
@interface MultilevelMenuright : UIView
<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong,nonatomic,readonly) NSArray * allData;

@property(nonatomic,assign) id<MultilevelMenurightDelegates> delegate;
@property(copy,nonatomic,readonly) id block;


@property(assign,nonatomic) BOOL isRecordLastScroll;

@property(assign,nonatomic,readonly) NSInteger selectIndex;

/**
 *  颜色属性配置
 */

/**
 *  左边背景颜色
 */
@property(strong,nonatomic) UIColor * leftBgColor;
/**
 *  左边点中文字颜色
 */
@property(strong,nonatomic) UIColor * leftSelectColor;
/**
 *  左边点中背景颜色
 */
@property(strong,nonatomic) UIColor * leftSelectBgColor;

/**
 *  左边未点中文字颜色
 */

@property(strong,nonatomic) UIColor * leftUnSelectColor;
/**
 *  左边未点中背景颜色
 */
@property(strong,nonatomic) UIColor * leftUnSelectBgColor;
/**
 *  tablew 的分割线
 */
@property(strong,nonatomic) UIColor * leftSeparatorColor;

-(id)initWithFrame:(CGRect)frame WithData:(NSArray*)data withSelectIndex:(void(^)(NSInteger left,NSInteger right,id info))selectIndex;

@end


@interface rightMeunight : NSObject

//@property(nonatomic,strong)NSString *imgUrl;
//@property(nonatomic,strong)UIImageView *image;
/**
 *  菜单图片名
 */
@property(copy,nonatomic) NSString * urlName;
/**
 *  菜单名
 */
@property(copy,nonatomic) NSString * meunName;
/**
 *  菜单ID
 */
@property(copy,nonatomic) NSString * ID;

/**
 *  下一级菜单
 */
@property(strong,nonatomic) NSArray * nextArray;

//判断点击事件
@property(nonatomic,assign)BOOL sectect;

/**
 *  菜单层数
 */
@property(assign,nonatomic) NSInteger meunNumber;


@property(assign,nonatomic) float offsetScorller;

@end
