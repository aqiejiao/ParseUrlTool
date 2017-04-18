//
//  CYJCollectionViewCell.h
//  ParseUrlTool
//
//  Created by mac on 2017/4/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PSCollectionViewCell.h"

@interface CYJCollectionViewCell : PSCollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic) BOOL isSelected;//是否被选中
@end
