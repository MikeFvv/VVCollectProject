//
//  ViewController.m
//  VVCollectProject
//
//  Created by Mike on 2018/12/25.
//  Copyright © 2018 Mike. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//
@property (nonatomic, copy) NSMutableString *printText;

@end

@implementation ViewController

#pragma mark - ViewController生命周期
// https://www.jianshu.com/p/d60b388b19f5

// 非storyBoard(xib或非xib)都走这个方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    /**
     初始化UIViewController，执行关键数据初始化操作，非StoryBoard创建UIViewController都会调用这个方法。
    ** 注意: 不要在这里做View相关操作，View在loadView方法中才初始化。**
     */
    NSLog(@"%s", __FUNCTION__);
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

// 如果连接了串联图storyBoard 走这个方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    /**
     如果使用StoryBoard进行视图管理，程序不会直接初始化一个UIViewController，StoryBoard会自动初始化或在segue被触发时自动初始化，因此方法initWithNibName:bundle不会被调用，但是initWithCoder会被调用。
     */
    NSLog(@"%s", __FUNCTION__);
    
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

// xib 加载 完成
- (void)awakeFromNib {
    /**
     当awakeFromNib方法被调用时，所有视图的outlet和action已经连接，但还没有被确定，这个方法可以算作适合视图控制器的实例化配合一起使用的，因为有些需要根据用户喜好来进行设置的内容，无法存在storyBoard或xib中，所以可以在awakeFromNib方法中被加载进来。
     */
    [super awakeFromNib];
    NSLog(@"%s", __FUNCTION__);
    
}

// 加载视图(默认从nib)
- (void)loadView {
    /**
     当执行到loadView方法时，如果视图控制器是通过nib创建，那么视图控制器已经从nib文件中被解档并创建好了，接下来任务就是对view进行初始化。
     loadView方法在UIViewController对象的view被访问且为空的时候调用。这是它与awakeFromNib方法的一个区别。
     假设我们在处理内存警告时释放view属性:self.view = nil。因此loadView方法在视图控制器的生命周期内可能被调用多次。
     loadView方法不应该直接被调用，而是由系统调用。它会加载或创建一个view并把它赋值给UIViewController的view属性。
     在创建view的过程中，首先会根据nibName去找对应的nib文件然后加载。如果nibName为空或找不到对应的nib文件，则会创建一个空视图(这种情况一般是纯代码)
     注意:在重写loadView方法的时候，不要调用父类的方法。
     */
    NSLog(@"%s", __FUNCTION__);
    
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor redColor];
}

//视图控制器中的视图加载完成，viewController自带的view加载完成
- (void)viewDidLoad {
    /**
     当loadView将view载入内存中，会进一步调用viewDidLoad方法来进行进一步设置。此时，视图层次已经放到内存中，通常，我们对于各种初始化数据的载入，初始设定、修改约束、移除视图等很多操作都可以这个方法中实现。
     视图层次(view hierachy):因为每个视图都有自己的子视图，这个视图层次其实也可以理解为一颗树状的数据结构。而树的根节点，也就是根视图(root view),在UIViewController中以view属性。它可以看做是其他所有子视图的容器，也就是根节点。
     */
    self.title = @"ViewController";
    NSLog(@"%s", __FUNCTION__);
    
    [super viewDidLoad];
    
    
}



//视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    /**
     系统在载入所有的数据后，将会在屏幕上显示视图，这时会先调用这个方法，通常我们会在这个方法对即将显示的视图做进一步的设置。比如，设置设备不同方向时该如何显示；设置状态栏方向、设置视图显示样式等。
     另一方面，当APP有多个视图时，上下级视图切换是也会调用这个方法，如果在调入视图时，需要对数据做更新，就只能在这个方法内实现。
     */
    NSLog(@"%s", __FUNCTION__);
    
    [super viewWillAppear:animated];
}

// view 即将布局其 Subviews
- (void)viewWillLayoutSubviews {
    /**
     view 即将布局其Subviews。 比如view的bounds改变了(例如:状态栏从不显示到显示,视图方向变化)，要调整Subviews的位置，在调整之前要做的工作可以放在该方法中实现
     */
    NSLog(@"%s", __FUNCTION__);
    
    [super viewWillLayoutSubviews];
}

// view 已经布局其 Subviews
- (void)viewDidLayoutSubviews {
    /**
     view已经布局其Subviews，这里可以放置调整完成之后需要做的工作。
     */
    NSLog(@"%s", __FUNCTION__);
    
    [super viewDidLayoutSubviews];
}

//视图已经出现
- (void)viewDidAppear:(BOOL)animated {
    /**
     在view被添加到视图层级中以及多视图，上下级视图切换时调用这个方法，在这里可以对正在显示的视图做进一步的设置。
     */
    NSLog(@"%s", __FUNCTION__);
    
    [super viewDidAppear:animated];
}

//视图将要消失
- (void)viewWillDisappear:(BOOL)animated {
    /**
     在视图切换时，当前视图在即将被移除、或被覆盖是，会调用该方法，此时还没有调用removeFromSuperview。
     */
    NSLog(@"%s", __FUNCTION__);
    
    [super viewWillDisappear:animated];
}

