
//  DetailViewController.m
//  天气难报
//
//  Created by 吴桐 on 2025/7/23.
//

#import "DetailViewController.h"
#import "NetworkManager.h"

@interface DetailViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *tempLabel;
@property (nonatomic, strong) UIImageView *weatherIcon;
@property (nonatomic, strong) UILabel *conditionLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupWeatherData];
    [self fetchData];
}

#pragma mark - 从api请求数据部分======================================================

-(void) fetchData {
    [[NetworkManager sharedManager] fetchCityForecast:self.cityName days:7 completion:^(NSDictionary * _Nullable weatherData, NSError * _Nullable error) {
        if (error) {
            NSLog(@"获取天气预报数据失败");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.weatherData = weatherData;
            NSLog(@"%@",weatherData);
            [self setupWeatherData];
            [self setupDailyForecastData];
            [self setupHourlyForecastData];
        });
        /*
         分别显示基本天气
         每日天气
         每小时天气
         */

    }];
}

- (void)setupHourlyForecastData {
    NSArray *forecastDays = self.weatherData[@"forecast"][@"forecastday"];
    NSMutableArray *allHours = [NSMutableArray array];
    for (NSDictionary *day in forecastDays) {
        [allHours addObjectsFromArray:day[@"hour"]];
    }
    if (allHours.count == 0) return;
    
    UIScrollView *scrollView = [[self.contentView viewWithTag:1000] viewWithTag:1001];
    CGFloat Width = 60;
    CGFloat Hight = 10;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH";
    NSString *nowHour = [formatter stringFromDate:[NSDate date]];
    NSInteger startIndex = 0;
    for (NSInteger i = 0; i < allHours.count; i++) {
        NSString *hourStr = [allHours[i][@"time"] substringToIndex:13];
        if ([hourStr isEqualToString:nowHour]) {
            startIndex = i;
            break;
        }
    }
    /* 如果数据不够，那就显示已有的最多数据否则就显示未来24小时
    这个操作可以防止数株越界
     */
    NSInteger count = MIN(24, allHours.count - startIndex);
    for (NSInteger i = 0; i < count; i++) {
        NSDictionary *hour = allHours[startIndex + i];
        UIView *hourView = [[UIView alloc] initWithFrame:CGRectMake(i * (Width + Hight), 0, Width, 70)];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, 20)];
        timeLabel.text = [hour[@"time"] substringFromIndex:11];
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [hourView addSubview:timeLabel];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 40, 30)];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        [self loadIcon:[NSString stringWithFormat:@"https:%@", hour[@"condition"][@"icon"]] forImageView:icon];
        [hourView addSubview:icon];
        
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, Width, 20)];
        tempLabel.text = [NSString stringWithFormat:@"%.0f°", [hour[@"temp_c"] floatValue]];
        tempLabel.font = [UIFont systemFontOfSize:12];
        tempLabel.textColor = [UIColor whiteColor];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        [hourView addSubview:tempLabel];
        [scrollView addSubview:hourView];
    }
    scrollView.contentSize = CGSizeMake((Width + Hight) * count, 70);
}

