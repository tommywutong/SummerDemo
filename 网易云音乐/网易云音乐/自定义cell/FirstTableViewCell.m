//
//  FirstTableViewCell.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/7/11.
//


#import "FirstTableViewCell.h"
#import "MyVC.h"
#import <AVFoundation/AVFoundation.h>
#import "NightModeManager.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width



@interface FirstTableViewCell ()
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation FirstTableViewCell {
    NSInteger _currentPage;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if ([reuseIdentifier isEqualToString:@"poster"]) {
        [self setupPosterCell];
    } else if ([reuseIdentifier isEqualToString:@"recommand"]) {
        [self setupRecommandCell];
    } else if ([reuseIdentifier isEqualToString:@"guessyoulike"]) {
        [self setupGuessYouLikeCell];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                      selector:@selector(updateAppearance)
                                                          name:@"NightModeChangedNotification"
                                                        object:nil];
    [self updateAppearance];
    return self;
}

- (void)setupPosterCell {
    CGFloat screenWidth = WIDTH;
    CGFloat bannerHeight = screenWidth * 16.0 / 9.0;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, bannerHeight)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
    
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(-45, 0, screenWidth, 30)];
    self.page.numberOfPages = 4;
    self.page.currentPage = 0;
    //self.page.backgroundColor = [UIColor whiteColor];
    self.page.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.page.currentPageIndicatorTintColor = [UIColor blackColor];
    self.page.userInteractionEnabled = NO;
    [self.contentView addSubview:self.page];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                      selector:@selector(updateAppearance)
                                                          name:@"NightModeChangedNotification"
                                                        object:nil];
    [self setupBanner];
}

- (void)setupBanner {
    CGFloat screenWidth = WIDTH;
    CGFloat bannerHeight = WIDTH / 1.5;

    NSArray *originalImages = @[@"poster.4.jpg", @"poster.1.jpg", @"poster.2.jpg", @"poster.3.jpg"];
    NSArray *displayImages = @[@"poster.4.jpg", @"poster.1.jpg", @"poster.2.jpg", @"poster.3.jpg", @"poster.4.jpg", @"poster.1.jpg"];

    self.page.numberOfPages = originalImages.count;
    
    for (int i = 0; i < displayImages.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:displayImages[i]]];
        imgView.frame = CGRectMake(screenWidth * i, 0, screenWidth, bannerHeight);
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.userInteractionEnabled = YES;
        imgView.tag = 100 + i;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerTapped:)];
        [imgView addGestureRecognizer:tap];
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

    if (offsetX <= 0) {
        scrollView.contentOffset = CGPointMake(screenWidth * (totalPages - 2), 0);
        self.page.currentPage = realPageCount - 1;
    }

    else if (offsetX >= screenWidth * (totalPages - 1)) {
        scrollView.contentOffset = CGPointMake(screenWidth, 0);
        self.page.currentPage = 0;
    }

    else {
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
    [self startAutoScrollTimer];
}

- (void)startAutoScrollTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)bannerTapped:(UITapGestureRecognizer *)gesture {
    UIImageView *imgView = (UIImageView *)gesture.view;
    UIImage *image = imgView.image;
    if (!image) return;

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.alpha = 0.5;

    UIImageView *fullImageView = [[UIImageView alloc] initWithFrame:backgroundView.bounds];
    fullImageView.contentMode = UIViewContentModeScaleAspectFit;
    fullImageView.image = image;
    fullImageView.userInteractionEnabled = YES;

    UITapGestureRecognizer *tapClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFullScreenImage:)];
    [fullImageView addGestureRecognizer:tapClose];
    
    [backgroundView addSubview:fullImageView];
    [keyWindow addSubview:backgroundView];

    [UIView animateWithDuration:0.3 animations:^{
        backgroundView.alpha = 1.0;
    }];
}

