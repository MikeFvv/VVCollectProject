//
//  ViewController.m
//  VVCollectProject
//
//  Created by Mike on 2018/12/25.
//  Copyright © 2018 Mike. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()

// 定时器
@property (nonatomic,strong) NSTimer *timerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initUI];
   
//    [self navigationBar];
//    // 导航栏 代码实现  代码实现，维护时可操作性强  可实现渐变色效果
//    [self navigationBackColor];
    
    // 定时器
//    [self pressStart];
//    [self bulidView];
    
    
//    Person *p = [[Person alloc] init];
//    Class c1 = [p class];
//    Class c2 = [Person class];
//    //输出 1
//    NSLog(@"%d", c1 == c2);
    
    
    Person *p = [[Person alloc] init];
    //输出1
    NSLog(@"%d", [p class] == object_getClass(p));
    //输出0
    NSLog(@"%d", class_isMetaClass(object_getClass(p)));
    //输出1
    NSLog(@"%d", class_isMetaClass(object_getClass([Person class])));
    //输出0
    NSLog(@"%d", object_getClass(p) == object_getClass([Person class]));
    
    
    
    // runtime:遍历模型中所有成员属性,去字典中查找
    // 属性定义在哪,定义在类,类里面有个属性列表(数组)
    // 遍历模型所有成员属性
    // ivar:成员属性
    // class_copyIvarList:把成员属性列表复制一份给你
    // Ivar *:指向Ivar指针
    // Ivar *:指向一个成员变量数组
    // class:获取哪个类的成员属性列表
    // count:成员属性总数
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([Person class], &count);
    for (int i = 0 ; i < count; i++) {
        // 获取成员属性
        Ivar ivar = ivarList[i];
        // 获取成员名
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        ;
        // 成员属性类型
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        NSLog(@"!111");
    }
    
    
    NSString *className = NSStringFromClass([UIView class]);
    
    
    const char *cClassName = [className UTF8String];
    
    id theClass = objc_getClass(cClassName);
    
    unsigned int outCount;
    
    
    Method *m =  class_copyMethodList(theClass,&outCount);
    
    NSLog(@"%d",outCount);
    for (int i = 0; i<outCount; i++) {
        SEL a = method_getName(*(m+i));
        NSString *sn = NSStringFromSelector(a);
        NSLog(@"%@",sn);
    }
 
    NSInteger a = 10;
    NSInteger b = 20;
    
//    aa = aa + bb;
//    bb = aa - bb;
//    aa = aa - bb;
    
//    a = a^b;
//
//    b = a^b;
//
//    a = a^b;
    
     NSLog(@"%d-%d", a , b);
    
    
    //第三种方法，使用指针
    
    int *pa = &a;
    
    int *pb = &b;
    
    *pa = b;
    
    *pb = a;
    
    NSLog(@"after,a = %d",a);
    
    NSLog(@"after,b = %d",b);
    
   
    
//    class_getName
////    Returns the name of a class.
//
//    const char * class_getName(Class cls)
//    Parameters
//    cls
//    A class object.
//    Return Value
//    The name of the class, or the empty string if cls is Nil.
//
//        Declared In
//        runtime.h
    
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//
//}

-(void)bulidView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.bounds = CGRectMake(0, 0, 80, 40);
    btn.center = self.view.center;
    [btn setTitle:@"yyyy下发js脚本" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(jsScriptRun:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)jsScriptRun:(id)sender{
    
}

- (void)initUI {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"测试";
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
}

- (void)initUI2 {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"测试下载更新";
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
}

- (void)navigationBar {
    // https://www.jianshu.com/p/011fe3c2df66
    // 导航栏 背景颜色 UI直接切图 实现
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"msg3"] forBarMetrics:UIBarMetricsDefault];
}

- (void)navigationBackColor {
    CGRect frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64);
    
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:frame];
    
    UIGraphicsBeginImageContext(imgview.frame.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
    CGContextScaleCTM(context, frame.size.width, frame.size.height);
    
    CGFloat colors[] = {
        
        50.0/255.0, 117.0/255.0, 224.0/255.0, 1.0,
        
        63.0/255.0, 163.0/255.0, 238.0/255.0, 1.0,
        
    };
    
    CGGradientRef backGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    
    CGColorSpaceRelease(rgb);
    
    //设置颜色渐变的方向，范围在(0,0)与(1.0,1.0)之间，如(0,0)(1.0,0)代表水平方向渐变,(0,0)(0,1.0)代表竖直方向渐变
    
    CGContextDrawLinearGradient(context, backGradient, CGPointMake(0, 0), CGPointMake(1.0, 0), kCGGradientDrawsBeforeStartLocation);
    
    [self.navigationController.navigationBar setBackgroundImage:UIGraphicsGetImageFromCurrentImageContext()  forBarMetrics:UIBarMetricsDefault];
}


- (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



#pragma mark -  定时器功能
// ******** 定时器  计时器  **********
-(void)pressStart {
    
    
    // 01 手动添加到runloop运行循环中
    //    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(doSomething) userInfo:nil repeats:NO];
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    // 02 由系统自动添加到运行循环中
    //NSTimer的类方法创建一个定时器并且启动这个定时器
    //P1:每隔多长时间调用定时器函数，以秒为单位
    //P2:实现定时器函数的对象（指针）
    //P3：定时器函数对象
    //P4：可以定时器函数中一个参数，无参数可以传nil
    //P5:定时器是否重复操作YES为重复，NO只完成一次函数调用
    //返回一个新建好的定时器对象
    //    _timerView = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(uploadTimer:) userInfo:nil repeats:YES];
    
    _timerView=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(uploadTimer:) userInfo:@"小明" repeats:YES];
}

-(void)pressStop {
    if (_timerView!=nil) {
        //停止计时器
        [_timerView invalidate];
    }
}

//定时器函数
-(void)uploadTimer:(NSTimer*)timer {
    NSLog(@"test......name=%@",timer.userInfo);
    UIView* view=[self.view viewWithTag:103];
    view.frame=CGRectMake(view.frame.origin.x+5, view.frame.origin.y+5, 80, 80);
}



#pragma mark - 错误Log打印
// NSLog  错误方法打印
// NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), exception);
//@try {
//    [mineViewController testPush];
//} @catch (NSException *exception) {
//    NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), exception.reason);
//}


#pragma mark -  NSMutableDictionary初始化
- (void)test {
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary: dic2];
}
#pragma mark -  无

@end
