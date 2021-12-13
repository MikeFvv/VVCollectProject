//
//  ViewController.m
//  NSAttributedString_Yjl
//
//  Created by 余晋龙 on 2016/11/2.
//  Copyright © 2016年 余晋龙. All rights reserved.
//

#import "NSAttrViewController.h"
#import "NSAttributedStringManager.h"
#import "NextViewController.h"
#import "NSAttributedStringManager.h"


@interface NSAttrViewController ()

@end

@implementation NSAttrViewController
{
    //改变指定字符串的"颜色"(可以是多个)
    NSMutableAttributedString *strr1;
    //改变指定字符串的"颜色"和"字体"
    NSMutableAttributedString *strr2;
    //文字下面画线及线条的颜色
    NSMutableAttributedString *strr3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"富文本";
    [self addButton];
    
    NSString *str = @"可怜的肌肤 i 俄风味咖啡呢，恶魔能分解为 i 回复牛俄方呢我愤怒买奶粉 i 家儿女奉公克己二哥呢日快乐 可怜的肌肤 i 俄风味咖啡呢，恶魔能分解为 i 回复牛俄方呢我愤怒买奶粉 i 家儿女奉公克己二哥呢日快乐";
    
    NSArray *arr = @[@"可怜",@"二哥",@"奶粉",@"咖啡"];
    
    //改变指定字符串的"颜色"(可以是多个)
    strr1 =[NSAttributedStringManager changeTextColorWithColor:[UIColor orangeColor] string:str andSubString:arr];
    
    //改变指定字符串的"颜色"和"字体"
    strr2 = [NSAttributedStringManager changeFontAndColor:[UIFont systemFontOfSize:30] Color:[UIColor redColor] TotalString:str SubStringArray:arr];
    
    //文字下面画线及线条的颜色
    strr3 = [NSAttributedStringManager addLinkWithTotalString:str andLineColor:[UIColor orangeColor]  SubStringArray:arr];
    
}

-(void)addButton{
    NSArray *arr = @[@"改变指定字符串的-颜色-(可以是多个)",@"改变指定字符串的-颜色-和-字体-",@"文字下面画线及线条的颜色"];
    
    for (int i = 0; i < arr.count; i++) {
        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        bt.titleLabel.font = [UIFont systemFontOfSize:12];
        bt.tag = i + 1;
        bt.backgroundColor = [UIColor lightGrayColor];
        bt.center = CGPointMake(self.view.frame.size.width / 2, 200 + i * 100);
        [bt setTitle:arr[i] forState:0];
        [bt setTitleColor:[UIColor blueColor] forState:0];
        [bt setTitleColor:[UIColor orangeColor] forState:1];
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bt];
    }
}
-(void)click:(UIButton *)sender
{
    NextViewController *nextVC = [[NextViewController alloc]init];
    if (sender.tag == 1) {
        
        nextVC.attributedStr = strr1;
        
    }else if (sender.tag == 2){
        nextVC.attributedStr = strr2;
        
    }else if (sender.tag == 3){
        nextVC.attributedStr = strr3;
    }
    [self.navigationController pushViewController:nextVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