- (void)dismissFullScreenImage:(UITapGestureRecognizer *)tap {
    UIView *backgroundView = tap.view.superview;
    [UIView animateWithDuration:0.3 animations:^{
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

- (void)setupRecommandCell {
    self.scrollView02 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 211)];
    self.scrollView02.scrollEnabled = YES;
    self.scrollView02.pagingEnabled = YES;
    self.scrollView02.alwaysBounceHorizontal = YES;
    self.scrollView02.alwaysBounceVertical = NO;
    self.scrollView02.contentSize = CGSizeMake(WIDTH * 2.1, 211);
    self.scrollView02.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView02];
    
    NSArray* arrayLabel02 = @[@"私人漫游", @"欧美日推", @"民谣日推", @"快乐旅行", @"电音日推", @"每日推荐"];
    NSArray* arrayLabel2 = @[@"1.2亿", @"23w", @"30w", @"460w", @"521w", @"6亿"];
    BOOL isNight = [NightModeManager sharedManager].isNightMode;

    for (int i = 0; i < 6; i++) {
        NSString* strName = [NSString stringWithFormat: @"guess%d", i + 1];
        UIImageView* iView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: strName]];
        iView.frame = CGRectMake(10 + 135 * i, 5, 125, 166);
        iView.layer.cornerRadius = 9;
        iView.layer.masksToBounds = YES;
        [self.scrollView02 addSubview: iView];
        
        self.label02 = [[UILabel alloc] initWithFrame: CGRectMake(10 + 135 * i, 160, 130, 50)];
        self.label02.font = [UIFont systemFontOfSize: 15];
        self.label02.text = arrayLabel02[i];
        self.label02.textColor = [UIColor darkGrayColor];
        self.label02.numberOfLines = 2;
        [self.scrollView02 addSubview: self.label02];
        
        self.label2 = [[UILabel alloc] initWithFrame: CGRectMake(5, 88, 100, 50)];
        self.label2.font = [UIFont systemFontOfSize: 15];
        self.label2.text = arrayLabel2[i];
        self.label2.textColor = [UIColor whiteColor];
        [iView addSubview: self.label2];
    }
}

- (void)setupGuessYouLikeCell {
    self.scrollView03 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 240)];
    self.scrollView03.delegate = self;
    self.scrollView03.contentSize = CGSizeMake(WIDTH * 3, 240);
    self.scrollView03.scrollEnabled = YES;
    self.scrollView03.pagingEnabled = YES;
    self.scrollView03.showsHorizontalScrollIndicator = NO;
    self.scrollView03.bounces = YES;
    [self.contentView addSubview:self.scrollView03];
    
    self.label03 = [[UILabel alloc] initWithFrame: CGRectMake(10, 10, WIDTH, 25)];
    self.label03.text = @"根据你喜欢的歌曲推荐:";
    self.label03.font = [UIFont systemFontOfSize: 20];
    [self.contentView addSubview:self.label03];
    
    self.tableView0301 = [[UITableView alloc] initWithFrame: CGRectMake(0, 40, WIDTH, 233) style: UITableViewStylePlain];
    self.tableView0301.delegate = self;
    self.tableView0301.dataSource = self;
    self.tableView0301.tag = 101;
    self.tableView0301.scrollEnabled = NO;
    
    self.tableView0302 = [[UITableView alloc] initWithFrame: CGRectMake(WIDTH, 40, WIDTH, 233) style: UITableViewStylePlain];
    self.tableView0302.delegate = self;
    self.tableView0302.dataSource = self;
    self.tableView0302.tag = 102;
    self.tableView0302.scrollEnabled = NO;
    
    self.tableView0303 = [[UITableView alloc] initWithFrame: CGRectMake(WIDTH * 2, 40, WIDTH, 233) style: UITableViewStylePlain];
    self.tableView0303.delegate = self;
    self.tableView0303.dataSource = self;
    self.tableView0303.tag = 103;
    self.tableView0303.scrollEnabled = NO;
    
    [self.tableView0301 registerClass: [UITableViewCell class] forCellReuseIdentifier: @"song01"];
    [self.tableView0302 registerClass: [UITableViewCell class] forCellReuseIdentifier: @"song02"];
    [self.tableView0303 registerClass: [UITableViewCell class] forCellReuseIdentifier: @"song03"];
    
    [self.scrollView03 addSubview: self.tableView0301];
    [self.scrollView03 addSubview: self.tableView0302];
    [self.scrollView03 addSubview: self.tableView0303];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 101) {
        return [self createCellForTableView0301:indexPath];
    } else if (tableView.tag == 102) {
        return [self createCellForTableView0302:indexPath];
    } else {
        return [self createCellForTableView0303:indexPath];
    }
}

