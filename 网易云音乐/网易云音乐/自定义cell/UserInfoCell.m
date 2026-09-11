//
//  UserInfoCell.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/6/20.
//

#import "UserInfoCell.h"
#import "MyVC.h"
#import "PhotoWallVC.h"

@implementation UserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews {

    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 155, -30, 90, 90)];
    _avatarImageView.layer.cornerRadius = 45;
    _avatarImageView.image = [UIImage imageNamed:@"avater"];
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _avatarImageView.layer.borderWidth = 2.0;
    _avatarImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarTapped:)];
    [_avatarImageView addGestureRecognizer:tapGesture];
    
    [self.contentView addSubview:_avatarImageView];

    _vipLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 70, 60, 25)];
    _vipLabel.textColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.2 alpha:1.0];
    _vipLabel.font = [UIFont boldSystemFontOfSize:12];
    _vipLabel.textAlignment = NSTextAlignmentCenter;
    _vipLabel.backgroundColor = [UIColor blackColor];
    _vipLabel.layer.cornerRadius = 12;
    _vipLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:_vipLabel];

    _usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 70, self.contentView.bounds.size.width, 30)];
    _usernameLabel.textColor = [UIColor whiteColor];
    _usernameLabel.font = [UIFont boldSystemFontOfSize:20];
    _usernameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_usernameLabel];

    _bioLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.contentView.bounds.size.width, 25)];
    _bioLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    _bioLabel.font = [UIFont systemFontOfSize:15];
    _bioLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_bioLabel];

    _statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _statusButton.frame = CGRectMake(150, -60, 100, 24);
    [_statusButton setTitle:@"+添加状态" forState:UIControlStateNormal];
    [_statusButton setTitleColor:[UIColor systemMintColor] forState:UIControlStateNormal];
    _statusButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _statusButton.layer.borderColor = [UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:1.0].CGColor;
    _statusButton.layer.borderWidth = 0;
    _statusButton.layer.cornerRadius = 12;
    [self.contentView addSubview:_statusButton];

    _statsView = [[UIView alloc] initWithFrame:CGRectMake(80, 130, self.contentView.bounds.size.width - 60, 50)];
    [self.contentView addSubview:_statsView];
    
    NSArray *statTitles = @[@"33\n关注", @"8\n粉丝", @"Lv.9\n等级", @"1641\n时长"];
    CGFloat statWidth = _statsView.bounds.size.width / statTitles.count;
    
    for (int i = 0; i < statTitles.count; i++) {
        UILabel *statLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * statWidth, 0, statWidth, 50)];
        statLabel.text = statTitles[i];
        statLabel.numberOfLines = 2;
        statLabel.textColor = [UIColor whiteColor];
        statLabel.font = [UIFont systemFontOfSize:14];
        statLabel.textAlignment = NSTextAlignmentCenter;
        [_statsView addSubview:statLabel];
    }

    _badgeView = [[UIView alloc] initWithFrame:CGRectMake(100, 190, 200, 30)];
    _badgeView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.15];
    _badgeView.layer.cornerRadius = 10;
    [self.contentView addSubview:_badgeView];
    
    UILabel *badgeDesc = [[UILabel alloc] initWithFrame:CGRectMake(14, 3, 300, 20)];
    badgeDesc.text = @"♂ | 日常摸鱼中 | 黑胶收藏者";
    badgeDesc.textColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    badgeDesc.font = [UIFont systemFontOfSize:14];
    [_badgeView addSubview:badgeDesc];
}

- (void)avatarTapped:(UITapGestureRecognizer *)gesture {
    NSLog(@"头像被点击");
    if ([self.delegate respondsToSelector:@selector(didTapAvatarInCell:)]) {
        [self.delegate didTapAvatarInCell:self];
    }
}

- (void)setAvatarImageView:(UIImageView *)avatarImageView {
    _avatarImageView.image = avatarImageView;
}

@end
