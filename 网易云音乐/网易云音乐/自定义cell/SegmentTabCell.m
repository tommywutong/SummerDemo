//
//  SegmentTabCell.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/6/20.
//

#import "SegmentTabCell.h"

@interface SegmentTabCell () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIView *statsContainer;
@property (nonatomic, strong) UILabel *createdLabel;
@property (nonatomic, strong) UILabel *favoritesLabel;
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UIView *underlineView;
@end

@implementation SegmentTabCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    _segmentedControl = [[UISegmentedControl alloc] init];
    _segmentedControl.selectedSegmentTintColor = [UIColor colorWithRed:0.98 green:0.30 blue:0.30 alpha:1.0];
    [_segmentedControl setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [_segmentedControl setBackgroundImage:[UIImage new] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [_segmentedControl setDividerImage:[UIImage new] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIFont *selectedFont = [UIFont boldSystemFontOfSize:16];
    UIFont *normalFont = [UIFont systemFontOfSize:14];
    
    [_segmentedControl setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: selectedFont
    } forState:UIControlStateSelected];
    
    [_segmentedControl setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [UIColor lightGrayColor],
        NSFontAttributeName: normalFont
    } forState:UIControlStateNormal];
    
    [_segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_segmentedControl];
 
    _underlineView = [[UIView alloc] init];
        _underlineView.backgroundColor = [UIColor colorWithRed:0.98 green:0.30 blue:0.30 alpha:1.0];
        [self.contentView addSubview:_underlineView];
    
    _statsContainer = [[UIView alloc] init];
    [self.contentView addSubview:_statsContainer];
    
    _createdLabel = [[UILabel alloc] init];
    _createdLabel.text = @"创建 17";
    _createdLabel.textColor = [UIColor whiteColor];
    _createdLabel.font = [UIFont boldSystemFontOfSize:14];
    [_statsContainer addSubview:_createdLabel];
    
    _favoritesLabel = [[UILabel alloc] init];
    _favoritesLabel.text = @"收藏 20";
    _favoritesLabel.textColor = [UIColor lightGrayColor];
    _favoritesLabel.font = [UIFont systemFontOfSize:14];
    [_statsContainer addSubview:_favoritesLabel];
    
    _contentTableView = [[UITableView alloc] init];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    _contentTableView.backgroundColor = [UIColor clearColor];
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTableView.showsVerticalScrollIndicator = NO;
    _contentTableView.scrollEnabled = NO;
    [self.contentView addSubview:_contentTableView];
    
    [_contentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MusicItemCell"];
}


- (void)setSegmentTitles:(NSArray *)segmentTitles {
    _segmentTitles = segmentTitles;
    [_segmentedControl removeAllSegments];
    
    for (NSInteger i = 0; i < segmentTitles.count; i++) {
        [_segmentedControl insertSegmentWithTitle:segmentTitles[i] atIndex:i animated:NO];
    }
    
    if (segmentTitles.count > 0) {
        _segmentedControl.selectedSegmentIndex = self.selectedIndex;
        
        [self positionUnderlineForSegment:self.selectedIndex animated:NO];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    _segmentedControl.selectedSegmentIndex = selectedIndex;
    [self positionUnderlineForSegment:selectedIndex animated:YES];
    [_contentTableView reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 15.0;
    CGFloat width = self.contentView.bounds.size.width - padding * 2;

    CGFloat segmentedHeight = 40.0;
    _segmentedControl.frame = CGRectMake(padding, padding - 30, width, segmentedHeight);
    
    CGFloat statsHeight = 30.0;
    CGFloat statsY = CGRectGetMaxY(_segmentedControl.frame) + padding;
    _statsContainer.frame = CGRectMake(padding, statsY, width, statsHeight);
    
    _createdLabel.frame = CGRectMake(0, 0, 80, statsHeight);
    _favoritesLabel.frame = CGRectMake(90, 0, 80, statsHeight);
    
    CGFloat tableY = CGRectGetMaxY(_statsContainer.frame) + padding;
    CGFloat tableHeight = self.contentView.bounds.size.height - tableY - padding;
    _contentTableView.frame = CGRectMake(padding, tableY, width, MAX(0, tableHeight));
    
    [self positionUnderlineForSegment:self.selectedIndex animated:NO];
}


- (void)positionUnderlineForSegment:(NSInteger)segmentIndex animated:(BOOL)animated {
    if (self.segmentedControl.numberOfSegments == 0) return;
    
    CGFloat segmentWidth = self.segmentedControl.frame.size.width / self.segmentedControl.numberOfSegments;
    CGFloat underlineX = self.segmentedControl.frame.origin.x + (segmentIndex * segmentWidth) + 10;
    CGFloat underlineY = self.segmentedControl.frame.origin.y + self.segmentedControl.frame.size.height + 3;
    CGFloat underlineWidth = segmentWidth - 20;
    CGFloat underlineHeight = 2.0;
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.underlineView.frame = CGRectMake(underlineX, underlineY, underlineWidth, underlineHeight);
        }];
    } else {
        self.underlineView.frame = CGRectMake(underlineX, underlineY, underlineWidth, underlineHeight);
    }
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    self.selectedIndex = sender.selectedSegmentIndex;
    
    if ([self.delegate respondsToSelector:@selector(segmentTabCell:didSelectSegmentAtIndex:)]) {
        [self.delegate segmentTabCell:self didSelectSegmentAtIndex:sender.selectedSegmentIndex];
    }
    
    [self positionUnderlineForSegment:self.selectedIndex animated:YES];
    
    [_contentTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.selectedIndex) {
        case 0: return self.musicContent.count;
        case 1: return self.podcastContent.count;
        case 2: return self.noteContent.count;
        default: return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicItemCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }

    NSDictionary *item;
    switch (self.selectedIndex) {
        case 0: item = self.musicContent[indexPath.row]; break;
        case 1: item = self.podcastContent[indexPath.row]; break;
        case 2: item = self.noteContent[indexPath.row]; break;
        default: item = nil;
    }
    
    if (!item) return cell;
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 5, tableView.bounds.size.width, 55)];
    container.backgroundColor = [UIColor clearColor];
    container.layer.cornerRadius = 8.0;
    [cell.contentView addSubview:container];

    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 40, 40)];
    icon.layer.cornerRadius = 5.0;
    icon.clipsToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;

    NSString *iconName = item[@"icon"];
    UIImage *image = [self loadImageWithName:iconName];
    
    if (image) {
        icon.image = image;
    } else {
        [self setupErrorIndicatorForIcon:icon];
        if (self.selectedIndex == 0 && indexPath.row == 0) {
            icon.backgroundColor = [UIColor colorWithRed:0.98 green:0.30 blue:0.30 alpha:1.0];
        }
    }
    
    [container addSubview:icon];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 7.5, container.bounds.size.width - 150, 20)];
    titleLabel.text = item[@"title"];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail; // 防止溢出
    [container addSubview:titleLabel];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 27.5, container.bounds.size.width - 150, 20)];
    detailLabel.text = item[@"detail"];
    detailLabel.textColor = [UIColor lightGrayColor];
    detailLabel.font = [UIFont systemFontOfSize:14];
    detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [container addSubview:detailLabel];

    [self setupActionButtonForContainer:container item:item index:indexPath.row];
    
    return cell;
}

