//
//  ViewController.m
//  RACAFNetworking
//
//  Created by 赵成峰 on 2018/5/25.
//  Copyright © 2018年 chengfeng. All rights reserved.
//

#import "ViewController.h"
#import "RACAFNetworking/RACAFNetworking.h"

@interface ViewController ()

@property (nonatomic, strong) RACSignal *signal;
@property (nonatomic, strong) UIButton *downloadButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.imageView];
    
    self.downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 40)];
    [self.downloadButton setTitle:@"download image" forState:UIControlStateNormal];
    [self.downloadButton setTitle:@"download progress 0%" forState:UIControlStateDisabled];
    [self.downloadButton addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downloadButton];
    
}

- (void)download {
    self.downloadButton.enabled = NO;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    RACSignal *signal = [manager rac_DOWNLOAD:@"http://cn.bing.com/az/hprichbg/rb/WindmillLighthouse_ZH-CN12870536851_1920x1080.jpg" saveURL:[self tempFileURL]];
    
    @weakify(self);
    [signal subscribeProgress:^(float progress) {
        @strongify(self);
        NSString *str = [NSString stringWithFormat:@"download progress %.2f%%", progress * 100];
        [self.downloadButton setTitle:str forState:UIControlStateDisabled];
    } next:^(NSURL *fileURL) {
        @strongify(self);
        self.downloadButton.enabled = YES;
        NSData *data = [NSData dataWithContentsOfURL:fileURL];
        UIImage *image = [UIImage imageWithData:data];
        self.imageView.image = image;
    } error:^(NSError *error) {
        @strongify(self);
        [self.downloadButton setTitle:@"download fail" forState:UIControlStateNormal];
        self.downloadButton.enabled = YES;
    }];
}

- (NSURL *)tempFileURL
{
    NSString *path = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documentDirectory = [NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), @"Download/Image/"];//
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentDirectory]){
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:documentDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    NSInteger i = 0;
    while(path == nil || [fm fileExistsAtPath:path]){
        path = [NSString stringWithFormat:@"%@%ld.jpg", documentDirectory, (long)i];
        i++;
    }
    return [NSURL fileURLWithPath:path];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
