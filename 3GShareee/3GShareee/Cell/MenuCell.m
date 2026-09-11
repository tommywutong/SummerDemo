//
//  MenuCell.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/18.
//

#import "MenuCell.h"

@implementation MenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 15;
    _iconImageView.frame = CGRectMake(padding, (self.bounds.size.height - 24) / 2, 24, 24);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 15, 0, 200, self.bounds.size.height);
}

- (void)configureWithIcon:(UIImage *)icon title:(NSString *)title {
    _iconImageView.image = icon;
    _titleLabel.text = title;
}

@end
