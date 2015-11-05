//
//  PostCollectionView.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PostCollectionView.h"
#import "PostMovieCell.h"
#import "HeaderCollectionView.h"

@implementation PostCollectionView

//子类化
//初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    //创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置水平间隙
    flowLayout.minimumInteritemSpacing = 10;
    
    //设置单元格大小
    flowLayout.itemSize = CGSizeMake(frame.size.width * 0.6,frame.size.height * 0.6);
    
    //设置四周间隙
    flowLayout.sectionInset = UIEdgeInsetsMake(0, frame.size.width * 0.2, 0, frame.size.width * 0.2);
    
    //设置水平滑动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    
    if(self)
    {
        //设置代理
        self.dataSource = self;
        self.delegate = self;
        
        self.showsHorizontalScrollIndicator = NO;
        
        self.backgroundColor = [UIColor blackColor];
        
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
    return _dataPost.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    PostMovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"postCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    cell.movie = _dataPost[indexPath.item];
    
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
    xOffSet -= scrollView.width * 0.3;
    
    //2.
    NSInteger index = xOffSet / (scrollView.width * 0.6 + 10);
    
    if(index > 0)
    {
        index += 1;
    }
    
    //改变index的值
    self.index = index;
    
    //3.
    xOffSet = index * (scrollView.width * 0.6 + 10);
    
    //4.
    targetContentOffset -> x = xOffSet;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 根据偏移量 计算正中间单元格的索引
    NSInteger index = collectionView.contentOffset.x / (collectionView.width * 0.6 + 10);
    
    // 判断选中的单元格 是不是正中间单元格
    if (indexPath.item == index) {
        //是正中间的单元格
        //获取单元格
        PostMovieCell *postCell = (PostMovieCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        //翻转单元格
        [postCell filpCell];
    }
    else
    {
        
        self.index = indexPath.item;
        
        //不是
        //将这个单元格 移动到正中间
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        //将前一个单元格 翻转回来
        //获取单元格
        PostMovieCell *postCell = (PostMovieCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        
        //翻转单元格
        [postCell backFilpCell];
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    PostMovieCell *postCell = (PostMovieCell *)cell;
    [postCell backFilpCell];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
