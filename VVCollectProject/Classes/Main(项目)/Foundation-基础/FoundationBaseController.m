//
//  FoundationBaseController.m
//  VVCollectProject
//
//  Created by lvan Lewis on 2020/9/21.
//  Copyright © 2020 Mike. All rights reserved.
//

#import "FoundationBaseController.h"

@interface FoundationBaseController ()

@end

@implementation FoundationBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //****** 字符串 ******
    [self string];
    
    
    //****** 数组类 ******
    [self array];
    
    
    //****** 字典类 ******
    
    //****** 结构体类 ******
    
    //****** 日期类 ******
    
    //****** 文件类 ******
}

#pragma mark - 数组类
- (void)array {
    // *** 一.NSArray ***
    
    //    + (instancetype)array;
    //    + (instancetype)arrayWithObject:(id)anObject;
    //    + (instancetype)arrayWithObjects:(id)firstObj, ...;
    //    + (instancetype)arrayWithArray:(NSArray *)array;
    //    + (id)arrayWithContentsOfFile:(NSString *)path;
    //    + (id)arrayWithContentsOfURL:(NSURL *)url;
    
    //    NSArray直接使用NSLog()作为字符串输出时是小括号括起来的形式。
    //    只能存放任意OC对象, 并且是有顺序的
    //    不能存储非OC对象, 比如int\float\double\char\enum\struct等
    //    NSArray中不能存储nil，因为NSArray认为nil是数组的结束（nil是数组元素结束的标记）。nil就是0。0也是基本数据类型，不能存放到NSArray中。
    //    它是不可变的，一旦初始化完毕后，它里面的内容就永远是固定的，不能删除里面的元素，也不能再往里面添加元素
    
    NSArray *arr1 = [NSArray arrayWithObjects:@"abc", nil];  // 之前创建的方式
    NSArray *arr2 = @[@"Jack", @"Rose", @"Jim"];   // 现在的创建方式
    
    //  NSArray排序
    //   *** Foundation自带类排序 ***
    //    使用compare方法对数组中的元素进行排序, 那么数组中的元素必须是Foundation框架中的对象, 也就是说不能是自定义对象
    NSArray *arr = @[@10,@9,@1,@19];
    NSLog(@"排序前: %@", arr);
    NSArray *newArr = [arr sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"排序后: %@", newArr);
    
    //    输出结果：
    //    排序前: (
    //          10,
    //          9,
    //          1,
    //          19
    //          )
    //    排序后: (
    //          1,
    //          9,
    //          10,
    //          19
    //          )
    
    //    *** 自定义排序 ***
    //    Person *p1 = [Person new];
    //    p1.age = 10;
    //    Person *p2 = [Person new];
    //    p2.age = 20;
    //    Person *p3 = [Person new];
    //    p3.age = 5;
    //    Person *p4 = [Person new];
    //    p4.age = 7;
    
    //    NSArray *arr = @[p1, p2, p3, p4];
    //    NSLog(@"排序前: %@", arr);
    //    // 按照人的年龄进行排序
    //    // 该方法默认会按照升序排序
    //    NSArray *newArr = [arr sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(Person *obj1, Person *obj2) {
    //        // 每次调用该block都会取出数组中的两个元素给我们
    //        return obj1.age > obj2.age;    // 升序
    //        //    return obj1.age < obj2.age;    // 降序
    //    }];
    //    NSLog(@"排序后: %@", newArr);
    //
    //    输出结果：
    //    排序前: (
    //          "age = 10",
    //          "age = 20",
    //          "age = 5",
    //          "age = 7"
    //          )
    //    排序后: (
    //          "age = 5",
    //          "age = 7",
    //          "age = 10",
    //          "age = 20"
    //          )
    
    
    
    
    
    // *** 二.NSMutableArray ***
    NSMutableArray *muArray1 = [NSMutableArray array];   // 创建空数组
    NSMutableArray *muArray2 = [[NSMutableArray alloc] initWithCapacity:5]; // 创建数组，并且指定长度为5，此时也是空数组
    NSMutableArray *muArray3 = [NSMutableArray arrayWithObjects:@"1",@"2", nil];  // 创建一个数组,包含两个元素
    NSMutableArray *muArray4 = [[NSMutableArray alloc] initWithObjects:@"1",@"2", nil];  // 调用对象方法创建数组
    
    // 添加一个元素- (void)addObject:(id)object;
    [muArray1 addObject:@"abc"];
    //    添加otherArray的全部元素到当前数组中- (void)addObjectsFromArray:(NSArray *)array;
    [muArray1 addObjectsFromArray:@[@"def",@"hij"]];
    
    
    // NSMutableArray 错误用法
    //    不可以使用@[]创建可变数组
    NSMutableArray *muArray5 = @[@"lnj", @"lmj", @"jjj"];
    
    // 报错, 本质还是不可变数组
    //    [muArray5 addObject:@“Peter”];
    
    
    
    
    
    
    
}


