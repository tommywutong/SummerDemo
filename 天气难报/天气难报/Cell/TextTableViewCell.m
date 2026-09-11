//
//  textTableViewCell.m
//  天气难报
//
//  Created by 吴桐 on 2025/7/23.
//
#import "TextTableViewCell.h"
#import "NetworkManager.h"

@implementation TextTableViewCell

/*
 从这个cell开始使用layer，尝试实现了如圆角、阴影、图片裁剪填充、半透明等效果
 同时，使用CALayer可以提升性能
 */

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 366, 100)];
        _backgroundImageView.layer.masksToBounds = YES;
        _backgroundImageView.layer.cornerRadius = 10;
        _backgroundImageView.layer.contentsGravity = kCAGravityResizeAspectFill;
        [self.contentView addSubview:_backgroundImageView];
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 150, 30)];
        _cityLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
        _cityLabel.textColor = [UIColor whiteColor];
        _cityLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        _cityLabel.layer.shadowOffset = CGSizeMake(0, 1);
        _cityLabel.layer.shadowOpacity = 0.8;
        _cityLabel.layer.shadowRadius = 1;
        [self.contentView addSubview:_cityLabel];
        _tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 55, 150, 30)];
        _tempLabel.textColor = [UIColor whiteColor];
        _tempLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        _tempLabel.layer.shadowOffset = CGSizeMake(0, 1);
        _tempLabel.layer.shadowOpacity = 0.8;
        _tempLabel.layer.shadowRadius = 1;
        [self.contentView addSubview:_tempLabel];
        _weatherIcon = [[UIImageView alloc] initWithFrame:CGRectMake(290, 25, 50, 50)];
        _weatherIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_weatherIcon];
        UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 366, 100)];
        overlay.layer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25].CGColor;
        overlay.layer.cornerRadius = 10;
        overlay.layer.masksToBounds = YES;
        [self.contentView insertSubview:overlay aboveSubview:_backgroundImageView];
        /*
         加了一个图层？算是蒙版。因为背景会有不同，加一个这个让文字和图标等清晰一些
         */
    }
    return self;
}

- (void)configureWithCity:(NSString *)city
                     temp:(NSString *)temp
          weatherIconURL:(NSString *)iconURL
             conditionCode:(NSInteger)code {

    _cityLabel.text = city;
    _tempLabel.text = temp;
    [self setBackgroundImageForWeatherCode:code];
    //如果不是标准的http，就手动添加，没有这行代码图片信息会获取错误
    if ([iconURL hasPrefix:@"//"]) {
        iconURL = [@"https:" stringByAppendingString:iconURL];
    }
    [[NetworkManager sharedManager] loadImageWithURL:iconURL completion:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (error) {
            NSLog(@"图片加载失败");
            return;
        }
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.weatherIcon.image = image;
            });
        }
    }];
}


- (void)setBackgroundImageForWeatherCode:(NSInteger)code {
    NSString *imageName = @"photo1.jpg";
    if (code == 1000) {
        imageName = @"photo1.jpg";
    }//云
    else if (code >= 1003 && code <= 1009) {
        imageName = @"photo2.jpg";
    }//雨
    else if (code >= 1030 && code <= 1282) {
        imageName = @"photo3.jpg";
    }//雪
    else if (code >= 1066 && code <= 1237) {
        imageName = @"photo4.jpg";
    }//雷
    else if (code >= 1273 && code <= 1282) {
        imageName = @"photo5.jpg";
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self->_backgroundImageView.image = [UIImage imageNamed:imageName];
    });
}

@end
