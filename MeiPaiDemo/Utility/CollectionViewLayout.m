//
//  CollectionViewLayout.m
//  Control
//
//  Created by 李明 on 2017/1/20.
//  Copyright © 2017年 李明. All rights reserved.
//

#import "CollectionViewLayout.h"

@interface CollectionViewLayout()

@property (nonatomic, strong) NSMutableArray *attributesArray;//cell布局数组
@property (nonatomic, strong) NSMutableArray *columnHeights;

@end

@implementation CollectionViewLayout

- (instancetype)init {
    if (self = [super init]) {
        //布局默认属性
        self.columnCount = 1;
        self.rowSpacing = 0;
        self.columnSpacing = 0;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

//当collectionView的bounds改变的时候，我们需要告诉collectionView是否需要重新计算布局属性，通过这个方法返回是否需要重新计算的结果。简单的返回YES会导致我们的布局在每一秒都在进行不断的重绘布局，造成额外的计算任务。一旦重新刷新布局，就会重新调用下面的方法：1.prepareLayout   2.layoutAttributesForElementsInRect:方法
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
        return YES;
    }
    return NO;
}

//系统在准备对item进行布局前会调用这个方法，我们重写这个方法之后可以在方法里面预先设置好需要用到的变量属性等。
- (void)prepareLayout {
    [super prepareLayout];
    [self.attributesArray removeAllObjects];
    //有多少列
    NSInteger columnCount = [self columnCountInSection:0];
    if (columnCount <= 0) {
        return;
    }
    for (NSInteger column = 0; column < columnCount; column++) {
        //列高度
        [self.columnHeights addObject:@(self.sectionInset.top)];
    }
    //有多少个item
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat rowSpacing = [self minmumRowSpacing:0];
    
    CGFloat columnSpacing = [self minmumColumnSpacing:0];
    
    UIEdgeInsets sectionInset = [self allItemForScreenInset:0];
    
    CGFloat itemWidth = [self itemWidthInSection:0];
    
    for (NSInteger i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        //找出写一个item的位置
        NSUInteger columnIndex = [self nextItemInSection:0];
        CGFloat x = sectionInset.left + (itemWidth + columnSpacing) * columnIndex;
        CGFloat y = [self.columnHeights[columnIndex] floatValue];
        CGFloat itemHeight = [self itemHeightInSection:indexPath];
        
        att.frame = CGRectMake(x, y, itemWidth, itemHeight);
        //改变列高度
        self.columnHeights[columnIndex] = @(CGRectGetMaxY(att.frame) + rowSpacing);
        [self.attributesArray addObject:att];
        //[self.attributesArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];//调用自己写的布局方法
    }
}

//collectionView可能会为了某些特殊的item请求特殊的布局属性，我们可以在这个方法中创建并且返回特别定制的布局属性。根据传入的indexPath调用[UICollectionViewLayoutAttributes layoutAttributesWithIndexPath: ]方法来创建属性对象，然后设置创建好的属性，包括定制形变、位移等动画效果在内.子类必须重载该方法,该方法只能为cell提供布局信息，不能为补充视图和装饰视图提供。
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    CGFloat rowSpacing = [self minmumRowSpacing:0];
//    CGFloat columnSpacing = [self minmumColumnSpacing:0];
//    UIEdgeInsets sectionInset = [self allItemForScreenInset:0];
//    CGFloat itemWidth = [self itemWidthInSection:0];
//    NSUInteger columnIndex = [self nextItemInSection:0];
//    CGFloat xOffset = sectionInset.left + (itemWidth + columnSpacing) * columnIndex;
//    CGFloat yOffset = [self.columnHeights[columnIndex] floatValue];
//    CGFloat itemHeight = [self itemHeightInSection:indexPath];
//
//    att.frame = CGRectMake(xOffset, yOffset, itemWidth, itemHeight);
//    self.columnHeights[columnIndex] = @(CGRectGetMaxY(att.frame) + rowSpacing);
//    return att;
//}