- (UITableViewCell *)createCellForTableView0301:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CustomSongCell";
    UITableViewCell *cell = [self.tableView0301 dequeueReusableCellWithIdentifier:cellIdentifier];
    
    BOOL isNight = [NightModeManager sharedManager].isNightMode;
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
        UIImageView *albumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 55, 55)];
        albumImageView.tag = 100;
        albumImageView.layer.cornerRadius = 5;
        albumImageView.layer.masksToBounds = YES;
        albumImageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:albumImageView];
        
        UILabel *songLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, WIDTH - 150, 20)];
        songLabel.tag = 101;
        songLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        [cell.contentView addSubview:songLabel];

        UILabel *artistLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 35, WIDTH - 150, 15)];
        artistLabel.tag = 102;
        artistLabel.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:artistLabel];

        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        playButton.frame = CGRectMake(WIDTH - 45, 20, 30, 30);
        playButton.tag = 103;
        [playButton setImage:[UIImage imageNamed:@"bofang.png"] forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(playButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:playButton];
    }

    [self updateCellAppearance:cell isNight:isNight];

    NSArray* array01 = @[@"董小姐", @"Hate Me", @"野孩子"];
    NSArray* array011 = @[@"宋冬野 - 安河桥北", @"two - Hate Me", @"杨千嬅"];
    NSArray* imageNames = @[@"011", @"012", @"013"];
    
    UIImageView *albumImageView = [cell.contentView viewWithTag:100];
    albumImageView.image = [UIImage imageNamed:imageNames[indexPath.row]];
    
    UILabel *songLabel = [cell.contentView viewWithTag:101];
    songLabel.text = array01[indexPath.row];
    
    UILabel *artistLabel = [cell.contentView viewWithTag:102];
    artistLabel.text = array011[indexPath.row];
    
    return cell;
}

- (UITableViewCell *)createCellForTableView0302:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CustomSongCell";
    UITableViewCell *cell = [self.tableView0302 dequeueReusableCellWithIdentifier:cellIdentifier];
    
    BOOL isNight = [NightModeManager sharedManager].isNightMode;
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

        [cell.imageView removeFromSuperview];
        [cell.textLabel removeFromSuperview];
        [cell.detailTextLabel removeFromSuperview];

        UIImageView *albumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 55, 55)];
        albumImageView.tag = 100;
        albumImageView.layer.cornerRadius = 5;
        albumImageView.layer.masksToBounds = YES;
        albumImageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:albumImageView];

        UILabel *songLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, WIDTH - 150, 20)];
        songLabel.tag = 101;
        songLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        [cell.contentView addSubview:songLabel];

        UILabel *artistLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 35, WIDTH - 150, 15)];
        artistLabel.tag = 102;
        artistLabel.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:artistLabel];

        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        playButton.frame = CGRectMake(WIDTH - 45, 20, 30, 30);
        playButton.tag = 103;
        [playButton setImage:[UIImage imageNamed:@"bofang.png"] forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(playButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:playButton];
    }

    [self updateCellAppearance:cell isNight:isNight];

    NSArray* array02 = @[@"程艾影", @"我记得", @"遇见"];
    NSArray* array022 = @[@"赵雷", @"赵雷", @"孙燕姿"];
    NSArray* imageNames = @[@"IU.jpg", @"IU.jpg", @"IU.jpg"];
    
    UIImageView *albumImageView = [cell.contentView viewWithTag:100];
    albumImageView.image = [UIImage imageNamed:imageNames[indexPath.row]];
    
    UILabel *songLabel = [cell.contentView viewWithTag:101];
    songLabel.text = array02[indexPath.row];
    
    UILabel *artistLabel = [cell.contentView viewWithTag:102];
    artistLabel.text = array022[indexPath.row];
    
    return cell;
}


