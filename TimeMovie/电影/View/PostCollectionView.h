//
//  PostCollectionView.h
//  TimeMovie
//
//  Created by MAC22 on 15/8/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSArray *dataPost;

@property(nonatomic,assign) NSInteger index;

@end
