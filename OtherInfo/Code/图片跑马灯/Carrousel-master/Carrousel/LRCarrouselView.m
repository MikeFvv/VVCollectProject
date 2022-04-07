//
//  LRCarrouselView.m
//  TestProject
//
//  Created by leilurong on 2016/11/7.
//  Copyright © 2016年 leilurong. All rights reserved.
//

#import "LRCarrouselView.h"
#import "BlockTimer.h"

#define DebugLog(fmt, ...)  NSLog((@"[DEBUG]%s " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__);

#define kRadainWithNum(n)   (M_PI * 1 / (n))
#define kBaseWidth          0.3
#define kAngelToRad(a)      ((a) * M_PI / 180.0)

@class CarrouselImageView;
@protocol CarrouselImageViewProtocal <NSObject>

- (void)animationDidStartInView:(CarrouselImageView *)view;
- (void)animationDidStopInView:(CarrouselImageView *)view finished:(BOOL)flag;

@end

@interface CarrouselImageView : UIImageView<CAAnimationDelegate>
@property (nonatomic, weak) id <CarrouselImageViewProtocal>delegate;
@property (nonatomic, assign) BOOL animationCompleted;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) BOOL showReflect;
@property (nonatomic, strong) CALayer *reflectLayer;
@end

@implementation CarrouselImageView

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    self.animationCompleted = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationDidStartInView:)])
    {
        [self.delegate animationDidStartInView:self];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.animationCompleted = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationDidStopInView:finished:)])
    {
        [self.delegate animationDidStopInView:self finished:flag];
    }
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    self.tag = index;
    [self.label setText:[NSString stringWithFormat:@"%ld", (long)index]];
}

@end


@interface LRCarrouselView ()<CarrouselImageViewProtocal>

@property (nonatomic, copy) CarrouselBlock block;

@property (nonatomic, strong) NSMutableArray *datasource;//views

@property (nonatomic, assign) BOOL touchesMoved;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint movedPoint;

@property (nonatomic, assign) CGFloat currentOffset;
@property (nonatomic, assign) CGFloat lastOffset;

@property (nonatomic, readonly) CGFloat lastAutoOffset;

@property (nonatomic, assign) BOOL swipeToRight;//滑动方向

@property (nonatomic, strong) BlockTimer *timer;  // 自动旋转定时器

@end

@implementation LRCarrouselView
{
    NSDate *startDate;
    NSDate *stopDate;
}

#pragma mark - public methods
- (LRCarrouselView *)initWithFrame:(CGRect)frame images:(NSArray *)images callback:(CarrouselBlock)block
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.touchesMoved = NO;
        self.startPoint = CGPointZero;
        self.movedPoint = CGPointZero;
        self.currentOffset = 0;
        self.lastOffset = 0;
        self.sensitivity = 1;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 1 / [[UIScreen mainScreen] scale];
        self.layer.masksToBounds = YES;
        self.minimumPressTime = 0.4;
        self.animationSpeed = 3.0;
        NSArray *subviews = [self viewsForImages:images];
        for (UIView *view in subviews)
        {
            [self addSubview:view];
        }
        [self.datasource addObjectsFromArray:subviews];
        self.block = block;
        [self startRotateRight:NO];
    }
    return self;
}

- (void)addImage:(UIImage *)image
{
    CarrouselImageView *view = [self viewWithImage:image];
    view.index = self.datasource.count;
    [self.datasource addObject:view];
    [self addSubview:view];
}

- (void)startRotateRight:(BOOL)right
{
    self.swipeToRight = right;
    self.canAutoRotate = YES;
}

- (void)stopRotate
{
    self.canAutoRotate = NO;
}


+ (void)cancelAndRestartPerformSelector:(SEL)fun target:(id)target object:(id)object delay:(NSTimeInterval)delay
{
    if (target == nil) return;
    [NSObject cancelPreviousPerformRequestsWithTarget:target selector:fun object:nil];
    [target performSelector:fun withObject:object afterDelay:delay];
}

#pragma mark - touches affect methods
- (void)restartAutoRotateTimer
{
    if (self.canAutoRotate)
    {
        [self startTimer];
    }
}

