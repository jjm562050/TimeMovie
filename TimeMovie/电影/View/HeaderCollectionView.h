//
//  HeaderCollectionView.h
//  TimeMovie
//
//  Created by MAC22 on 15/8/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Myblock)(NSInteger);

@interface HeaderCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

{
    CGSize _itemSize;    //单元格的大小
}
@property(nonatomic,assign) Myblock block;

@property(nonatomic,strong) NSArray *dataHeader;

@property(nonatomic,assign) NSInteger index;

@end
