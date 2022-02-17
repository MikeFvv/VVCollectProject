//
//  WinOrLoseRecordController.m
//  VVCollectProject
//
//  Created by Admin on 2022/2/18.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "WinOrLoseRecordController.h"
#import "WinLoseModel.h"
#import "ZPTableViewCell.h"
#import "BGameRecordCell.h"


@interface WinOrLoseRecordController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation WinOrLoseRecordController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];
}

#pragma mark - UI界面
- (void)createUI {
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[BGameRecordCell class] forCellReuseIdentifier:@"BaccaratCell"];
}



#pragma mark -  UITableView 初始化
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, mxwStatusNavBarHeight(), [[UIScreen mainScreen] bounds].size.width , [UIScreen mainScreen].bounds.size.height - mxwStatusNavBarHeight()) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor linkColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        _tableView.rowHeight = 76;   // 行高
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  // 去掉分割线
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    
    return _tableView;
}

- (void)onHeaderButtonClick:(UIButton *)sender {
    
    NSInteger tag = sender.tag -3000;
    if (tag == 0) {
        [self normalAdd];
    } else if (tag == 1) {
        [self popUpAdd];
    } else if (tag == 2) {
        [self remove];
    } else if (tag == 3) {
        [self update];
    } else if (tag == 4) {
        [self switchMode];
    }
}

#pragma mark ————— 正常添加对象 —————
- (void)normalAdd
{
    //创建新对象
    WinLoseModel *deal = [[WinLoseModel alloc] init];
    deal.money = @"30";
    deal.title = @"鱼香肉丝";
    deal.des = @"2c97690e72365e38e3e2a95b934b8dd2";
    
    /**
     数组的addObject方法会直接把新创建的对象放在数组的末尾，而insertObject方法则可以把对象添加到数组的指定位置。
     */
    [self.dataArray insertObject:deal atIndex:0];
    
    /**
     如果调用reloadData方法，则屏幕上出现一个cell系统就会调用一次创建该行cell所对应的cellForRowAtIndexPath方法，屏幕上出现多少个cell系统就会调用多少次cellForRowAtIndexPath方法。由此可见，调用reloadData方法的作用是刷新整个列表的数据。当只变更（增加、删除、更新）一行cell的时候，系统也会按照上述的逻辑去多次调用cellForRowAtIndexPath方法来刷新整个列表的数据；
     如果调用insertRowsAtIndexPaths方法，则当变更一行cell的时候系统只会调用一次创建该行cell所对应的cellForRowAtIndexPath方法，而创建其他行cell所对应的cellForRowAtIndexPath方法则不会被调用。由此可见，调用insertRowsAtIndexPaths方法的作用是只刷新变更行的数据，而列表中其他行的数据则不会被刷新。
     综上所述，如果只是变更一行cell的话，则应当调用insertRowsAtIndexPaths方法来刷新那行cell，这样比调用reloadData方法会大大节省系统的资源，提高系统的性能。
     */
    //    [self.tableView reloadData];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark ————— 在弹出框上添加对象 —————
- (void)popUpAdd
{
    /**
     UIAlertView和UIActionSheet已经被废弃了，由警告控制器(UIAlertController)来代替它们；
     UIAlertController的UIAlertControllerStyleAlert样式与UIAlertView相同，都是呈现在屏幕中间的菜单选择界面；
     UIAlertController的UIAlertControllerStyleActionSheet样式与UIActionSheet相同，都是从屏幕底下向上钻出来的最后呈现在屏幕底部的菜单选择界面。
     */
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"信息" preferredStyle:UIAlertControllerStyleAlert];
    
    //在UIAlertController上添加“确定”按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //创建新对象
        WinLoseModel *deal = [[WinLoseModel alloc] init];
        deal.money = [[alertController.textFields objectAtIndex:1] text];
        deal.title = [[alertController.textFields firstObject] text];
        deal.des = @"5ee372ff039073317a49af5442748071";
        
        //把新对象插入到对象数组中
        [self.dataArray insertObject:deal atIndex:0];
        
        //单行刷新新增加的对象所对应的cell
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    }]];
    
    //在UIAlertController上添加“取消”按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    //在UIAlertController上添加“破坏性按钮”按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"破坏性按钮" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了破坏性按钮");
    }]];
    
    /**
     在UIAlertController中添加文本输入框；
     只有在UIAlertController的样式为UIAlertControllerStyleAlert的时候才能在界面上添加文本输入框了，而当为UIAlertControllerStyleActionSheet样式的时候则不能在界面上添加文本输入框。
     */
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入团购商品的名字";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入团购商品的价格";
    }];
    
    //弹出UIAlertController
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark ————— 点击“删除”按钮 —————
- (void)remove
{
    //删除对象数组中特定位置的对象
    [self.dataArray removeObjectAtIndex:0];
    
    //删除被删除的对象所对应的cell
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationTop];
}


#pragma mark ————— 点击“更新”按钮 —————
- (void)update
{
    //修改对象
    WinLoseModel *deal = [self.dataArray objectAtIndex:3];
    deal.money = [NSString stringWithFormat:@"%d", 50 + arc4random_uniform(100)];
    
    //单行刷新被修改的对象所对应的cell
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:3 inSection:0], nil] withRowAnimation:UITableViewRowAnimationBottom];
}

#pragma mark ————— 点击“编辑”按钮 —————
- (void)switchMode
{
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}

#pragma mark ————— UITableViewDataSource —————
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