// 旋转
- (void)processCarrouselWithOffset:(CGFloat)angel
{
    for (NSInteger i = 0; i < self.datasource.count; i ++)
    {
        [self rotateViewAtIndex:i keyframeAnimation:NO];
    }
    self.currentOffset = angel + self.lastOffset;
}

#pragma mark - timer
- (void)startTimer
{
    [self endTimerRemoveAnimation:NO];
    __weak typeof(self) weakself = self;
    self.timer = [BlockTimer displayLinkWithFrameInterval:60 runloopMode:NSRunLoopCommonModes keepon:^BOOL(NSInteger repeatCount, id timer, BOOL istimer) {
        
        [weakself autoRotateOnce];
        return YES;// 手势较快时 因为定时特性可能延迟导致错误而未关闭上次定时器 故手动关闭
    }];
}

- (void)endTimerRemoveAnimation:(BOOL)remove
{
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (!remove) return;
    // 以下代码立即停止动画 突变至结果位置
    for (NSInteger i = 0; i < self.datasource.count; i ++)
    {
        UIView *view = self.datasource[i];
        [view.layer removeAllAnimations];
    }
}

#pragma mark - CarrouselImageViewProtocal
- (void)animationDidStartInView:(CarrouselImageView *)view
{
    NSInteger index = [self.datasource indexOfObject:view];
    CATransform3D t3d = [self transform3DForViewIndex:index frame:0];
    view.layer.transform = t3d;
}

- (void)animationDidStopInView:(CarrouselImageView *)view finished:(BOOL)flag
{
    // 在结束这里设置属性值 会导致动画启动最开始有一次卡顿, 放在开始方法里面解决问题
}

- (void)autoRotateOnce
{
    for (NSInteger i = 0; i < self.datasource.count; i ++)
    {
        [self rotateViewAtIndex:i keyframeAnimation:YES];//self.datasource.count - 1 -
    }
    self.currentOffset += self.lastAutoOffset;
}

- (void)rotateViewAtIndex:(NSInteger)index keyframeAnimation:(BOOL)animation
{
    CarrouselImageView *view = self.datasource[index];
    if (animation)
    {
        CAKeyframeAnimation *t = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        t.duration = 1.f;
        t.repeatCount = 0;
        t.values = [self keyframeValuesForViewIndex:index];
        t.keyTimes = [self keyframeTimesForViewIndex:index];
        t.delegate = view;
        [view.layer addAnimation:t forKey:@"animation"];
    }
    else
    {
        CGFloat offset = self.currentOffset;//
        CATransform3D t3d = [self transform3DForViewIndex:index offset:offset];
        view.layer.transform = t3d;
    }
}

- (NSArray *)keyframeValuesForViewIndex:(NSInteger)index
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < self.datasource.count + 1; i ++)
    {
        [array addObject:[NSValue valueWithCATransform3D:[self transform3DForViewIndex:index frame:i]]];
    }
    return array;
}

- (CATransform3D)transform3DForViewIndex:(NSInteger)index frame:(NSInteger)frame
{
    CGFloat steper = self.lastAutoOffset / self.datasource.count;
    CGFloat offset = steper * frame + self.currentOffset;
    CATransform3D t3d = [self transform3DForViewIndex:index offset:offset];
    return t3d;
}

- (CATransform3D)transform3DForViewIndex:(NSInteger)index offset:(CGFloat)offset
{
    CGFloat w = self.bounds.size.width * kBaseWidth;
    CGFloat r = w / 2 / tan(kRadainWithNum(self.datasource.count) / 2) + 20;
    
    CGFloat rad_inx = kRadainWithNum(self.datasource.count) * index;
    CGFloat radian = rad_inx + offset;
    
    CATransform3D t3d = CATransform3DIdentity;
    t3d.m34 = - 1 / 600.;
    t3d = CATransform3DRotate(t3d, radian, 0, 1, 0);
    t3d = CATransform3DTranslate(t3d, 0, 0, r);
    
    return t3d;
}

- (NSArray *)keyframeTimesForViewIndex:(NSInteger)index
{
    static NSMutableArray *array = nil;
    if (array == nil || array.count != self.datasource.count + 1)
    {
        array = [NSMutableArray array];
        CGFloat depper = 1.0 / self.datasource.count;
        for (NSInteger i = 0; i < self.datasource.count + 1; i ++)
        {
            [array addObject:@(depper * i)];
        }
    }
    return array;
}

