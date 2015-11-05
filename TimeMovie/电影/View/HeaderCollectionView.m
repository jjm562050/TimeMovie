//
//  HeaderCollectionView.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "HeaderCollectionView.h"
#import "PostMovieCell.h"


@implementation HeaderCollectionView

//子类化
//初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    //创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置水平间隙
    flowLayout.minimumInteritemSpacing = 10;
    
    //设置单元格大小
    _itemSize = CGSizeMake(frame.size.height * 0.6,frame.size.height * 0.9);
    flowLayout.itemSize = _itemSize;
    
    //设置四周间隙
    CGFloat x = (frame.size.width - frame.size.height * 0.6) / 2;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, x, 0, x);
    
    //设置水平滑动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    
    if(self)
    {
        //设置代理
        self.dataSource = self;
        self.delegate = self;
        
        self.showsHorizontalScrollIndicator = NO;
        
        //注册单元格
        UINib *nib = [UINib nibWithNibName:@"PostMovieCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellWithReuseIdentifier:@"postCell"];
        
        //初始化index
        self.index = 0;
        
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return _dataHeader.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    PostMovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"postCell" forIndexPath:indexPath];
    
    cell.movie = _dataHeader[indexPath.item];
    
    return cell;
}

//设置单元停止之后的位置
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0);
{
    /*
     实现自定义的分页效果
     1.获取视图停止之后的偏移量  x
     2.根据偏移量 计算停止之后 所在的页码
     3.计算此页 显示在正中间时 滑动视图的偏移量
     4.将计算所得的偏移量 设置给滑动视图
     */
    
    //1.
    CGFloat xOffSet = targetContentOffset -> x;
    
    //单元格宽度的一半
    xOffSet -= _itemSize.width * 0.5;
    
    //2.
    NSInteger index = xOffSet / (_itemSize.width  + 10);
    
    if(index > 0)
    {
        index += 1;
    }
    
    self.index = index;
    
    //3.
    xOffSet = index * (_itemSize.width  + 10);
    
    //4.
    targetContentOffset -> x = xOffSet;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //点击单元格 使单元格滑动到中心位置
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    self.index = indexPath.item;
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
