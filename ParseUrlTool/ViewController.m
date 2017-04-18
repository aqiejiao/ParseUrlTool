//
//  ViewController.m
//  ParseUrlTool
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "TFHppleManger.h"
#import "AFNetworking.h"
#import "ResultViewController.h"

@interface ViewController ()
{
    NSArray *_downloadImages;
}

@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@end

@implementation ViewController

//用keychain存储数据，具体使用：http://www.jianshu.com/p/e9778d64b283

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)goAction:(UIButton *)sender {
    NSString *url = _urlTextField.text;
    if (![url isEqualToString:@""])
    {
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//        
//        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//        
//        if (response == nil){
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告！" message:@"无法连接到该网站！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//            [alertView show];
//            return;
//        }
//        TFHppleManger *manger = [[TFHppleManger alloc] initWithBaseUrl:url];
//        _downloadImages = [manger getImageUrls:response];
//        NSLog(@"图片地址：%@", _downloadImages);
//        [self performSegueWithIdentifier:@"ResultViewControllerIdentifier" sender:nil];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSData *response = (NSData *)responseObject;
            if (!response)
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"无法连接到该网址" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
                return;
            }
            
            
            TFHppleManger *manger = [[TFHppleManger alloc] initWithBaseUrl:url];
            NSString *responseStr = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            NSLog(@"解析网页：%@", responseStr);
            _downloadImages = [manger getImageUrls:response];
            NSLog(@"图片地址：%@", _downloadImages);
            [self performSegueWithIdentifier:@"ResultViewControllerIdentifier" sender:nil];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error");
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ResultViewController *vc =  (ResultViewController *)segue.destinationViewController;
    vc.imageUrls = _downloadImages;
}


@end