#pragma mark - setters getters
- (NSMutableArray *)datasource
{
    if (_datasource == nil)
    {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (NSArray *)viewsForImages:(NSArray *)images
{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger index = 0;
    for (UIImage *image in images)
    {
        CarrouselImageView *view = [self viewWithImage:image];
        view.index = index;
        index ++;
        [array addObject:view];
    }
    return array;
}

- (CarrouselImageView *)viewWithImage:(UIImage *)image
{
    CGFloat imgw = image.size.width;
    CGFloat imgh = image.size.height;
    
    // 宽度一定 高度按照原图片宽高比设定
    CGRect frame = self.bounds;
    CGFloat w = frame.size.width * kBaseWidth;
    CGFloat h = MIN(w * imgh / imgw, frame.size.height - 10);
    CGFloat x = frame.size.width * (1 - kBaseWidth) / 2;
    CGFloat y = (frame.size.height - h) / 2;
    CarrouselImageView *imv = [[CarrouselImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    imv.showReflect = self.showReflectLayer;
    imv.delegate = self;
    imv.backgroundColor = [UIColor magentaColor];
    imv.image = image;
    imv.contentMode = UIViewContentModeScaleToFill;// 铺满
    return imv;
}

- (CGFloat)lastAutoOffset
{
    // 每3秒转过一张图片
    return kAngelToRad(360 / self.datasource.count / self.animationSpeed) * (self.swipeToRight ? 1 : -1);
}

- (void)setCanAutoRotate:(BOOL)canAutoRotate
{
    if (_canAutoRotate == canAutoRotate || self.touchesMoved)// 手动操作
    {
        return;
    }
    _canAutoRotate = canAutoRotate;
    if (_canAutoRotate)
    {
        [self startTimer];
    }
    else
    {
        [self endTimerRemoveAnimation:NO];
    }
}

- (void)setAnimationSpeed:(CGFloat)animationSpeed
{
    if (_animationSpeed == animationSpeed)
    {
        return;
    }
    // 限制在0.2~6s
    animationSpeed = MIN(MAX(0.2, animationSpeed), 6);
    _animationSpeed = animationSpeed;
}

- (void)setShowReflectLayer:(BOOL)showReflectLayer
{
    if (_showReflectLayer == showReflectLayer)
    {
        return;
    }
    _showReflectLayer = showReflectLayer;
}

- (void)dealloc
{
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}
NSComparisonResult compareViewDepth(UIView *view1, UIView *view2, LRCarrouselView *self)
{
    //compare depths
    CATransform3D t1 = view1.layer.transform;
    CATransform3D t2 = view2.layer.transform;
    CGFloat z1 = t1.m13 + t1.m23 + t1.m33 + t1.m43;
    CGFloat z2 = t2.m13 + t2.m23 + t2.m33 + t2.m43;
    CGFloat difference = z1 - z2;
    
    //if depths are equal, compare distance from current view
    if (difference == 0.0)
    {
        CATransform3D t3 = [self currentItemView].layer.transform;
        CGFloat x1 = t1.m11 + t1.m21 + t1.m31 + t1.m41;
        CGFloat x2 = t2.m11 + t2.m21 + t2.m31 + t2.m41;
        CGFloat x3 = t3.m11 + t3.m21 + t3.m31 + t3.m41;
        difference = fabs(x2 - x3) - fabs(x1 - x3);
    }
    return (difference < 0.0)? NSOrderedAscending: NSOrderedDescending;
}

- (CarrouselImageView *)currentItemView
{
    CGFloat offnum = [self excessFloat:self.currentOffset base:2 * M_PI] / kAngelToRad(360 / self.datasource.count);//转过的个数 0~count
    NSInteger index = (NSInteger)offnum;
    index = self.datasource.count - 1 - index;
//    NSLog(@"offnum:%f index:%d", offnum, index);
    CarrouselImageView *view = self.datasource[index];
    return view;
}

- (CGFloat)excessFloat:(CGFloat)d base:(CGFloat)b
{
    b = fabs(b);
    NSInteger n = fabs(d / b);
    CGFloat excess = d - n * b;
    if (d < 0)
    {
        n = n + 1;
        excess = d + n * b;
    }
    return excess;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end