// 设置Cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath--%zd", indexPath.row);
    
    ZPTableViewCell *cell = [ZPTableViewCell cellWithTableView:tableView];
    cell.deal = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
    
    
    //    BGameRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaccaratCell"];
    //    if(cell == nil) {
    //        cell = [BGameRecordCell cellWithTableView:tableView reusableId:@"BaccaratCell"];
    //    }
    //    // 倒序
    //    cell.model = self.zhuPanLuResultDataArray[self.zhuPanLuResultDataArray.count - indexPath.row -1];
    //    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}

// Section header & footer information. Views are preferred over title should you decide to provide both
// 节头和页脚信息。 如果您决定提供两者，则视图优先于标题  2个
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // custom view for header. will be adjusted to default or specified header height
    //标题的自定义视图。 将被调整为默认或指定的标题高度
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor greenColor];
    
    CGFloat btnHeight = 40;
    CGFloat btnFont = 13;
    CGFloat spacingWidth = 6;
    
    
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn addTarget:self action:@selector(onHeaderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.titleLabel.font = [UIFont boldSystemFontOfSize:btnFont];
    [addBtn setTitle:@"正常添加" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    addBtn.backgroundColor = [UIColor blueColor];
    addBtn.layer.borderWidth = 4;
    addBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    addBtn.layer.cornerRadius = btnHeight/2;
    addBtn.tag = 3000;
    [backView addSubview:addBtn];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(spacingWidth);
        make.centerY.equalTo(backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, btnHeight));
    }];
    
    UIButton *popAddBtn = [[UIButton alloc] init];
    [popAddBtn addTarget:self action:@selector(onHeaderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    popAddBtn.titleLabel.font = [UIFont boldSystemFontOfSize:btnFont];
    [popAddBtn setTitle:@"弹出添加" forState:UIControlStateNormal];
    [popAddBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [popAddBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    popAddBtn.backgroundColor = [UIColor blueColor];
    popAddBtn.layer.borderWidth = 4;
    popAddBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    popAddBtn.layer.cornerRadius = btnHeight/2;
    popAddBtn.tag = 3001;
    [backView addSubview:popAddBtn];
    
    [popAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addBtn.mas_right).offset(spacingWidth);
        make.centerY.equalTo(backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, btnHeight));
    }];
    
    UIButton *deleteBtn = [[UIButton alloc] init];
    [deleteBtn addTarget:self action:@selector(onHeaderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:btnFont];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    deleteBtn.backgroundColor = [UIColor blueColor];
    deleteBtn.layer.borderWidth = 4;
    deleteBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    deleteBtn.layer.cornerRadius = btnHeight/2;
    deleteBtn.tag = 3002;
    [backView addSubview:deleteBtn];
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(popAddBtn.mas_right).offset(spacingWidth);
        make.centerY.equalTo(backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, btnHeight));
    }];
    
    UIButton *updateBtn = [[UIButton alloc] init];
    [updateBtn addTarget:self action:@selector(onHeaderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    updateBtn.titleLabel.font = [UIFont boldSystemFontOfSize:btnFont];
    [updateBtn setTitle:@"更新" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    updateBtn.backgroundColor = [UIColor blueColor];
    updateBtn.layer.borderWidth = 4;
    updateBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    updateBtn.layer.cornerRadius = btnHeight/2;
    updateBtn.tag = 3003;
    [backView addSubview:updateBtn];
    
    [updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(deleteBtn.mas_right).offset(spacingWidth);
        make.centerY.equalTo(backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, btnHeight));
    }];
    
    UIButton *editBtn = [[UIButton alloc] init];
    [editBtn addTarget:self action:@selector(onHeaderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    editBtn.titleLabel.font = [UIFont boldSystemFontOfSize:btnFont];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    editBtn.backgroundColor = [UIColor blueColor];
    editBtn.layer.borderWidth = 4;
    editBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    editBtn.layer.cornerRadius = btnHeight/2;
    editBtn.tag = 3004;
    [backView addSubview:editBtn];
    
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(updateBtn.mas_right).offset(spacingWidth);
        make.centerY.equalTo(backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, btnHeight));
    }];
    return backView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    // custom view for footer. will be adjusted to default or specified footer height
    // 页脚自定义视图。 将被调整为默认或指定的页脚高度
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor redColor];
    return backView;
}



/**
 在非编辑模式(self.tableView.isEditing == NO)下，只要实现了这个方法，左滑cell就会出现删除按钮；
 在编辑模式(self.tableView.isEditing == YES)下，系统先会调用editingStyleForRowAtIndexPath方法来判断每行cell是删除(UITableViewCellEditingStyleDelete)模式还是插入(UITableViewCellEditingStyleInsert)模式，然后点击cell上面的“加号”或“删除”按钮就会调用这个方法。
 */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)  //删除操作
    {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
    }else if (editingStyle == UITableViewCellEditingStyleInsert)  //插入操作
    {
        NSLog(@"点击了加号按钮");
    }
}

#pragma mark ————— UITableViewDelegate —————
/**
 在编辑模式(self.tableView.isEditing == YES)下，系统会调用这个方法来确定每行cell的编辑类型，删除(UITableViewCellEditingStyleDelete)还是插入(UITableViewCellEditingStyleInsert)。
 */
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0)  //偶数行删除
    {
        return UITableViewCellEditingStyleDelete;
    }else  //奇数行插入
    {
        return UITableViewCellEditingStyleInsert;
    }
}

#pragma mark ————— 懒加载 —————

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        WinLoseModel *model1 = [[WinLoseModel alloc] init];
        model1.title = @"HHHJKHK";
        
        WinLoseModel *model2 = [[WinLoseModel alloc] init];
        model2.title = @"黑科技和客户";
        
        WinLoseModel *model3 = [[WinLoseModel alloc] init];
        model3.title = @"一天就看见看见颗粒剂";
        
        _dataArray = [NSMutableArray arrayWithArray:@[model1, model2, model3]];
    }
    return _dataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


