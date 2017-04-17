//
//  MPMainViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/12.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPMainViewController.h"

#import "CustomSearchBar.h"
#import "PrefixHeader.pch"
#import "MPMainTopView.h"
#import "MPMainLiveCollectionView.h"
#import "MPMainPopularCollectionView.h"
#import "MPMainCityCollectionView.h"
#import "MPMainSearchController.h"
#import "ScrollImage.h"
#import "LiveController.h"
#import "VideoController.h"

@interface MPMainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, MPMainTopViewDelegate, UISearchBarDelegate, ScrollImageDelegate, CityCollectionViewDelegate, PopularCollectionViewDelegate, LiveCollectionViewDelegate>

@property (nonatomic, strong) MPMainTopView *topView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flow];

    [self.view addSubview:_collectionView];

    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MPMainViewBigCell"];
    [self.view addSubview:_collectionView];
    
    _topView = [[MPMainTopView alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 80, 44)];
    self.navigationItem.titleView  = _topView;
    _topView.delegate = self;
}


- (void)scrollImage:(ScrollImage *)scrollImage clickedAtIndex:(NSInteger)index
{
    NSLog(@"click:%ld",(long)index);

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MPMainViewBigCell" forIndexPath:indexPath];
    if (indexPath.item == 0) {
        MPMainLiveCollectionView *view = [[MPMainLiveCollectionView alloc] initWithFrame:self.view.bounds];
        view.delegate = self;
        [cell.contentView addSubview:view];
        
        
        /** 网络图片 **/
        NSArray *array = @[@"http://dl.bizhi.sogou.com/images/2012/09/30/44928.jpg",
                           @"http://www.deskcar.com/desktop/star/world/20081017165318/27.jpg",
                           @"http://www.0739i.com.cn/data/attachment/portal/201603/09/120156l1yzzn747ji77ugx.jpg",
                           @"http://image.tianjimedia.com/uploadImages/2012/320/8N5IGLFH4HDY_1920x1080.jpg",
                           @"http://b.hiphotos.baidu.com/zhidao/pic/item/10dfa9ec8a136327c3f37f95938fa0ec08fac77e.jpg",
                           @"http://pic15.nipic.com/20110628/7398485_105718357143_2.jpg"];
        ScrollImage *scrl = [[ScrollImage alloc] initWithCurrentController:self
                                                                 urlString:array
                                                                 viewFrame:CGRectMake(0, 60, self.view.bounds.size.width, 200)
                                                          placeholderImage:[UIImage imageNamed:@"fli311"]];
        scrl.delegate = self;
        scrl.timeInterval = 4.0;
        
        [view.collectionView addSubview:scrl];
        

    }
    if (indexPath.item == 1) {
        MPMainPopularCollectionView *popular = [[MPMainPopularCollectionView alloc] initWithFrame:self.view.bounds];
        popular.delegate = self;
        CustomSearchBar *search = [[CustomSearchBar alloc] initWithFrame:CGRectMake(10, 70, SCREEN_WIDTH - 20, 32)];
        search.delegate = self;
        search.placeholder = @"哈哈";
        [popular.collectionView addSubview:search];
        [cell.contentView addSubview:popular];
    }
    if (indexPath.item == 2) {
        MPMainCityCollectionView *city = [[MPMainCityCollectionView alloc] initWithFrame:self.view.bounds];
        city.delegate = self;
        [cell.contentView addSubview:city];
    }
    
    return cell;
}

- (void)liveCollectionViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath inIdentifier:(NSInteger)integer {
    LiveController *live = [[LiveController alloc] init];
    [self presentViewController:live animated:YES completion:nil];

}

- (void)popularCollectionViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath inIdentifier:(NSInteger)integer {
    VideoController *video = [[VideoController alloc] init];
    [self.navigationController pushViewController:video animated:YES];

}

- (void)cityCollectionViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath inIdentifier:(NSInteger)integer {
    if (integer == 0) {
        LiveController *live = [[LiveController alloc] init];
        [self presentViewController:live animated:YES completion:nil];
    } else {
        VideoController *video = [[VideoController alloc] init];
        [self.navigationController pushViewController:video animated:YES];
    }
}



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    MPMainSearchController *searchVC = [[MPMainSearchController alloc] init];
    [self presentViewController:searchVC animated:NO completion:nil];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)topViewBtnClick:(UIButton *)sender {

    NSIndexPath *path = [NSIndexPath indexPathForItem:sender.tag-1 inSection:0];
    
    [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger i = scrollView.contentOffset.x / SCREEN_WIDTH;

    [_topView btnInTag:i + 1];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat x = scrollView.contentOffset.x;
    if (x < 0 || x > SCREEN_WIDTH * 2) {
        return;
    }
    CGFloat f =  x / SCREEN_WIDTH * 80 + SCREEN_WIDTH / 2 - 120;
    [_topView updateBottomLineViewPosition:f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