- (UITableViewCell *)createCellForTableView0303:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CustomSongCell";
    UITableViewCell *cell = [self.tableView0303 dequeueReusableCellWithIdentifier:cellIdentifier];
    
    BOOL isNight = [NightModeManager sharedManager].isNightMode;
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

        [cell.imageView removeFromSuperview];
        [cell.textLabel removeFromSuperview];
        [cell.detailTextLabel removeFromSuperview];
        UIImageView *albumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 55, 55)];
        albumImageView.tag = 100;
        albumImageView.layer.cornerRadius = 5;
        albumImageView.layer.masksToBounds = YES;
        albumImageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:albumImageView];

        UILabel *songLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, WIDTH - 150, 20)];
        songLabel.tag = 101;
        songLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        [cell.contentView addSubview:songLabel];

        UILabel *artistLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 35, WIDTH - 150, 15)];
        artistLabel.tag = 102;
        artistLabel.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:artistLabel];

        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        playButton.frame = CGRectMake(WIDTH - 45, 20, 30, 30);
        playButton.tag = 103;
        [playButton setImage:[UIImage imageNamed:@"bofang.png"] forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(playButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:playButton];
    }
    
    [self updateCellAppearance:cell isNight:isNight];

    NSArray* array03 = @[@"Blueming", @"Celebrity", @"唯一"];
    NSArray* array033 = @[@"IU", @"IU", @"IU"];
    NSArray* imageNames = @[@"IU.jpg", @"IU.jpg", @"IU.jpg"];
    
    UIImageView *albumImageView = [cell.contentView viewWithTag:100];
    albumImageView.image = [UIImage imageNamed:imageNames[indexPath.row]];
    
    UILabel *songLabel = [cell.contentView viewWithTag:101];
    songLabel.text = array03[indexPath.row];
    
    UILabel *artistLabel = [cell.contentView viewWithTag:102];
    artistLabel.text = array033[indexPath.row];
    
    return cell;
}




// ----------------------------------------------



- (void)updateCellAppearance:(UITableViewCell *)cell isNight:(BOOL)isNight {

    cell.backgroundColor = isNight ? [UIColor blackColor] : [UIColor whiteColor];
    cell.contentView.backgroundColor = isNight ? [UIColor blackColor] : [UIColor whiteColor];
    
    UILabel *songLabel = [cell.contentView viewWithTag:101];
    if (songLabel && [songLabel isKindOfClass:[UILabel class]]) {
        songLabel.textColor = isNight ? [UIColor whiteColor] : [UIColor blackColor];
    }

    UILabel *artistLabel = [cell.contentView viewWithTag:102];
    if (artistLabel && [artistLabel isKindOfClass:[UILabel class]]) {
        artistLabel.textColor = isNight ? [UIColor lightGrayColor] : [UIColor grayColor];
    }

    UIButton *playButton = [cell.contentView viewWithTag:103];
    if (playButton && [playButton isKindOfClass:[UIButton class]]) {
        playButton.tintColor = isNight ? [UIColor whiteColor] : [UIColor blackColor];
    }
}

//解除监听
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)updateAppearance {
    BOOL isNight = [NightModeManager sharedManager].isNightMode;
 //   dispatch_async(dispatch_get_main_queue(), ^{
        self.contentView.backgroundColor = isNight ? [UIColor blackColor] : [UIColor whiteColor];
        self.backgroundColor = isNight ? [UIColor blackColor] : [UIColor whiteColor];

        if (self.label03) {
            self.label03.textColor = isNight ? [UIColor whiteColor] : [UIColor blackColor];
        }
        if (self.label02) {
            self.label02.textColor = isNight ? [UIColor lightGrayColor] : [UIColor darkGrayColor];
        }
        
        if (self.label2) {
            self.label2.textColor = isNight ? [UIColor lightGrayColor] : [UIColor whiteColor];
        }

        if (self.page) {
            self.page.pageIndicatorTintColor = isNight ? [UIColor darkGrayColor] : [UIColor lightGrayColor];
            self.page.currentPageIndicatorTintColor = isNight ? [UIColor whiteColor] : [UIColor blackColor];
        }
        [self updateTableViewAppearance];
}

