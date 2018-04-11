//
//  NewTabberController.h
//  ParentTAB_GH
//
//  Created by 苟应航 on 2018/4/11.
//  Copyright © 2018年 GouHang. All rights reserved.
//

#import "MultilevelMenus.h"
#import "MultilevelCollectionsviewCell.h"
#import "MultilevelTableViewCell.h"
#define kImageDefaultName @"tempShop"


#define kMultilevelCollectionsviewCell @"MultilevelCollectionsviewCell"
#define kMultilevelCollectionHeader   @"CollectionHeader"//CollectionHeader
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#import "MultilevelMenuright.h"

@interface MultilevelMenuright()


@property(strong,nonatomic ) UITableView * leftTablew;
@property(strong,nonatomic ) UICollectionView * rightCollection;
@property(assign,nonatomic) BOOL isReturnLastOffset;


@property(nonatomic,strong)NSMutableArray *selectindepath;

//@property(nonatomic,strong)NSMutableArray *selectindepath1;
//
//@property(nonatomic,strong)NSMutableArray *selectindepath2;
//
//@property(nonatomic,strong)NSMutableArray *selectindepath3;


@property(nonatomic,strong)NSMutableArray *strarr;

@property(nonatomic,strong)NSMutableArray *firstListArray;

@property(nonatomic,strong)NSMutableArray *secondListArray;

@property(nonatomic,strong)NSMutableArray *lastListArray;

@property(nonatomic,strong)NSMutableArray *endtArray;


@end

@implementation MultilevelMenuright

-(id)initWithFrame:(CGRect)frame WithData:(NSArray *)data withSelectIndex:(void (^)(NSInteger, NSInteger, id))selectIndex
{
    
    if (self  == [super initWithFrame:frame]) {
        if (data.count==0) {
            return nil;
        }
        
        _strarr=@[].mutableCopy;
        _selectindepath=@[].mutableCopy;
//        _selectindepath1=@[].mutableCopy;
//        _selectindepath2=@[].mutableCopy;
//        _selectindepath3=@[].mutableCopy;
//        
        _firstListArray =@[].mutableCopy;
        _secondListArray =@[].mutableCopy;
        _lastListArray =@[].mutableCopy;
        _endtArray=@[].mutableCopy;
        
        _block=selectIndex;
        self.leftSelectColor=[UIColor blackColor];
        self.leftSelectBgColor=[UIColor whiteColor];
        self.leftBgColor=UIColorFromRGB(0xF3F4F6);
        self.leftSeparatorColor=UIColorFromRGB(0xE5E5E5);
        self.leftUnSelectBgColor=UIColorFromRGB(0xF3F4F6);
        self.leftUnSelectColor=[UIColor blackColor];
        
        _selectIndex=0;
        
        _allData=data;
        
        
        /**
         左边的视图
         */
        self.leftTablew=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, frame.size.height-40)]; //-114
        self.leftTablew.dataSource=self;
        self.leftTablew.delegate=self;
        
        self.leftTablew.tableFooterView=[[UIView alloc] init];
        [self addSubview:self.leftTablew];
        self.leftTablew.backgroundColor=self.leftBgColor; //背景色
        if ([self.leftTablew respondsToSelector:@selector(setLayoutMargins:)]) {
            self.leftTablew.layoutMargins=UIEdgeInsetsZero;
        }
        if ([self.leftTablew respondsToSelector:@selector(setSeparatorInset:)]) {
            self.leftTablew.separatorInset=UIEdgeInsetsZero;
        }
        self.leftTablew.separatorColor=self.leftSeparatorColor;
        
        
        /**
         右边的视图
         */
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.minimumInteritemSpacing=0.f;//左右间隔
        flowLayout.minimumLineSpacing=0.f;
        float leftMargin =0;
        self.rightCollection=[[UICollectionView alloc] initWithFrame:CGRectMake(kLeftWidth+leftMargin,0,kSCREEN_WIDTH-kLeftWidth-leftMargin*2,frame.size.height-40) collectionViewLayout:flowLayout];
        
        self.rightCollection.delegate=self;
        self.rightCollection.dataSource=self;
        self.rightCollection.allowsMultipleSelection=YES;
        
        UINib *nib=[UINib nibWithNibName:kMultilevelCollectionsviewCell bundle:nil];
        
        [self.rightCollection registerNib: nib forCellWithReuseIdentifier:kMultilevelCollectionsviewCell];
        
        
        UINib *header=[UINib nibWithNibName:kMultilevelCollectionHeader bundle:nil];
        [self.rightCollection registerNib:header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMultilevelCollectionHeader];
        
        [self addSubview:self.rightCollection];
        
        if (self.allData.count>0) {
            [self.leftTablew selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
        
        self.isReturnLastOffset=YES;
        
        self.rightCollection.backgroundColor=self.leftSelectBgColor;
        
        self.backgroundColor=self.leftSelectBgColor;
        
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40)];
        view.backgroundColor=KAllBcakColor;
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backstr) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [self addSubview:view];
        
    }
    return self;
}

