//
//  settingTableViewCell.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/7/13.
//

#import "settingTableViewCell.h"
#import "NightModeManager.h"
@implementation settingTableViewCell {
    UIImageView *_moonIcon;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        if ([reuseIdentifier isEqualToString:@"user"]) {
            [self setupUserCard];
        }
        else if ([reuseIdentifier isEqualToString:@"heijiao"]) {
            [self setupHeijiaoCard];
        }
        else if ([reuseIdentifier isEqualToString:@"mode"]) {
            [self setupModeCard];
        }
        else if ([reuseIdentifier isEqualToString:@"night"]) {
            [self setupNightMode];
        }
        else {
            [self setupDefaultCell];
        }
        
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                      selector:@selector(updateAppearance)
                                                          name:@"NightModeChangedNotification"
                                                        object:nil];
    return self;
}

- (void)setupUserCard {
    self.contentView.backgroundColor = [UIColor clearColor];
    BOOL isNight = [NightModeManager sharedManager].isNightMode;

    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 50, 50)];
    self.avatarImageView.image = [UIImage imageNamed:@"IIU.jpg"];
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = 25;
    _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _avatarImageView.layer.borderWidth = 2.0;
    _avatarImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.avatarImageView];

    self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 3, 120, 40)];
    self.usernameLabel.text = @"A5pkRd";
    self.usernameLabel.textColor = isNight ? [UIColor whiteColor] : [UIColor blackColor];
    self.usernameLabel.font = [UIFont boldSystemFontOfSize:22];
    [self.contentView addSubview:self.usernameLabel];
}

-(void) setupHeijiaoCard {
    self.contentView.backgroundColor = [UIColor clearColor];
    self.picture = [[UIImageView alloc] initWithFrame:CGRectMake(18, -20, 300, 130)];
    self.picture.image = [UIImage imageNamed:@"svip.jpg"];
    self.picture.layer.cornerRadius = 10;
    self.picture.layer.masksToBounds = YES;
    [self.contentView addSubview:self.picture];
}

- (void)setupModeCard {

    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 30, 30)];
    self.iconView.tintColor = [UIColor darkGrayColor];
    [self.contentView addSubview:self.iconView];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 15, 180, 25)];
    BOOL isNight = [NightModeManager sharedManager].isNightMode;
    self.titleLabel.textColor = isNight ? [UIColor whiteColor] : [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];
    

    self.badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.bounds.size.width - 60, 15, 40, 25)];
    self.badgeLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.badgeLabel.backgroundColor = [UIColor systemRedColor];
    self.badgeLabel.textColor = [UIColor whiteColor];
    self.badgeLabel.font = [UIFont systemFontOfSize:14];
    self.badgeLabel.textAlignment = NSTextAlignmentCenter;
    self.badgeLabel.layer.cornerRadius = 12.5;
    self.badgeLabel.layer.masksToBounds = YES;
    self.badgeLabel.hidden = YES;
    [self.contentView addSubview:self.badgeLabel];
    
    self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.right"]];
    self.arrowImageView.tintColor = [UIColor lightGrayColor];
    self.arrowImageView.frame = CGRectMake(self.contentView.bounds.size.width - 30, 15, 20, 20);
    self.arrowImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview:self.arrowImageView];
}

- (void)configureWithIcon:(NSString *)iconName title:(NSString *)title subtitle:(NSString *)subtitle badge:(NSString *)badge {
    if ([iconName isEqualToString:@"creditcard"]) {
        self.iconView.image = [UIImage systemImageNamed:@"creditcard"];
    } else if ([iconName isEqualToString:@"waveform"]) {
        self.iconView.image = [UIImage systemImageNamed:@"waveform"];
    } else {
        self.iconView.image = [UIImage systemImageNamed:iconName];
    }
    self.titleLabel.text = title;
}

- (void)setupDefaultCell {
    self.textLabel.text = @"默认项";
    self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    
    UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(20, 54.5, self.contentView.bounds.size.width - 40, 0.5)];
    divider.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.contentView addSubview:divider];
}

- (void)setupNightMode {
    BOOL isNight = [NightModeManager sharedManager].isNightMode;

    _moonIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 8, 30, 30)];
    _moonIcon.image = [UIImage systemImageNamed:@"moon.fill"];
    _moonIcon.tintColor = isNight ? [UIColor whiteColor] : [UIColor grayColor];
    [self.contentView addSubview:_moonIcon];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 8, 200, 30)];
    self.titleLabel.text = @"黑夜模式";
    self.titleLabel.textColor = isNight ? [UIColor whiteColor] : [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];

    self.nightSwitch = [[UISwitch alloc] init];
    self.nightSwitch.onTintColor = [UIColor systemBlueColor];
    [self.nightSwitch addTarget:self action:@selector(nightSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.nightSwitch];

    self.nightSwitch.userInteractionEnabled = YES;
    self.nightSwitch.exclusiveTouch = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat switchWidth = self.nightSwitch.bounds.size.width;
    CGFloat switchHeight = self.nightSwitch.bounds.size.height;
    CGFloat contentWidth = self.contentView.bounds.size.width;

    self.nightSwitch.frame = CGRectMake(contentWidth - switchWidth - 20,
                                         (self.contentView.bounds.size.height - switchHeight) / 2,
                                         switchWidth,
                                         switchHeight);
}


- (void)nightSwitchChanged:(UISwitch *)sender {
    BOOL isOn = sender.isOn;
    [[NightModeManager sharedManager] toggleNightMode:isOn];
}

- (void)updateAppearance {
    BOOL isNight = [NightModeManager sharedManager].isNightMode;

    if (isNight) {
        self.contentView.backgroundColor = [UIColor blackColor];
        if (self.titleLabel) self.titleLabel.textColor = [UIColor whiteColor];
        if (self.usernameLabel) self.usernameLabel.textColor = [UIColor whiteColor];
        if (_moonIcon) _moonIcon.tintColor = [UIColor whiteColor];
    } else {
        self.contentView.backgroundColor = [UIColor systemBackgroundColor];
        if (self.titleLabel) self.titleLabel.textColor = [UIColor blackColor];
        if (self.usernameLabel) self.usernameLabel.textColor = [UIColor blackColor];
        if (_moonIcon) _moonIcon.tintColor = [UIColor grayColor];
    }
}

@end