- (void)updatePosterAppearance:(BOOL)isNight {
    self.scrollView.backgroundColor = isNight ? [UIColor blackColor] : [UIColor whiteColor];
    for (UIView *subview in self.scrollView.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            subview.backgroundColor = isNight ? [UIColor blackColor] : [UIColor whiteColor];
        }
    }
}


- (void)updateTableViewAppearance {
    BOOL isNight = [NightModeManager sharedManager].isNightMode;
//    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *tables = [NSMutableArray array];
        if (self.tableView0301) [tables addObject:self.tableView0301];
        if (self.tableView0302) [tables addObject:self.tableView0302];
        if (self.tableView0303) [tables addObject:self.tableView0303];
        
        for (UITableView *tableView in tables) {
            if (!tableView || ![tableView isKindOfClass:[UITableView class]]) continue;
            tableView.backgroundColor = isNight ? [UIColor blackColor] : [UIColor whiteColor];
            NSArray *visibleCells = tableView.visibleCells;
            if (!visibleCells || visibleCells.count == 0) continue;
            
            for (UITableViewCell *cell in visibleCells) {
                if (!cell || ![cell isKindOfClass:[UITableViewCell class]]) continue;

                cell.backgroundColor = isNight ? [UIColor colorWithWhite:0.1 alpha:1.0] : [UIColor whiteColor];
                cell.contentView.backgroundColor = isNight ? [UIColor colorWithWhite:0.1 alpha:1.0] : [UIColor whiteColor];
                UIView *contentView = cell.contentView;
                UILabel *songLabel = nil;
                if ([contentView viewWithTag:101]) {
                    UIView *view = [contentView viewWithTag:101];
                    if ([view isKindOfClass:[UILabel class]]) {
                        songLabel = (UILabel *)view;
                    }
                }

                UILabel *artistLabel = nil;
                if ([contentView viewWithTag:102]) {
                    UIView *view = [contentView viewWithTag:102];
                    if ([view isKindOfClass:[UILabel class]]) {
                        artistLabel = (UILabel *)view;
                    }
                }
                UIButton *playButton = nil;
                if ([contentView viewWithTag:103]) {
                    UIView *view = [contentView viewWithTag:103];
                    if ([view isKindOfClass:[UIButton class]]) {
                        playButton = (UIButton *)view;
                    }
                }
                if (songLabel) {
                    songLabel.textColor = isNight ? [UIColor whiteColor] : [UIColor blackColor];
                }
                
                if (artistLabel) {
                    artistLabel.textColor = isNight ? [UIColor lightGrayColor] : [UIColor darkGrayColor];
                }
                
                if (playButton) {
                    playButton.tintColor = isNight ? [UIColor whiteColor] : [UIColor blackColor];
                }
            }
            
        }
 //   });
}

- (void)configureWithSongTitle:(nonnull NSString *)title albumInfo:(nonnull NSString *)info imageName:(nonnull NSString *)imageName {
}


- (void)playButtonTapped:(UIButton *)sender {
    UIView *contentView = sender.superview;
    UITableViewCell *cell = (UITableViewCell *)contentView.superview;
    UILabel *songLabel = [contentView viewWithTag:101];
    UILabel *artistLabel = [contentView viewWithTag:102];

    NSString *songName = songLabel.text;
    NSString *artistName = artistLabel.text;
    NSLog(@"用户点击播放：%@ - %@", songName, artistName);

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"mp3"];
    if (filePath) {
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        NSError *error = nil;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
        if (!error) {
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
        } else {
            NSLog(@"真该死", error.localizedDescription);
        }
    } else {
        NSLog(@"去他吗的");
    }
}
@end
