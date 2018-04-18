//
//  ViewController.m
//  MGRouter
//
//  Created by Mingle on 2018/4/18.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import "ViewController.h"
#import "MGRouterHeader.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lbl;

@end

@implementation ViewController
//@dynamic k1;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    com.witaction.yunxiaowei
//    [MGRouter viewControllerWithURL:[MGRouter URLWithScheme:@"MGRouter" Class:NSClassFromString(@"ViewController") params:@{@"k1":@"v1",@"k2":@"v2"}]];
    
    _lbl.text = _param;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setParam:(NSString *)param {
    _param = param;
    _lbl.text = _param;
}
- (IBAction)openBaidu:(id)sender {
    [MGRouter openOutSideURL:[NSURL URLWithString:@"https://www.baidu.com"] callback:^(NSURL * _Nonnull URL, BOOL success) {
        self.lbl.text = [NSString stringWithFormat:@"URL 打开%@ %@",URL,success?@"成功":@"失败"];
    }];
}

- (IBAction)openYxw:(id)sender {
    [MGRouter openURL:[NSURL router_URLWithScheme:@"com.witaction.yunxiaowei" target:nil params:nil] callback:^(NSURL * _Nonnull URL, BOOL success) {
        self.lbl.text = [NSString stringWithFormat:@"URL 打开%@ %@",URL,success?@"成功":@"失败"];
    }];
}

- (IBAction)routerPush:(id)sender {
    [self.navigationController router_pushURL:[NSURL router_URLWithScheme:@"MGRouter" target:NSClassFromString(@"XibViewController") params:@{@"param":@"I am XibViewController from routerPush"}] animated:YES];
}

- (IBAction)routerPresent:(id)sender {
    [self router_presentURL:[NSURL router_URLWithScheme:@"MGRouter" target:NSClassFromString(@"XibViewController") params:@{@"param":@"I am XibViewController from routerPresent"}] animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
