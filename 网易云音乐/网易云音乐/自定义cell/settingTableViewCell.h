//
//  settingTableViewCell.h
//  网易云音乐
//
//  Created by 吴桐 on 2025/7/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface settingTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@property (strong, nonatomic) UIView *badgeView;
@property (strong, nonatomic) UILabel *badgeLabel;
@property (nonatomic, strong) NSArray<NSDictionary *> *modeItems;
@property (strong, nonatomic) UIView *userCardView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *usernameLabel;

@property (strong, nonatomic) UIImageView* picture;
@property (strong, nonatomic) UIImageView* arrowImageView;
@property (strong, nonatomic) UILabel *studentTitle;
@property (strong, nonatomic) UILabel *svipBadge;
@property (strong, nonatomic) UIView *doubleSpaceCard;
@property (strong, nonatomic) UILabel *spaceTitle;
@property (strong, nonatomic) UILabel *spaceDesc;

@property (strong, nonatomic) UIImageView *nightIcon;
@property (strong, nonatomic) UILabel *nightLabel;
@property (strong, nonatomic) UISwitch *nightSwitch;

- (void)configureWithIcon:(NSString *)iconName
                   title:(NSString *)title
                subtitle:(NSString *)subtitle
                   badge:(NSString *)badge;

@end

NS_ASSUME_NONNULL_END