// 遍历找出最短的列用来放置下一个item
- (NSUInteger)nextItemInSection:(NSInteger)section {
    __block NSUInteger index = 0;
    __block CGFloat height = MAXFLOAT;
    [self.columnHeights enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat h = [obj floatValue];
        if (h < height) {
            height = h;
            index = idx;
        }
    }];
    return index;
}

//collectionView调用这个方法并将自身坐标系统中的矩形传过来，这个矩形代表着当前collectionView可视的范围。我们需要在这个方法里面返回一个包括UICollectionViewLayoutAttributes对象的数组，这个布局属性对象决定了当前显示的item的大小、层次、可视属性在内的布局属性。同时，这个方法还可以设置supplementaryView和decorationView的布局属性。
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.attributesArray;
}

//由于collectionView将item的布局任务委托给layout对象，那么滚动区域的大小对于它而言是不可知的。自定义的布局对象必须在这个方法里面计算出显示内容的大小，包括supplementaryView和decorationView在内。
- (CGSize)collectionViewContentSize {
    if ([self columnCountInSection:0] <= 0) {
        return CGSizeZero;
    }
    CGSize contentSize = self.collectionView.bounds.size;
    __block NSInteger maxHeight = 0;
    [self.columnHeights enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([self.columnHeights[maxHeight] floatValue] < [obj floatValue]) {
            maxHeight = idx;
        }
    }];
    contentSize.height = [self.columnHeights[maxHeight] floatValue] - self.rowSpacing + self.sectionInset.bottom;
    return contentSize;
}

//返回有多少列
- (NSInteger)columnCountInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:columnCountInSection:)]) {
        return [self.delegate collectionView:self.collectionView layout:self columnCountInSection:section];
    } else {
        return self.columnCount;
    }
}

//所有item与屏幕的间距
- (UIEdgeInsets)allItemForScreenInset:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectoin:)]) {
        self.sectionInset = [self.delegate collectionView:self.collectionView layout:self insetForSectoin:section];
    }
    return self.sectionInset;
}

//返回列间距（item水平间距）
- (CGFloat)minmumColumnSpacing:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:minmumCloumnSpacingForSection:)]) {
        self.columnSpacing = [self.delegate collectionView:self.collectionView layout:self minmumCloumnSpacingForSection:section];
    }
    return self.columnSpacing;
}

//返回行间距
- (CGFloat)minmumRowSpacing:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:minmumRowSpacingForSection:)]) {
        self.rowSpacing = [self.delegate collectionView:self.collectionView layout:self minmumRowSpacingForSection:section];
    }
    return self.rowSpacing;
}

//计算item的宽
- (CGFloat)itemWidthInSection:(NSInteger)section {
    UIEdgeInsets sectionInset = [self allItemForScreenInset:section];
    CGFloat width = self.collectionView.bounds.size.width - sectionInset.left - sectionInset.right;
    NSInteger columnCount = [self columnCountInSection:section];
    CGFloat columnSpacing = [self minmumColumnSpacing:section];
    self.itemWidth = (width - (columnCount - 1) * columnSpacing) / columnCount;
    return self.itemWidth;
}

//item高
- (CGFloat)itemHeightInSection:(NSIndexPath *)indexPath {
    CGFloat height;
    {
        height = [self.delegate collectionViewLayout:self itemHeightForIndexPath:indexPath];
    }
    return height;
}

- (void)setColumnCount:(NSInteger)columnCount {
    if (_columnCount != columnCount) {
        _columnCount = columnCount;
        [self invalidateLayout];
    }
}

- (void)setSectionInset:(UIEdgeInsets)sectionInset {
    if (!UIEdgeInsetsEqualToEdgeInsets(_sectionInset, sectionInset)) {
        _sectionInset = sectionInset;
        [self invalidateLayout];
    }
}

- (NSMutableArray *)attributesArray {
    if (_attributesArray == nil) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

- (NSMutableArray *)columnHeights {
    if (_columnHeights == nil) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}


@end
