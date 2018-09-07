# AFNetworking-ReactiveObjC

pod 'RACAFNetworking', '~>2.0'

```
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
        NSData *data = [NSData dataWithContentsOfURL:fileURL];
        UIImage *image = [UIImage imageWithData:data];
        self.imageView.image = image;
    } error:^(NSError *error) {
        @strongify(self);
        [self.downloadButton setTitle:@"download fail" forState:UIControlStateNormal];
    }];
```
