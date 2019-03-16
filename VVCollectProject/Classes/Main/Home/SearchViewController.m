//
//  SearchViewController.m
//  Colors
//
//  Created by Ignacio Romero Z. on 7/4/14.
//  Copyright (c) 2014 DZN Labs. All rights reserved.
//

#import "SearchViewController.h"
#import "Palette.h"
#import "Color.h"

@interface SearchViewController ()
@property (nonatomic, strong) NSArray *searchResult;
@property (nonatomic, getter = isShowingLandscape) BOOL showingLandscape;

@property (nonatomic, strong) UIImageView *colorView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *hexLabel;
@property (nonatomic, strong) UILabel *rgbLabel;
@property (nonatomic, strong) UILabel *hexLegend;
@property (nonatomic, strong) UILabel *rgbLegend;

@end

@implementation SearchViewController

#pragma mark - View lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.title = @"Search";
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[UIImage imageNamed:@"tab_search"] tag:self.title.hash];
}

- (void)loadView
{
    [super loadView];
    
    if ([self.navigationController.viewControllers count] == 1) {
        self.searchDisplayController.displaysSearchBarInNavigationBar = YES;
    }
    else {
        self.title = @"Detail";
    }
    
//    self.searchDisplayController.searchResultsTableView.emptyDataSetSource = self;
//    self.searchDisplayController.searchResultsTableView.emptyDataSetDelegate = self;
    
    self.searchDisplayController.searchBar.placeholder = @"Search color";
    self.searchDisplayController.searchResultsTableView.tableFooterView = [UIView new];
    [self.searchDisplayController setValue:@"" forKey:@"_noResultsMessage"];
    
    for (UIView *subview in self.view.subviews) {
        subview.autoresizingMask = UIViewAutoresizingNone;
    }
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Search";
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[UIImage imageNamed:@"tab_search"] tag:self.title.hash];
    
    [self initUI];
    
    self.showingLandscape = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation);
    [self updateLayoutAnimatedWithDuration:0.0];
}

- (void)initUI {
    
    self.colorView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    [self.view addSubview:self.colorView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 300, 200, 30)];
    [self.view addSubview:self.nameLabel];
    
    self.hexLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 340, 200, 30)];
    [self.view addSubview:self.hexLabel];
    
    self.rgbLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 380, 200, 30)];
    [self.view addSubview:self.rgbLabel];
    
    self.hexLegend = [[UILabel alloc] initWithFrame:CGRectMake(200, 400, 200, 30)];
    [self.view addSubview:self.hexLegend];
    
    self.rgbLegend = [[UILabel alloc] initWithFrame:CGRectMake(200, 430, 200, 30)];
    [self.view addSubview:self.rgbLegend];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateContent];
}


#pragma mark - Getters

- (NSArray *)searchResult
{
    if (_searchResult) {
        return _searchResult;
    }
    
    NSString *searchString = self.searchDisplayController.searchBar.text;
    
    if (searchString.length == 0) {
        return nil;
    }
    
    NSArray *colors = [[Palette sharedPalette] colors];
    NSPredicate *precidate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@ || hex CONTAINS[cd] %@", searchString, searchString];
    
    _searchResult = [colors filteredArrayUsingPredicate:precidate];
    
    return _searchResult;
}


#pragma mark - Actions

- (void)updateLayoutAnimatedWithDuration:(NSTimeInterval)duration
{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    if (self.showingLandscape) {
        self.colorView.frame = CGRectMake(45.0, 88.0, 160.0, 160.0);
        self.nameLabel.frame = CGRectMake(240.0, 114.0, 280.0, 35.0);
        self.hexLabel.frame = CGRectMake(300.0, 170.0, 140.0, 20.0);
        self.rgbLabel.frame = CGRectMake(300.0, 200.0, 140.0, 20.0);
        self.hexLegend.frame = CGRectMake(240.0, 170.0, 60.0, 20.0);
        self.rgbLegend.frame = CGRectMake(240.0, 200.0, 60.0, 20.0);
        
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    else {
        self.colorView.frame = CGRectMake(60.0, 130.0, 200.0, 200.0);
        self.nameLabel.frame = CGRectMake(20.0, 350.0, 280.0, 35.0);
        self.hexLabel.frame = CGRectMake(120.0, 420.0, 140.0, 20.0);
        self.rgbLabel.frame = CGRectMake(120.0, 450.0, 140.0, 20.0);
        self.hexLegend.frame = CGRectMake(60.0, 420.0, 60.0, 20.0);
        self.rgbLegend.frame = CGRectMake(60.0, 450.0, 60.0, 20.0);
        
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    [UIView commitAnimations];
}

- (void)updateContent
{
    BOOL hide = self.selectedColor ? NO : YES;
    
    self.colorView.hidden = hide;
    self.nameLabel.hidden = hide;
    self.hexLabel.hidden = hide;
    self.rgbLabel.hidden = hide;
    self.hexLegend.hidden = hide;
    self.rgbLegend.hidden = hide;
    
    self.colorView.image = [Color roundImageForSize:self.colorView.frame.size withColor:self.selectedColor.color];
    
    self.nameLabel.text = self.selectedColor.name;
    self.hexLabel.text = [NSString stringWithFormat:@"#%@", self.selectedColor.hex];
    self.rgbLabel.text = self.selectedColor.rgb;
}

- (void)adjustToDeviceOrientation
{
    self.showingLandscape = UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation);
    [self updateLayoutAnimatedWithDuration:0.25];
    
//    [self.searchDisplayController.searchResultsTableView reloadEmptyDataSet];
}




#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.selectedBackgroundView = [UIView new];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        cell.textLabel.textColor = [UIColor colorWithWhite:0.125 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    }
    
    Color *color = self.searchResult[indexPath.row];
    
    cell.textLabel.text = color.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"#%@", color.hex];
    
    cell.imageView.image = [Color roundThumbWithColor:color.color];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56.0;
}


#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedColor = self.searchResult[indexPath.row];
    [self updateContent];
    
    [self.searchDisplayController setActive:NO animated:YES];
}


#pragma mark - UISearchDisplayControllerDelegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    _searchResult = nil;
    
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    // Do something
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    // Do something
}


#pragma mark - View Auto-Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (![self respondsToSelector:@selector(willTransitionToTraitCollection:withTransitionCoordinator:)]) {
        [self adjustToDeviceOrientation];
    }
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self adjustToDeviceOrientation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

@end
