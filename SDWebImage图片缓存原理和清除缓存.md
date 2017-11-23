#### SDWebImage内部实现原理
#### 清除缓存

1. 计算缓存大小

        //获取缓存图片的大小(字节)
        NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
        //换算成 MB
        float cacheMB = bytesCache/1024.0/1024.0;
2. 清除缓存

        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUDHelper showMessageInView:weakSelf.view message:@"缓存清理成功"];
            });
        }];