- (void)setupWeatherData {
    [self setBackgroundBasedOnWeather];
    NSDictionary *current = self.weatherData[@"current"];
    NSDictionary *condition = current[@"condition"];
    NSDictionary *location = self.weatherData[@"location"];
    
    self.cityLabel.text = self.cityName ?: location[@"name"];
    self.tempLabel.text = [NSString stringWithFormat:@"%.0f℃", [current[@"temp_c"] floatValue]];
    self.conditionLabel.text = condition[@"text"];
    self.feelsLikeLabel.text = [NSString stringWithFormat:@"体感温度: %.0f℃", [current[@"feelslike_c"] floatValue]];

    NSString *iconUrl = [NSString stringWithFormat:@"https:%@", condition[@"icon"]];
    [self loadIcon:iconUrl forImageView:self.weatherIcon];

    UILabel *humidityLabel = [self.view viewWithTag:100];
    humidityLabel.text = [NSString stringWithFormat:@"%.0f%%", [current[@"humidity"] floatValue]];
    UILabel *windLabel = [self.view viewWithTag:101];
    windLabel.text = [NSString stringWithFormat:@"%.1f km/h", [current[@"wind_kph"] floatValue]];
    UILabel *feelsLikeLabel = [self.view viewWithTag:102];
    feelsLikeLabel.text = [NSString stringWithFormat:@"%.0f℃", [current[@"feelslike_c"] floatValue]];
    UILabel *pressureLabel = [self.view viewWithTag:103];
    pressureLabel.text = [NSString stringWithFormat:@"%.0f hPa", [current[@"pressure_mb"] floatValue]];
    UILabel *uvLabel = [self.view viewWithTag:104];
    uvLabel.text = [NSString stringWithFormat:@"%.1f", [current[@"uv"] floatValue]];
    UILabel *visLabel = [self.view viewWithTag:105];
    visLabel.text = [NSString stringWithFormat:@"%.1f km", [current[@"vis_km"] floatValue]];

    NSDictionary *forecastDay = self.weatherData[@"forecast"][@"forecastday"][0];
    NSDictionary *astro = forecastDay[@"astro"];
    UILabel *sunriseLabel = [self.view viewWithTag:200];
    sunriseLabel.text = astro[@"sunrise"];
    UILabel *sunsetLabel = [self.view viewWithTag:201];
    sunsetLabel.text = astro[@"sunset"];
    UILabel *moonriseLabel = [self.view viewWithTag:202];
    moonriseLabel.text = astro[@"moonrise"];
    UILabel *moonsetLabel = [self.view viewWithTag:203];
    moonsetLabel.text = astro[@"moonset"];

    UILabel *airLabel = [self.view viewWithTag:9001];
    NSDictionary *air = self.weatherData[@"current"][@"air_quality"];
    NSInteger epaIndex = [air[@"us-epa-index"] integerValue];
    NSString *epaLevel = @[@"优", @"良", @"轻度污染", @"中度污染", @"重度污染", @"严重污染"][
        (epaIndex >=1 && epaIndex <=6) ? epaIndex - 1 : 0
    ];
    airLabel.text = [NSString stringWithFormat:@"PM2.5：%.1f μg/m³\nPM10：%.1f μg/m³\n空气质量等级：%@（EPA指数：%ld）",
                    [air[@"pm2_5"] floatValue],
                    [air[@"pm10"] floatValue],
                    epaLevel,
                    (long)epaIndex];
}

- (void)setupDailyForecastData {
    NSArray *forecastDays = self.weatherData[@"forecast"][@"forecastday"];
    for (int i = 0; i < MIN(7, forecastDays.count); i++) {
        NSDictionary *day = forecastDays[i];
        NSDictionary *dayData = day[@"day"];
        UILabel *dateLabel = [self.contentView viewWithTag:300 + i];
        dateLabel.text = [self formatDate:day[@"date"]];
        UIImageView *icon = [self.contentView viewWithTag:400 + i];
        NSString *iconUrl = [NSString stringWithFormat:@"https:%@", dayData[@"condition"][@"icon"]];
        [self loadIcon:iconUrl forImageView:icon];
        UILabel *maxTempLabel = [self.contentView viewWithTag:500 + i];
        maxTempLabel.text = [NSString stringWithFormat:@"%.0f°", [dayData[@"maxtemp_c"] floatValue]];
        UILabel *minTempLabel = [self.contentView viewWithTag:600 + i];
        minTempLabel.text = [NSString stringWithFormat:@"%.0f°", [dayData[@"mintemp_c"] floatValue]];
    }
}

//日期字符串转换为周几
- (NSString *)formatDate:(NSString *)dateString {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    inputFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [inputFormatter dateFromString:dateString];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    outputFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    outputFormatter.dateFormat = @"EEE";
    return [outputFormatter stringFromDate:date];
}

- (void)loadIcon:(NSString *)urlString forImageView:(UIImageView *)imageView {
    [[NetworkManager sharedManager] loadImageWithURL:urlString completion:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (error) {
            NSLog(@"加载图片失败");
            return;
        }
        
        if (image) {
            imageView.image = image;
        }
    }];
}

#pragma mark - UI内容 五个卡片和背景-------------------------------------------------------------

