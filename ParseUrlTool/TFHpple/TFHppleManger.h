//
//  TFHppleManger.h
//  ParseUrlTool
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"

@interface TFHppleManger : NSObject
- (instancetype)initWithBaseUrl:(NSString *)url;
- (NSArray<NSString *> *)getImageUrls:(NSData *)data;
- (NSArray<NSString *> *)getVedioUrls:(NSData *)data;
@end
