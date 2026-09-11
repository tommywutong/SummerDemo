//
//  FirstVCTableViewCell.m
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/16.
//

#import "HomeViewControllerTableViewCell.h"
#import "HomeViewController.h"
@implementation HomeViewControllerTableViewCell {
    NSInteger _currentPage;
}

#define WIDTH [UIScreen mainScreen].bounds.size.width

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        if ([reuseIdentifier isEqualToString:@"advertise"]) {
            [self setupadvertisement];
//        } else if ([reuseIdentifier isEqualToString:@"cell"]) {
//            [self setupcell];
//        }
    }
    return self;
}

-(void) setupadvertisement {
    CGFloat screenWidth = 402;
    CGFloat bannerHeight = 245;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -22, screenWidth, bannerHeight)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;

    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.directionalLockEnabled = NO;
    [self.contentView addSubview:self.scrollView];
    
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(-45, 150, screenWidth, 30)];
    self.page.numberOfPages = 4;
    self.page.currentPage = 0;
    //self.page.backgroundColor = [UIColor whiteColor];
    self.page.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.page.currentPageIndicatorTintColor = [UIColor blackColor];
    self.page.userInteractionEnabled = NO;
    [self.contentView addSubview:self.page];
    [self setupBanner];
}


- (void)setupBanner {
    CGFloat screenWidth = 402;
    CGFloat bannerHeight = 245;

    NSArray *originalImages = @[@"main_img1", @"main_img2", @"main_img3", @"main_img4"];
    NSArray *displayImages = @[@"main_img4", @"main_img1", @"main_img2", @"main_img3", @"main_img4", @"main_img1"];

    self.page.numberOfPages = originalImages.count;
    
    for (int i = 0; i < displayImages.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:displayImages[i]]];
        imgView.frame = CGRectMake(screenWidth * i, -22, screenWidth, bannerHeight);
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [self.scrollView addSubview:imgView];
    }

    self.scrollView.contentSize = CGSizeMake(screenWidth * displayImages.count, bannerHeight);
    self.scrollView.contentOffset = CGPointMake(screenWidth, 0);
    self.timer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)pageChanged:(UIPageControl *)sender {
    NSInteger page = sender.currentPage;
    CGFloat width = WIDTH;
    [self.scrollView setContentOffset:CGPointMake((page + 1) * width, 0) animated:YES];
}

- (void)autoScroll {
    CGFloat screenWidth = self.scrollView.bounds.size.width;
    CGFloat currentOffset = self.scrollView.contentOffset.x;
    NSInteger nextPage = (NSInteger)(currentOffset / screenWidth) + 1;
    NSInteger realPageCount = self.page.numberOfPages;
    if (nextPage >= realPageCount + 2) {
        [self.scrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
        self.page.currentPage = 0;
        return;
    }
    [self.scrollView setContentOffset:CGPointMake(nextPage * screenWidth, 0) animated:YES];
    self.page.currentPage = (nextPage - 1) % realPageCount;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.scrollView) return;
    
    CGFloat screenWidth = scrollView.bounds.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger realPageCount = self.page.numberOfPages;
    NSInteger totalPages = realPageCount + 2;
    // 左边界处理
    if (offsetX <= 0) {
        scrollView.contentOffset = CGPointMake(screenWidth * (totalPages - 2), 0);
        self.page.currentPage = realPageCount - 1;
    }
    else if (offsetX >= screenWidth * (totalPages - 1)) {
        scrollView.contentOffset = CGPointMake(screenWidth, 0);
        self.page.currentPage = 0;
    }else {
        NSInteger currentPage = (NSInteger)(offsetX / screenWidth) - 1;
        if (currentPage < 0) currentPage = realPageCount - 1;
        if (currentPage >= realPageCount) currentPage = 0;
        self.page.currentPage = currentPage;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 用户结束拖动时重启自动滚动
    [self startAutoScrollTimer];
}

- (void)startAutoScrollTimer {
    // 先停止
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }

    self.timer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//-(void) setupcell {
//    
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 200;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return (section == 0) ? 0.1 : 10;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return nil;
//}

@end