- (void)setupUI {
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.clipsToBounds = YES;
    [self.view addSubview:self.backgroundImageView];
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.bounds];
    overlay.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self.view addSubview:overlay];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 420, 844)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1500)];
    [self.scrollView addSubview:self.contentView];
    self.scrollView.contentSize = self.contentView.frame.size;

    if (self.canAddCity) {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [addBtn setImage:[UIImage systemImageNamed:@"plus"] forState:UIControlStateNormal];
        addBtn.frame = CGRectMake(self.view.bounds.size.width - 60, 50, 40, 40);
        addBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [addBtn setTintColor:[UIColor whiteColor]];
        [addBtn addTarget:self action:@selector(addCity) forControlEvents:UIControlEventTouchUpInside];
        addBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
        addBtn.layer.cornerRadius = 20;
        addBtn.clipsToBounds = YES;
        [self.scrollView addSubview:addBtn];
    } else {
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [deleteBtn setImage:[UIImage systemImageNamed:@"trash"] forState:UIControlStateNormal];
        deleteBtn.frame = CGRectMake(self.view.bounds.size.width - 60, 50, 40, 40);
        deleteBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [deleteBtn setTintColor:[UIColor whiteColor]];
        [deleteBtn addTarget:self action:@selector(deleteCity) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
        deleteBtn.layer.cornerRadius = 20;
        deleteBtn.clipsToBounds = YES;
        [self.scrollView addSubview:deleteBtn];
    }
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeBtn setImage:[UIImage systemImageNamed:@"xmark"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(20, 50, 40, 40);
    [closeBtn setTintColor:[UIColor whiteColor]];
    [closeBtn addTarget:self action:@selector(closeDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:closeBtn];

    self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 40)];
    self.cityLabel.font = [UIFont systemFontOfSize:32 weight:UIFontWeightBold];
    self.cityLabel.textColor = [UIColor whiteColor];
    self.cityLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.cityLabel];

    self.weatherIcon = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 120)/2, 150, 120, 120)];
    self.weatherIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.weatherIcon];

    self.tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, self.view.bounds.size.width, 80)];
    self.tempLabel.font = [UIFont systemFontOfSize:72 weight:UIFontWeightThin];
    self.tempLabel.textColor = [UIColor whiteColor];
    self.tempLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.tempLabel];

    self.conditionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 370, self.view.bounds.size.width - 40, 30)];
    self.conditionLabel.font = [UIFont systemFontOfSize:20];
    self.conditionLabel.textColor = [UIColor whiteColor];
    self.conditionLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.conditionLabel];

    self.feelsLikeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 410, self.view.bounds.size.width - 40, 30)];
    self.feelsLikeLabel.font = [UIFont systemFontOfSize:18];
    self.feelsLikeLabel.textColor = [UIColor whiteColor];
    self.feelsLikeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.feelsLikeLabel];

    [self addWeatherDetailsCard];
    [self addHourlyForecastCard];
    [self addDailyForecastCard];
    [self addAstroCard];
    [self addAirQualityCard];
}

/*
 这两个方法用来简化卡片和标题的创建，属于一种小工厂模式。？
 */
- (UIView *)createCardViewWithFrame:(CGRect)frame {
    UIView *card = [[UIView alloc] initWithFrame:frame];
    card.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    card.layer.cornerRadius = 20;
    card.layer.borderWidth = 1;
    card.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.3].CGColor;
    return card;
}

- (UILabel *)createSectionTitleLabel:(NSString *)title frame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    label.textColor = [UIColor whiteColor];
    return label;
}

/*
 在这五个add中，先初始化ui
 但是先不赋值（也就是不会显示真实值），在前面的部分（pragma mark里标注了信息请求的部分）请求到数据后，再去把请求到的真实数据填入
 */

- (void)addWeatherDetailsCard {
    UIView *card = [self createCardViewWithFrame:CGRectMake(20, 450, self.view.bounds.size.width - 40, 200)];
    [self.contentView addSubview:card];
    UILabel *title = [self createSectionTitleLabel:@"天气详情" frame:CGRectMake(20, 20, card.bounds.size.width - 40, 30)];
    [card addSubview:title];
    NSArray *details = @[
        @{@"title": @"湿度", @"value": @"--%", @"tag": @100},
        @{@"title": @"风速", @"value": @"-- km/h", @"tag": @101},
        @{@"title": @"体感温度", @"value": @"--℃", @"tag": @102},
        @{@"title": @"气压", @"value": @"-- hPa", @"tag": @103},
        @{@"title": @"紫外线指数", @"value": @"--", @"tag": @104},
        @{@"title": @"能见度", @"value": @"-- km", @"tag": @105}
    ];
    for (int i = 0; i < details.count; i++) {
        NSDictionary *detail = details[i];
        CGFloat x = (i % 2 == 0) ? 20 : card.bounds.size.width/2 + 10;
        CGFloat y = 60 + (i/2) * 45;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 120, 20)];
        titleLabel.text = detail[@"title"];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor whiteColor];
        [card addSubview:titleLabel];
        
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y + 20, 120, 20)];
        valueLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        valueLabel.textColor = [UIColor whiteColor];
        valueLabel.tag = [detail[@"tag"] integerValue];
        [card addSubview:valueLabel];
    }
}

- (void)addHourlyForecastCard {
    UIView *card = [self createCardViewWithFrame:CGRectMake(20, 670, self.view.bounds.size.width - 40, 150)];
    card.tag = 1000;
    [self.contentView addSubview:card];
    
    UILabel *title = [self createSectionTitleLabel:@"小时预报" frame:CGRectMake(20, 20, card.bounds.size.width - 40, 30)];
    [card addSubview:title];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 60, card.bounds.size.width - 30, 70)];
    scrollView.tag = 1001;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(1000, 70);
    [card addSubview:scrollView];
}