-(void)setLeftBgColor:(UIColor *)leftBgColor{
    _leftBgColor=leftBgColor;
    self.leftTablew.backgroundColor=leftBgColor;
    
}
-(void)setLeftSelectBgColor:(UIColor *)leftSelectBgColor{
    
    _leftSelectBgColor=leftSelectBgColor;
    self.rightCollection.backgroundColor=leftSelectBgColor;
    
    self.backgroundColor=leftSelectBgColor;
}
-(void)setLeftSeparatorColor:(UIColor *)leftSeparatorColor{
    _leftSeparatorColor=leftSeparatorColor;
    self.leftTablew.separatorColor=leftSeparatorColor;
}
-(void)reloadData{
    
    [self.leftTablew reloadData];
    [self.rightCollection reloadData];
    
}
#pragma mark---左边的tablew 代理
#pragma mark--deleagte
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.allData.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * Identifier=@"MultilevelTableViewCell";
    MultilevelTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    if (!cell) {
        cell=[[NSBundle mainBundle] loadNibNamed:@"MultilevelTableViewCell" owner:self options:nil][0];
        
        UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(kLeftWidth-0.5, 0, 0.5, 44)];
        label.backgroundColor=tableView.separatorColor;
        [cell addSubview:label];
        label.tag=100;
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    rightMeuns * title=self.allData[indexPath.row];
    cell.Colre.backgroundColor=KAllBcakColor;
    cell.titile.text=title.meunName;
    cell.titile.font=[UIFont systemFontOfSize:13];
    //    cell.titile.font=FontSize()(13);
    
    UILabel * line=(UILabel*)[cell viewWithTag:100];
    if (indexPath.row==self.selectIndex) {
        cell.Colre.hidden=NO;
        cell.titile.textColor=KAllBcakColor;//RGB(102, 177, 91);
        cell.backgroundColor=self.leftSelectBgColor;
        line.backgroundColor=cell.backgroundColor;
    }
    else{
        cell.titile.textColor=GHColor(86, 86, 86);
        cell.backgroundColor=self.leftUnSelectBgColor;
        line.backgroundColor=tableView.separatorColor;
        
    }
    
    
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins=UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset=UIEdgeInsetsZero;
    }
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
// 选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.Colre.hidden=NO;
    cell.titile.textColor=KAllBcakColor;//RGB(102, 177, 91);
    cell.backgroundColor=self.leftSelectBgColor;
    
    
    
    _selectIndex=indexPath.row;
    rightMeuns * title=self.allData[indexPath.row];
    
    
    UILabel * line=(UILabel*)[cell viewWithTag:100];
    line.backgroundColor=cell.backgroundColor;
    
    
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    self.isReturnLastOffset=NO;
    
    [self removeobj];
    [self.rightCollection reloadData];
    
    
    if (self.isRecordLastScroll) {
        [self.rightCollection scrollRectToVisible:CGRectMake(0, title.offsetScorller, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:NO];
    }
    else{
        
        [self.rightCollection scrollRectToVisible:CGRectMake(0, 0, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:NO];
    }
    
    
    
}
-(void)removeobj{
    
    [_lastListArray removeAllObjects];
    [_secondListArray removeAllObjects];
    [_firstListArray removeAllObjects];
    [_strarr removeAllObjects];
    [_selectindepath removeAllObjects];
    
}

// 取消选择
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.Colre.hidden=YES;
    
    cell.titile.textColor=GHColor(86, 86, 86);
    
    UILabel * line=(UILabel*)[cell viewWithTag:100];
    line.backgroundColor=tableView.separatorColor;
    
    cell.backgroundColor=self.leftUnSelectBgColor;
    
}

