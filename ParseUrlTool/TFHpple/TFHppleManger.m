//
//  TFHppleManger.m
//  ParseUrlTool
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TFHppleManger.h"

@interface TFHppleManger ()
@property (nonatomic, copy) NSString *url;
@end

@implementation TFHppleManger
- (instancetype)initWithBaseUrl:(NSString *)url
{
    if (self = [super init])
    {
        _url = url;
    }
    
    return self;
}

- (NSArray<NSString *> *)getImageUrls:(NSData *)data
{
    if (!data)
        return nil;
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
    
    NSString *srcKey = @"src";
    NSString *lazySrcKey = @"lazy_src";
    
//    NSString *subNodeKey = @"src";//@"lazy-src";//@"src";
    //在页面中查找img标签
    NSArray *images = [doc searchWithXPathQuery:@"//img"];
    
//    TFHppleElement *e = [doc peekAtSearchWithXPathQuery:@"//img"];
//    NSDictionary *a = e.attributes;
//    NSLog(@"a=%@", a);
    
    NSMutableArray *retImages = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [images count]; ++i)
    {
        NSString *srcContext = [images[i] objectForKey:srcKey];
        NSString *lazySrcContext = [images[i] objectForKey:lazySrcKey];
        
        NSString *urlContext;
        if (srcContext)
        {
            urlContext = [self handleNodeKey:srcKey element:images[i]];
        }
        
        if (lazySrcContext)
        {
            urlContext = [self handleNodeKey:lazySrcKey element:images[i]];
        }
        
        if (urlContext)
        {
            [retImages addObject:urlContext];
            NSLog(@"图片地址：%@", urlContext);
        }
    }
    
    return retImages;
}

- (NSString *)handleNodeKey:(NSString *)key element:(TFHppleElement *)element
{
    NSString *urlContext = [element objectForKey:key];
    if (!urlContext || urlContext.length <= 4)
        return nil;
    
    if (![self isImageType:urlContext])
        return nil;
    
    NSString *prefix = [urlContext substringToIndex:4];
    if (!prefix)
        return nil;
    
    //相对路径
    if ([prefix isEqualToString:@"http"] == NO)
    {
        urlContext = [_url stringByAppendingString:urlContext];
    }
    
    return urlContext;
}

- (BOOL)isImageType:(NSString *)url
{
    NSString *lowercaseUrl = [url lowercaseString];
    if ([lowercaseUrl hasSuffix:@".jpg"]
        || [lowercaseUrl hasSuffix:@".png"]
        || [lowercaseUrl hasSuffix:@".gif"]
        || [lowercaseUrl hasSuffix:@".webp"])
    {
        return YES;
    }
    
    return NO;
}

- (NSArray<NSString *> *)getVedioUrls:(NSData *)data
{
    //if (!data)
        return nil;
}
@end
