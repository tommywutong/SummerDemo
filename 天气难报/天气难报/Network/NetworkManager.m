//
//  NetworkManager.m
//  天气难报
//
//  Created by 吴桐 on 2025/7/26.
//

#import "NetworkManager.h"
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

static NSString * const APIKey = @"2db0265c1d084416b9275428252207";
static NSString * const APIURL = @"https://api.weatherapi.com/v1";

@interface NetworkManager ()

@end

@implementation NetworkManager

+ (instancetype)sharedManager {
    static NetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

/*
 URLString（NSString类型）：表示要发送GET请求的URL字符串，即请求的目标地址。
 parameters（可选的id类型）：包含GET请求的参数，这些参数会附加到URL字符串中，以便服务器可以根据这些参数返回相应的数据。它通常是一个NSDictionary或其他数据结构，其中包含键值对，表示请求参数。
 headers（可选的NSDictionary类型）：包含HTTP请求头的字典。HTTP请求头通常包含与请求相关的信息，例如授权令牌、用户代理、接受的数据类型等。这里的参数允许你自定义请求头。
 downloadProgress（可选的NSProgress类型块）：一个块对象，用于跟踪下载进度。这个块会在下载数据时被调用，可以用来更新UI或记录下载进度等。
 success（可选的块）：一个成功回调块，当请求成功完成时会被调用。这个块通常接受两个参数，第一个参数是包含响应数据的NSURLSessionDataTask对象，第二个参数是响应数据，通常是一个NSDictionary或其他数据结构。
 failure（可选的块）：一个失败回调块，当请求失败时会被调用。这个块通常接受两个参数，第一个参数是包含请求任务信息的NSURLSessionDataTask对象，第二个参数是一个NSError对象，包含了关于请求失败的信息。
 在这个方法内部，首先通过调用dataTaskWithHTTPMethod:URLString:parameters:headers:uploadProgress:downloadProgress:success:failure:方法创建一个NSURLSessionDataTask对象，然后使用resume方法开始执行这个任务（发送GET请求），最后返回该任务对象，以便调用者可以对任务进行进一步操作或取消。
 */

- (void)fetchCityWeather:(NSString *)cityName completion:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))completion {
    
    //NSString *urlString = [NSString stringWithFormat:@"%@/current.json?key=%@&q=%@&lang=zh", APIURL, APIKey, cityName];
    NSString* urlString = [NSString stringWithFormat:@"%@/current.json", APIURL];
    NSDictionary* paramenters = @{
        @"key" : APIKey,
        @"q" : cityName,
        @"lang" : @"zh"
    };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:urlString parameters:paramenters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            completion(responseObject, nil);
        } else {
            completion(nil, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)fetchCityForecast:(NSString *)cityName days:(NSInteger)days completion:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))completion {
    NSString *urlString = [NSString stringWithFormat:@"%@/forecast.json?key=%@&q=%@&days=%ld&lang=zh&aqi=yes", APIURL, APIKey, cityName, (long)days];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)searchCities:(NSString *)keyword completion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion {
    NSString *urlString = [NSString stringWithFormat:@"%@/search.json?key=%@&q=%@&lang=zh", APIURL, APIKey, keyword];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            completion(responseObject, nil);
        } else {
            completion(nil, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)loadImageWithURL:(NSString *)urlString completion:(void (^)(UIImage * _Nullable, NSError * _Nullable))completion {
    NSURL *url = [NSURL URLWithString:urlString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url.absoluteString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = (NSData *)responseObject;
        UIImage *image = [UIImage imageWithData:data];
        if (image) {
            completion(image, nil);
        } else {
            completion(nil, [NSError errorWithDomain:@"com.天气难报.NetworkManager" code:1005 userInfo:@{NSLocalizedDescriptionKey: @"无效的图片数据"}]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

@end