#pragma mark---imageCollectionView--------------------------

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    if (self.allData.count==0) {
        return 0;
    }
    
    rightMeuns * title=self.allData[self.selectIndex];
    return   title.nextArray.count;
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    rightMeuns * title=self.allData[self.selectIndex];
    if (title.nextArray.count>0) {
        
        rightMeuns *sub=title.nextArray[section];
        
        if (sub.nextArray.count==0)//没有下一级
        {
            return 1;
        }
        else
            return sub.nextArray.count;
        
    }
    else{
        return title.nextArray.count;
    }
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MultilevelCollectionsviewCell *cell1;
    UICollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
    cell1=(MultilevelCollectionsviewCell *)cell;
    
    rightMeuns * title=self.allData[self.selectIndex];
    NSArray * list;
    
    rightMeuns * meun;
    
    meun=title.nextArray[indexPath.section];
    
    if (meun.nextArray.count>0) {
        meun=title.nextArray[indexPath.section];
        list=meun.nextArray;
        meun=list[indexPath.row];
    }
    void (^select)(NSInteger left,NSInteger right,id info) = self.block;
    
    select(self.selectIndex,indexPath.row,meun);
}
#pragma mark -多选
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MultilevelCollectionsviewCell *cell1;
    UICollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
    cell1=(MultilevelCollectionsviewCell *)cell;
    
    rightMeuns * title=self.allData[self.selectIndex];
    NSArray * list;
    
    rightMeuns * meun;
    meun=title.nextArray[indexPath.section];
    
    if (meun.nextArray.count>0) {
        meun=title.nextArray[indexPath.section];
        list=meun.nextArray;
        meun=list[indexPath.row];
        
    }
    NSString *str=[NSString stringWithFormat:@"%@",meun.meunName];
    if (indexPath.section == 0) {
        
        if (_firstListArray.count>4) {
[MBProgressHUD showInformationCenter:@"最多只选择5个!" toView:self andAfterDelay:2.0];
            
            
        }else{
            
            if (_secondListArray.count>0) {

                [MBProgressHUD showInformationCenter:@"只能选择一种品类!" toView:self andAfterDelay:2.0];
                
            }else{
            
                cell1.titile.textColor=WiteColors;
                cell1.views.backgroundColor=KAllBcakColor;
                [_firstListArray addObject:str];
                [_strarr addObject:str];
                [_selectindepath addObject:indexPath];
                NSLog(@"-1%@--",_firstListArray);
                
                
            }
            
            
            
            
        }
        
    }else if (indexPath.section == 1){
        
        
        if (_secondListArray.count>4) {
            
[MBProgressHUD showInformationCenter:@"最多只选择5个!" toView:self andAfterDelay:2.0];
        }else{
            
                        if (_firstListArray.count>0) {

            [MBProgressHUD showInformationCenter:@"只能选择一种品类!" toView:self andAfterDelay:2.0];
                        }else  {
            
                            cell1.titile.textColor=WiteColors;
                            cell1.views.backgroundColor=KAllBcakColor;
                            [_secondListArray addObject:str];
                            [_strarr addObject:str];
                            [_selectindepath addObject:indexPath];
                            NSLog(@"-2%@--",_secondListArray);
            
            
            
                        }
            
        }
        
    }else if (indexPath.section == 2){
        
        if (_lastListArray.count>4) {
            
[MBProgressHUD showInformationCenter:@"最多只选择5个!" toView:self andAfterDelay:2.0];
        }else{
            
            cell1.titile.textColor=WiteColors;
            cell1.views.backgroundColor=KAllBcakColor;
            [_lastListArray addObject:str];
            [_strarr addObject:str];
            [_selectindepath addObject:indexPath];
            NSLog(@"-3%@--",_lastListArray);
            
        }
    }else if (indexPath.section==3){
    
        if (_endtArray.count>4) {
            
//            [[HUDHelper sharedInstance] tipMessage:@"最多只选择5个!"];
        }else{
            
            cell1.titile.textColor=WiteColors;
            cell1.views.backgroundColor=KAllBcakColor;
            [_endtArray addObject:str];
            [_strarr addObject:str];
            [_selectindepath addObject:indexPath];
            NSLog(@"-3%@--",_endtArray);
            
        }
    
    }
    
    
    
    return YES;
    
    
}
#pragma mark -取消多选
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MultilevelCollectionsviewCell *cell1;
    UICollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
    cell1=(MultilevelCollectionsviewCell *)cell;
    
    rightMeuns * title=self.allData[self.selectIndex];
    NSArray * list;
    
    rightMeuns * meun;
    meun=title.nextArray[indexPath.section];
    
    if (meun.nextArray.count>0) {
        meun=title.nextArray[indexPath.section];
        list=meun.nextArray;
        meun=list[indexPath.row];
    }
    cell1.titile.textColor=GHColor(123, 123, 123);
    cell1.views.backgroundColor=WiteColors;
    for (int i=0; i<_strarr.count; i++) {
        
        if ([meun.meunName isEqualToString:[NSString stringWithFormat:@"%@",_strarr[i]]]) {
            NSLog(@"我要移除");
            if (indexPath.section==0) {
                [_firstListArray removeObject:_strarr[i]];
            }else if (indexPath.section==1){
                [_secondListArray removeObject:_strarr[i]];
            }else if (indexPath.section==2){
                [_lastListArray removeObject:_strarr[i]];
            }else{
                [_endtArray removeObject:_strarr[i]];
            }
            [_strarr removeObjectAtIndex:i];
            [_selectindepath removeObjectAtIndex:i];
            NSLog(@"%@",_strarr);
            
        }else{
            NSLog(@"%@",_strarr);
            NSLog(@"我不移除。");
        }
    }
    return YES;
    
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MultilevelCollectionsviewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kMultilevelCollectionsviewCell forIndexPath:indexPath];
    rightMeuns * title=self.allData[self.selectIndex];
    NSArray * list;
    
    rightMeuns * meun;
    
    meun=title.nextArray[indexPath.section];
    
    if (meun.nextArray.count>0) {
        meun=title.nextArray[indexPath.section];
        list=meun.nextArray;
        meun=list[indexPath.row];
    }
    cell.titile.textColor=GHColor(123, 123, 123);
    cell.titile.text=meun.meunName;
    cell.titile.font=GHFont(12);
    cell.views.backgroundColor=WiteColors;
    return cell;
}
//
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectindepath.count!=0) {
        for (int i=0; i<_selectindepath.count; i++) {
            MultilevelCollectionsviewCell *cell1;
            UICollectionViewCell *cell12=[_rightCollection cellForItemAtIndexPath:_selectindepath[i]];
            cell1=(MultilevelCollectionsviewCell*)cell12;
            cell1.views.backgroundColor=KAllBcakColor;
            cell1.titile.textColor=WiteColors;
        }
    }else{
        
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = @"footer";
    }else{
        reuseIdentifier = kMultilevelCollectionHeader;
    }
    
    rightMeuns * title=self.allData[self.selectIndex];
    
    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[view viewWithTag:1];
    label.font=[UIFont systemFontOfSize:15];
    label.textColor=UIColorFromRGB(0x686868);
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        if (title.nextArray.count>0) {
            rightMeuns * meun;
            meun=title.nextArray[indexPath.section];
            label.text=meun.meunName;
        }
        else{
            label.text=@"暂无";
        }
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        view.backgroundColor = [UIColor lightGrayColor];
        label.text = [NSString stringWithFormat:@"这是footer:%ld",(long)indexPath.section];
    }
    return view;
}

