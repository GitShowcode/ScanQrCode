//
//  CreateQrViewController.m
//  ScanQrcode
//
//  Created by jiapeixin on 15/12/8.
//  Copyright © 2015年 Gencare_Jia. All rights reserved.
//

#import "CreateQrViewController.h"
#import "CreateQrIMG.h"
@interface CreateQrViewController ()
{
    CreateQrIMG *qrimgView;
    UIView *bgView;

}
@end

@implementation CreateQrViewController
- (UILabel*) createLabelWithFrame: (CGRect) frame Font:(UIFont *)font Text:(NSString *)text  Textcolor:(UIColor *)color TextAlignment:(NSTextAlignment )textAlignment{
    
    UILabel *alabel=[[UILabel alloc] initWithFrame:frame];
    alabel.font=font;
    alabel.textColor=color;
    alabel.text=text;
    if (textAlignment==0) {
        //默认剧中
        alabel.textAlignment=NSTextAlignmentCenter;
        
    }
    else{
        alabel.textAlignment=textAlignment;
        
    }
    
    return alabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"生成二维码";
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *label=[self createLabelWithFrame:CGRectMake(0, 30+64, SCREEN_WIDTH, 30) Font:[UIFont systemFontOfSize:25] Text:@"二维码" Textcolor:[UIColor blackColor] TextAlignment:0];
    [self.view addSubview:label];
    
    
    bgView=[[UIView alloc] initWithFrame:CGRectMake((int)(SCREEN_WIDTH-240)/2, 100+64, 240, 240)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.borderColor=[UIColor grayColor].CGColor;
    bgView.layer.borderWidth=0.5;
    bgView.layer.cornerRadius=5;
    [self.view addSubview:bgView];
    
    
    
    
//    CreateQrIMG *IMG=[CreateQrIMG changeQr:@"这是一个二维码" andnewRect:CGRectMake(SCREEN_WIDTH/2.0-120, 64, 240, 240)];
//    [self.view addSubview:IMG];
  
    [self creatQr:@"http://www.cnbeta.com/"];
    
    
    UIButton *btn= [self createButtonWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 240+100+50+64, 150, 45) Target:self Selector:@selector(changeQr) Image:@""];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"切换二维码" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:btn];
    
    
    

}
-(void)changeQr{
    
    
    
    [qrimgView removeFromSuperview];
    NSString *str=[NSString stringWithFormat:@"%@---%d",[self dateToString:[NSDate date]],arc4random()%100];
   
    [self creatQr:str];
    
    
    
}
/**创建二维码一*/
-(void)creatQr:(NSString *)qrstr{
    [qrimgView removeFromSuperview];
    
    qrimgView=[CreateQrIMG changeQr:qrstr andnewRect:CGRectMake(0, 0, 240, 240)];
    [bgView addSubview:qrimgView];
    
    
    
    
    
    
    
    

    
    
}

- (UIButton*) createButtonWithFrame: (CGRect) frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    button.adjustsImageWhenHighlighted=NO;
    UIImage *newImage = [UIImage imageNamed: image];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
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
