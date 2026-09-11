//
//  PosterTableViewCell.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/17.
//

#import "PosterTableViewCell.h"

@implementation PosterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _thumbnailImageView = [[UIImageView alloc] init];
    _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    _thumbnailImageView.clipsToBounds = YES;
    _thumbnailImageView.layer.cornerRadius = 8;
    [self.contentView addSubview:_thumbnailImageView];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 2;
    [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 15;
    CGFloat imageHeight = 180;
    CGFloat labelHeight = 50;

    _thumbnailImageView.frame = CGRectMake(padding, padding,
                                          self.contentView.bounds.size.width - padding * 2,
                                          imageHeight);

    _titleLabel.frame = CGRectMake(padding,
                                 CGRectGetMaxY(_thumbnailImageView.frame) + 10,
                                 self.contentView.bounds.size.width - padding * 2,
                                 labelHeight);
}

- (void)configureCellWithImage:(UIImage *)image text:(NSString *)text {
    _thumbnailImageView.image = image;
    _titleLabel.text = text;
}

@end
