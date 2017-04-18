//
//  ResultViewController.m
//  ParseUrlTool
//
//  Created by mac on 2017/4/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ResultViewController.h"
#import "PSCollectionView.h"
#import "CYJCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>

@interface ResultViewController ()<UIScrollViewDelegate,PSCollectionViewDataSource,PSCollectionViewDelegate>
@property (nonatomic, strong) PSCollectionView *collectionView;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"didLoad images = %@", _imageUrls);
    
    self.collectionView = [[PSCollectionView alloc] initWithFrame:self.view.bounds];
    self.collectionView.delegate = self; // This is for UIScrollViewDelegate
    self.collectionView.collectionViewDelegate = self;
    self.collectionView.collectionViewDataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.autoresizingMask = ~UIViewAutoresizingNone;
    self.collectionView.numColsPortrait = 2;
    self.collectionView.numColsLandscape = 3;
    [self.view addSubview:self.collectionView];
}

- (void)setImageUrls:(NSArray *)imageUrls
{
    NSLog(@"result = %@", imageUrls);
    _imageUrls = imageUrls;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark PSCollectionViewDataSource
- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView {
    return _imageUrls.count;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index {
    return 100.0;
}

- (UIView *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrls[index]]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    CYJCollectionViewCell *cell = (CYJCollectionViewCell *)[self.collectionView dequeueReusableViewForClass:[CYJCollectionViewCell class]];
    if (!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CYJCollectionViewCell" owner:self options:nil];
        cell = (CYJCollectionViewCell *)[nib objectAtIndex:0];
    }
//    cell.imageView = imageView;
    cell.imageUrl = _imageUrls[index];
    cell.isSelected = NO;
    return cell;
}

#pragma mark PSCollectionViewDelegate
- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
    CYJCollectionViewCell *collectionCell = (CYJCollectionViewCell *)cell;
    collectionCell.isSelected = !collectionCell.isSelected;
    NSLog(@"index:%d", index);
    
    //- (nullable UIImage *)imageFromCacheForKey:(nullable NSString *)key;
    UIImage *im = [[SDImageCache sharedImageCache] imageFromCacheForKey:_imageUrls[index]];
    NSLog(@"image=%@", im);
}

- (Class)collectionView:(PSCollectionView *)collectionView cellClassForRowAtIndex:(NSInteger)index
{
    return [CYJCollectionViewCell class];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
