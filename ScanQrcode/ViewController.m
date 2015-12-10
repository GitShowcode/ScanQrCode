//
//  ViewController.m
//  ScanQrcode
//
//  Created by jiapeixin on 15/12/8.
//  Copyright © 2015年 Gencare_Jia. All rights reserved.
//

#import "ViewController.h"
#import "ScanQrViewController.h"
#import "CreateQrViewController.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface ViewController ()
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //test
    self.title=@"😢😄😢";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"  style:UIBarButtonItemStylePlain  target:self  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    

    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(0, 100, SCREEN_WIDTH, 40);
    btn1.backgroundColor=[UIColor yellowColor];
    [btn1 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    

    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(0, 100+40+40, SCREEN_WIDTH, 40);
    [btn2 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    btn2.backgroundColor=[UIColor yellowColor];
    [btn2 setTitle:@"生成二维码" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    
    [btn1 addTarget:self action:@selector(pushscan) forControlEvents:UIControlEventTouchUpInside];
    
    [btn2 addTarget:self action:@selector(pushcreate) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    
}
-(void)pushcreate{
    CreateQrViewController *VC=[[CreateQrViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
    
}
-(void)pushscan{
    ScanQrViewController *VC=[[ScanQrViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