- (void)addDailyForecastCard {
    UIView *card = [self createCardViewWithFrame:CGRectMake(20, 840, self.view.bounds.size.width - 40, 300)];
    [self.contentView addSubview:card];
    
    UILabel *title = [self createSectionTitleLabel:@"7日预报" frame:CGRectMake(20, 20, card.bounds.size.width - 40, 30)];
    [card addSubview:title];
    for (int i = 0; i < 7; i++) {
        CGFloat y = 60 + i * 35;

        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, y, 80, 30)];
        dateLabel.text = @"日期";
        dateLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.tag = 300 + i;
        [card addSubview:dateLabel];

        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(110, y, 30, 30)];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        icon.tag = 400 + i;
        [card addSubview:icon];

        UILabel *maxTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(card.bounds.size.width - 100, y, 40, 30)];
        maxTempLabel.text = @"--°";
        maxTempLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        maxTempLabel.textColor = [UIColor whiteColor];
        maxTempLabel.tag = 500 + i;
        [card addSubview:maxTempLabel];

        UILabel *minTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(card.bounds.size.width - 50, y, 40, 30)];
        minTempLabel.text = @"--°";
        minTempLabel.font = [UIFont systemFontOfSize:16];
        minTempLabel.textColor = [UIColor colorWithWhite:1 alpha:0.7];
        minTempLabel.tag = 600 + i;
        [card addSubview:minTempLabel];
    }
}

- (void)addAstroCard {
    UIView *card = [self createCardViewWithFrame:CGRectMake(20, 1160, self.view.bounds.size.width - 40, 150)];
    [self.contentView addSubview:card];
    
    UILabel *title = [self createSectionTitleLabel:@"天文信息" frame:CGRectMake(20, 20, card.bounds.size.width - 40, 30)];
    [card addSubview:title];
    
    NSArray *astroItems = @[
        @{@"title": @"日出", @"value": @"--:--", @"tag": @200},
        @{@"title": @"日落", @"value": @"--:--", @"tag": @201},
        @{@"title": @"月出", @"value": @"--:--", @"tag": @202},
        @{@"title": @"月落", @"value": @"--:--", @"tag": @203}
    ];
    
    for (int i = 0; i < astroItems.count; i++) {
        NSDictionary *item = astroItems[i];
        CGFloat x = 20 + (i % 2) * (card.bounds.size.width / 2);
        CGFloat y = 60 + (i / 2) * 45;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 60, 20)];
        titleLabel.text = item[@"title"];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor whiteColor];
        [card addSubview:titleLabel];
        
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + 70, y, 100, 20)];
        valueLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        valueLabel.textColor = [UIColor whiteColor];
        valueLabel.tag = [item[@"tag"] integerValue];
        [card addSubview:valueLabel];
    }
}

- (void)addAirQualityCard {
    UIView *card = [self createCardViewWithFrame:CGRectMake(20, 1320, self.view.bounds.size.width - 40, 150)];
    [self.contentView addSubview:card];

    UILabel *title = [self createSectionTitleLabel:@"空气质量" frame:CGRectMake(20, 20, card.bounds.size.width - 40, 30)];
    [card addSubview:title];

    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, card.bounds.size.width - 40, 70)];
    infoLabel.numberOfLines = 0;
    infoLabel.font = [UIFont systemFontOfSize:16];
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.tag = 9001;
    [card addSubview:infoLabel];
}

- (void)setBackgroundBasedOnWeather {
    if (!self.weatherData) return;
    
    NSDictionary *current = self.weatherData[@"current"];
    NSDictionary *condition = current[@"condition"];
    NSInteger code = [condition[@"code"] integerValue];
    NSString *bgImageName;
    if (code == 1000) {
        bgImageName = @"pic1.jpg";
    } else if (code >= 1003 && code <= 1009) {
        bgImageName = @"pic2.jpg";
    } else if ((code >= 1063 && code <= 1087) || (code >= 1150 && code <= 1195) || (code >= 1240 && code <= 1246)) {
        bgImageName = @"pic3.jpg";
    } else if ((code >= 1066 && code <= 1074) || (code >= 1114 && code <= 1237)) {
        bgImageName = @"pic4.jpg";
    } else if (code >= 1273 && code <= 1282) {
        bgImageName = @"pic5.jpg";
    } else {
        bgImageName = @"pic1.jpg";
    }

    self.backgroundImageView.image = [UIImage imageNamed:bgImageName];
}

#pragma mark - 导航栏消失🫠 ，退出页面及增删城市-------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)closeDetail {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addCity {
    NSDictionary *userInfo = @{@"cityName": self.cityName};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNewCityNotification" object:nil userInfo:userInfo];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)deleteCity {
    NSDictionary *userInfo = @{@"cityName": self.cityName};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteCityNotification"
                                                        object:nil
                                                      userInfo:userInfo];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
