//
//  HolidayDetailTableViewCell.m
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/16.
//

#import "HolidayDetailTableViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

@implementation HolidayDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _detailImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _detailImageView.contentMode = UIViewContentModeScaleAspectFill;
        _detailImageView.clipsToBounds = YES;
        [self.contentView addSubview:_detailImageView];
    }
    
    self.textName = [[UILabel alloc] init];
    self.textName.font = [UIFont boldSystemFontOfSize: 19];
    self.textName.numberOfLines = 2;
    self.writerName = [[UILabel alloc] init];
    self.writerName.font = [UIFont boldSystemFontOfSize: 15];
    self.writerName.textColor = [UIColor darkGrayColor];
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont boldSystemFontOfSize: 13];
    self.timeLabel.textColor = [UIColor grayColor];
    self.viewingIcon = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"view_icon.png"]];
    self.shareIcon = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"share_icon.png"]];
    
    if ([self.reuseIdentifier isEqualToString: @"textMode"]) {
        self.avater = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"works_head.png"]];
        self.textName.text = @"假日";
        self.writerName.text = @"SHARE 小白";
        self.timeLabel.text = @"15分钟前";
    } else if ([self.reuseIdentifier isEqualToString: @"photoMode"]) {
        self.worksView1 = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"works_img1"]];
        self.worksView2 = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"works_img2"]];
        self.worksView3 = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"works_img3"]];
        self.worksView4 = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"works_img4"]];
        self.artLabel = [[UILabel alloc] init];
        self.artLabel.text = @"多希望列车能我带到有你的城市。";
    }
    
    [self.contentView addSubview: self.avater];
    [self.contentView addSubview: self.textName];
    [self.contentView addSubview: self.writerName];
    [self.contentView addSubview: self.timeLabel];
    [self.contentView addSubview: self.viewingIcon];
    [self.contentView addSubview: self.shareIcon];
    [self.contentView addSubview: self.artLabel];
    [self.contentView addSubview: self.worksView1];
    [self.contentView addSubview: self.worksView2];
    [self.contentView addSubview: self.worksView3];
    [self.contentView addSubview: self.worksView4];
    
    return self;
}

- (void)layoutSubviews {
    self.avater.frame = CGRectMake(10, 10, 80, 80);
    self.textName.frame = CGRectMake(100, 10, 155, 50);
    self.writerName.frame = CGRectMake(100, 40, 155, 50);
    self.timeLabel.frame = CGRectMake(WIDTH - 75, 12, 155, 50);
    self.viewingIcon.frame = CGRectMake(270, 65, 36, 26);
    self.shareIcon.frame = CGRectMake(330, 65, 26, 26);
    
    self.artLabel.frame = CGRectMake(10, -5, 355, 50);
    self.worksView1.frame = CGRectMake(0, 35 + WIDTH * 0.618 * 0, WIDTH, WIDTH * 0.618);
    self.worksView2.frame = CGRectMake(0, 45 + WIDTH * 0.618 * 1, WIDTH, WIDTH * 0.618);
    self.worksView3.frame = CGRectMake(0, 55 + WIDTH * 0.618 * 2, WIDTH + 5, WIDTH / 0.618);
    self.worksView4.frame = CGRectMake(0, 55 + WIDTH * 0.618 * 2 + WIDTH / 0.618 + 10, WIDTH, WIDTH * 0.618);

    self.detailImageView.frame = self.contentView.bounds;
}

- (void)configureWithImage:(UIImage *)image {
    self.detailImageView.image = image;
}

@end
