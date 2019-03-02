//
//  TestVVUITableViewController.m
//  VVCollectProject
//
//  Created by 罗耀生 on 2019/2/22.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "TestVVUITableViewController.h"

@interface TestVVUITableViewController ()

@end

@implementation TestVVUITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    //取消注释以下行以保留演示文稿之间的选择。
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //取消注释以下行以在此视图控制器的导航栏中显示“编辑”按钮。
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



#pragma mark - UITableViewDataSource 11个 2个必须实现
// //返回列表每个分组section拥有cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

// //配置每个cell，随着用户拖拽列表，cell将要出现在屏幕上时此方法会不断调用返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.定义一个cell的标识
    static NSString *ID = @"reuseIdentifier";
    // 2.从缓存池中取出cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果缓存池中没有cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = @"aaa";
    cell.detailTextLabel.text = @"bbb";
    // 4.设置cell的属性...
    return cell;
    return cell;
}

// 设置节数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
// 设置头部title
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"头部title";
}
// 设置尾部title
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"尾部title";
}

// 编辑
// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
// 单个行可以选择不为它们设置-editing属性。 如果未实现，则假定所有行都是可编辑的。
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
//移动/重新排序

//允许为特定行显示重新排序附件视图。 默认情况下，仅当数据源实现-tableView：moveRowAtIndexPath：toIndexPath时，才会显示重新排序控件：
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Index
// 索引
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    // return list of section titles to display in section index view (e.g. "ABCD...Z#")
    // 返回要在节索引视图中显示的节标题列表（例如“ABCD ... Z＃”）
    return @[@"A",@"B",@"C",@"D"];
}
// return list of section titles to display in section index view (e.g. "ABCD...Z#")
//返回要在节索引视图中显示的节标题列表（例如“ABCD ... Z＃”）
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    // tell table which section corresponds to section title/index (e.g. "B",1))
    //告诉表哪个部分对应于部分标题/索引（例如“B”，1））
    return 1;
}


// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead

//数据操作 - 插入和删除支持

//在一行调用减号或加号按钮后（基于单元格的UITableViewCellEditingStyle），dataSource必须提交更改
//不使用UITableViewRowAction调用编辑操作 - 将调用操作的处理程序
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //         从数据源中删除行
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //         创建相应类的新实例，将其插入到数组中，然后向表视图添加新行
    }
}


// Data manipulation - reorder / moving support
//数据操作 - 重新排序/移动支持
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}




#pragma mark - UITableViewDelegate 38个

#pragma mark - 显示用户自定义  6个
// Display customization
// 显示用户自定义  6个

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0) {
    
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    
}

#pragma mark - 高度设置支持 6个
// Variable height support
// 高度设置支持 6个
// 设置Cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 1;
}
// 设置头部title行高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}
// 设置尾部title行高
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
//使用estimatedHeight方法快速计算猜测值，这将允许表的快速加载时间。
//如果实现了这些方法，上面的-tableView：heightForXXX调用将被推迟到视图准备好显示，因此可以在那里放置更昂贵的逻辑。
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0) {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0) {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0) {
    return 1;
}

// Section header & footer information. Views are preferred over title should you decide to provide both
// 节头和页脚信息。 如果您决定提供两者，则视图优先于标题  2个
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // custom view for header. will be adjusted to default or specified header height
    //标题的自定义视图。 将被调整为默认或指定的标题高度
    return [[UIView alloc] init];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    // custom view for footer. will be adjusted to default or specified footer height
    // 页脚自定义视图。 将被调整为默认或指定的页脚高度
    return [[UIView alloc] init];
}

#pragma mark - 访问配置形式 2个
// Accessories (disclosures).
// 访问配置形式 2个

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED {
    return nil;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - 选择 7个
// Selection
// 选择 7个

// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
// -tableView：shouldHighlightRowAtIndexPath：在一行触摸时调用。
//对该消息返回NO将停止选择过程，并且在触摸关闭时不会导致当前选定的行丢失其选定的外观。
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0) {
    return YES;
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0) {
    
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0) {
    
}

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
//在用户更改选择之前调用。 返回一个新的indexPath或nil，以更改建议的选择。
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) {
    return nil;
}
// Called after the user changes the selection.
// //在用户更改选择后调用。
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) {
    
}

#pragma mark - 编辑 6个
// Editing
// 编辑 6个

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
//允许为位于'indexPath'的特定单元格自定义editingStyle。 如果未实现，当表的编辑属性设置为YES时，所有可编辑单元格都将为它们设置UITableViewCellEditingStyleDelete。
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED {
    return @"";
}

// Use -tableView:trailingSwipeActionsConfigurationForRowAtIndexPath: instead of this method, which will be deprecated in a future release.
// This method supersedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
//使用-tableView：trailingSwipeActionsConfigurationForRowAtIndexPath：而不是此方法，将在以后的版本中弃用。
//此方法取代-tableView：titleForDeleteConfirmationButtonForRowAtIndexPath：if return value is non-nil
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED {
    return [NSArray new];
}

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
//控制在编辑时是否缩进背景。 如果未实现，则默认为YES。 这与下面的缩进级别无关。 此方法仅适用于分组样式表视图。
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
//只要表格自动更改'editing'属性（允许插入/删除/移动），就会调用willBegin / didEnd方法。 这是通过滑动激活单行来完成的
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED {
    
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath __TVOS_PROHIBITED {
    
}

#pragma mark - 移动/重新排序 1个
// Moving/reordering
// 移动/重新排序 1个

// Allows customization of the target row for a particular row as it is being moved/reordered
//允许在移动/重新排序时自定义特定行的目标行
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    return nil;
}

#pragma mark - 缩进 1个
// Indentation
// 缩进 1个

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    // return 'depth' of row for hierarchies
    // 返回层次结构的行的“深度”
    return 1;
}

#pragma mark - 复制粘贴 3个
// 复制粘贴 3个
// Copy/Paste.  All three methods must be implemented by the delegate.
// // 复制粘贴。 所有三种方法都必须由代表实施。  3个

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0) {
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0) {
    return YES;
}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0) {
    
}

#pragma mark - 焦点 4个
// Focus
// 焦点 4个

- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0) {
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0) {
    return YES;
}
- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0) {
    
}
- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0) {
    return nil;
}


@end