//设置行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    rightMeuns * title=self.allData[self.selectIndex];
    NSArray * list;
    
    rightMeuns * meun;
    
    meun=title.nextArray[indexPath.section];
    
    if (meun.nextArray.count>0) {
        meun=title.nextArray[indexPath.section];
        list=meun.nextArray;
        meun=list[indexPath.row];
    }
    
    //    if ([meun.meunName isEqualToString:@"私人订制工作室"]) {
    //        return CGSizeMake(80, 30);
    //    }else{
    //    }
    if (IS_IPHONE_5||IS_IPHONE_4) {
        return CGSizeMake(60, 30);
    }else if (IS_IPHONE_6){
        return CGSizeMake(80, 30);
    }else{
        
        return CGSizeMake(65, 30);
    }
    
}

// 头部高度、
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={kSCREEN_WIDTH,50};
    return size;
}
#pragma mark -点击确定。。。
-(void)backstr{
    if (_strarr.count!=0) {
        [self.delegate Usertype:_strarr];
        [_strarr removeAllObjects];
        [_selectindepath removeAllObjects];
    }
    else{
        
        NSLog(@"没有值。。");
    }
    
    
    
}


#pragma mark---记录滑动的坐标
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.rightCollection]) {
        self.isReturnLastOffset=YES;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:self.rightCollection]) {
        
        rightMeuns * title=self.allData[self.selectIndex];
        
        title.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.rightCollection]) {
        
        rightMeuns * title=self.allData[self.selectIndex];
        
        title.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
        
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:self.rightCollection] && self.isReturnLastOffset) {
        rightMeuns * title=self.allData[self.selectIndex];
        
        title.offsetScorller=scrollView.contentOffset.y;
        
        
    }
}



#pragma mark--Tools
-(void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@end



@implementation rightMeunight



@end