#pragma mark - 字符串
- (void)string {
    // *** 一.NSString ***
    // 1.NSString创建方式
    NSString *str1 = @"abc";
    NSString *str2 = [[NSString alloc] initWithFormat:@"abc"];
    NSString *str3 = [NSString stringWithFormat:@"abc"];
    
    
    
    // *** 二.NSMutableString ***
    NSMutableString *mStr = [NSMutableString string];
    NSMutableString *mStr2 = [NSMutableString stringWithFormat:@"www.baidu.com"];
    
    
    // 拼接aString到字符串最后面
    //    - (void)appendString:(NSString *)aString;
    
    NSLog(@"str = %@", mStr);
    
    // 修改原有字符串, 没有生成新的字符串
    [mStr appendString:@"abc"];
    NSLog(@"str = %@", mStr);
    
    [mStr appendString:@" xyz"];
    NSLog(@"str = %@", mStr);
    
    
    
    NSLog(@"str = %@", mStr2);
    
    [mStr2 appendString:@".gif"];
    NSLog(@"str = %@", mStr2);
    
    // 拼接一段格式化字符串到最后面- (void)appendFormat:(NSString *)format, ...;
    NSMutableString *mStr3 = [NSMutableString stringWithFormat:@"Walkers"];
    [mStr3 appendFormat:@" age is %i", 23];
    NSLog(@"str = %@", mStr3);
    
    // 输出结果：mStr3 = Walkers age is 23
    
    
    
    // 删除range范围内的字符串- (void)deleteCharactersInRange:(NSRange)range;
    NSMutableString *mStr4 = [NSMutableString stringWithFormat:@"http://jianshu.com/img/Walkers"];
    // 一般情况下利用rangeOfString和deleteCharactersInRange配合删除指定内容
    NSRange range4 = [mStr4 rangeOfString:@"http://"];
    [mStr4 deleteCharactersInRange:range4];
    NSLog(@"str = %@", mStr4);
    // 输出结果：mStr4 = jianshu.com/img/Walkers
    
    // 在loc这个位置中插入aString- (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc;
    NSMutableString *mStr5 = [NSMutableString stringWithFormat:@"jianshu.com/img/Walkers"];
    [mStr5 insertString:@"http://" atIndex:0];
    NSLog(@"str = %@", mStr5);
    // 输出结果：str = http://jianshu.com/img/Walkers
    
    
    // 使用aString替换range范围内的字符串- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
    NSMutableString *mStr6 = [NSMutableString stringWithFormat:@"http://jianshu.com/img/Walkers.gif"];
    NSRange range6 = [mStr6 rangeOfString:@"Walkers"];
    
    [mStr6 replaceOccurrencesOfString:@"Walkers" withString:@"abc" options:0 range:range6];
    NSLog(@"str = %@", mStr6);
    
    // 输出结果：str = http://jianshu.com/img/abc.gif
    
    
    
    
    // 字符串使用注意事项
    NSMutableString *strM = @"abc";   // 还是 NSString
    [strM insertString:@"my name is " atIndex:0];    // 会报错
}



@end