- (UIImage *)loadImageWithName:(NSString *)name {
    if (!name) return nil;

    UIImage *image = [UIImage imageNamed:name];
 
    if (!image) {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        if (path) {
            image = [UIImage imageWithContentsOfFile:path];
        }
    }
    
    return image;
}

- (void)setupErrorIndicatorForIcon:(UIImageView *)icon {

    icon.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3];

    UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    errorLabel.text = @"?";
    errorLabel.font = [UIFont boldSystemFontOfSize:24];
    errorLabel.textAlignment = NSTextAlignmentCenter;
    errorLabel.textColor = [UIColor whiteColor];
    [icon addSubview:errorLabel];
}
- (void)setupActionButtonForContainer:(UIView *)container item:(NSDictionary *)item index:(NSInteger)index {
    if (self.selectedIndex == 0 && index == 0) {
        UIButton *heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        heartButton.frame = CGRectMake(container.bounds.size.width - 100, 12.5, 85, 30);
        [heartButton setTitle:@"心动模式" forState:UIControlStateNormal];
        [heartButton setTitleColor:[UIColor colorWithRed:0.98 green:0.30 blue:0.30 alpha:1.0]
                          forState:UIControlStateNormal];
        heartButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        heartButton.layer.borderColor = [UIColor colorWithRed:0.98 green:0.30 blue:0.30 alpha:1.0].CGColor;
        heartButton.layer.borderWidth = 1.0;
        heartButton.layer.cornerRadius = 15.0;
        [container addSubview:heartButton];
    } else {

        UIButton *ellipsisButton = [UIButton buttonWithType:UIButtonTypeCustom];
        ellipsisButton.frame = CGRectMake(container.bounds.size.width - 40, 17.5, 20, 20);

        UIImage *ellipsisImage = [UIImage systemImageNamed:@"ellipsis"];
        if (ellipsisImage) {
            [ellipsisButton setImage:ellipsisImage forState:UIControlStateNormal];
            ellipsisButton.tintColor = [UIColor lightGrayColor];
        } else {
            [ellipsisButton setTitle:@"..." forState:UIControlStateNormal];
            [ellipsisButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
        
        [container addSubview:ellipsisButton];
    }
}

@end
