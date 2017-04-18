//
//  CYJCollectionViewCell.m
//  ParseUrlTool
//
//  Created by mac on 2017/4/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "CYJCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CYJCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end

@implementation CYJCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    
    return self;
}

+ (CGFloat)rowHeightForObject:(id)object inColumnWidth:(CGFloat)columnWidth{
    /*
     在这里实现动态高度的计算
     */
    return 160;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    _imageUrl = imageUrl;
}

- (void)setIsSelected:(BOOL)isSelected
{
    if (isSelected)
    {
        _selectButton.hidden = NO;
    }
    else
    {
        _selectButton.hidden = YES;
    }
    _isSelected = isSelected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