//视图已经消失
- (void)viewDidDisappear:(BOOL)animated {
    /**
     view已经消失或被覆盖，此时已经调用removeFromSuperView;
     */
    NSLog(@"%s", __FUNCTION__);
    
    [super viewDidDisappear:animated];
}

//出现内存警告  //模拟内存警告:点击模拟器->hardware-> Simulate Memory Warning
- (void)didReceiveMemoryWarning {
    /**
     视图被销毁，此次需要对你在init和viewDidLoad中创建的对象进行释放。
     */
    NSLog(@"%s", __FUNCTION__);
    
    [super didReceiveMemoryWarning];
}

// 视图被销毁
- (void)dealloc {
    /**
     在内存足够的情况下，app的视图通常会一直保存在内存中，但是如果内存不够，一些没有正在显示的viewController就会收到内存不足的警告，然后就会释放自己拥有的视图，以达到释放内存的目的。但是系统只会释放内存，并不会释放对象的所有权，所以通常我们需要在这里将不需要显示在内存中保留的对象释放它的所有权，将其指针置nil。
     */
    NSLog(@"%s", __FUNCTION__);
    
}


/**
视图的生命历程


[ViewController initWithCoder:]或[ViewController initWithNibName:Bundle]: 首先从归档文件中加载UIViewController对象。即使是纯代码，也会把nil作为参数传给后者。

[UIView awakeFromNib]: 作为第一个方法的助手，方法处理一些额外的设置。

[ViewController loadView]:创建或加载一个view并把它赋值给UIViewController的view属性。
-[ViewController viewDidLoad]: 此时整个视图层次(view hierarchy)已经放到内存中，可以移除一些视图，修改约束，加载数据等。

[ViewController viewWillAppear:]: 视图加载完成，并即将显示在屏幕上。还没设置动画，可以改变当前屏幕方向或状态栏的风格等。

[ViewController viewWillLayoutSubviews]即将开始子视图位置布局

[ViewController viewDidLayoutSubviews]用于通知视图的位置布局已经完成

[ViewController viewDidAppear:]:视图已经展示在屏幕上，可以对视图做一些关于展示效果方面的修改。

[ViewController viewWillDisappear:]:视图即将消失

[ViewController viewDidDisappear:]:视图已经消失

[ViewController dealloc:]:视图销毁的时候调用

四: 总结:

只有init系列的方法,如initWithNibName需要自己调用，其他方法如loadView和awakeFromNib则是系统自动调用。而viewWill/Did系列的方法则类似于回调和通知，也会被自动调用。
纯代码写视图布局时需要注意，要手动调用loadView方法，而且不要调用父类的loadView方法。纯代码和用IB的区别仅存在于loadView方法及其之前，编程时需要注意的也就是loadView方法。
除了initWithNibName和awakeFromNib方法是处理视图控制器外，其他方法都是处理视图。这两个方法在视图控制器的生命周期里只会调用一次。


*/

@end




//1
//不要一次创建所有的subview，而是当需要时才创建，当它们完成了使命，把他们放进一个可重用的队列中
//
//当需要时才创建并展示。
//
//每个方案都有其优缺点。
//用第一种方案的话因为你需要一开始就创建一个view并保持它直到不再使用，这就会更加消耗内存。然而这也会使你的app操作更敏感因为当用户点击按钮的时候它只需要改变一下这个view的可见性。
//
//第二种方案则相反-消耗更少内存，但是会在点击按钮的时候比第一种稍显卡顿。
//
//2 Cache
//一个极好的原则就是，缓存所需要的，也就是那些不大可能改变但是需要经常读取的东西。
//
//我们能缓存些什么呢？一些选项是，远端服务器的响应，图片，甚至计算结果，比如UITableView的行高。
//
//3
//处理内存警告
//
//4 重用大开销对象
//比如NSDateFormatter和NSCalendar
//
//
//
//5 避免反复处理数据
//
//
//
//
//优化Table View
//避免渐变，图片缩放
//缓存行高
//减少subviews的数量
//使用正确的数据结构来存储数据
//那么就去使用更加底层的SQLite吧
//
//尽量使用rowHeight, sectionFooterHeight 和 sectionHeaderHeight来设定固定的高，不要请求delegate
//
//
//1. 用ARC管理内存
//2. 在正确的地方使用reuseIdentifier
//3. 尽可能使Views透明
//原因是很直观的,如果一个图层是完全不透明的,则系统直接显示该图层的颜色即可。而如果图层是带透明效果的,则会引入更多的计算,因为需要把下面的图层也包括进来,进行混合后颜色的计算。
//4. 避免庞大的XIB
//5. 不要block主线程
//6. 在Image Views中调整图片大小
//7. 选择正确的Collection
//8. 打开gzip压缩
//
//9. 重用和延迟加载Views
//10. Cache, Cache, 还是Cache！
//11. 权衡渲染方法
//12. 处理内存警告
//13. 重用大开销的对象
//14. 使用Sprite Sheets
//15. 避免反复处理数据
//16. 选择正确的数据格式
//17. 正确地设定Background Images
//18. 减少使用Web特性
//19. 设定Shadow Path
//20. 优化你的Table View
//21. 选择正确的数据存储选项
//
//22. 加速启动时间
//23. 使用Autorelease Pool
//24. 选择是否缓存图片
//25. 尽量避免日期格式转换
