//
//  ViewController.m
//  hamburgerMenu
//
//  Created by Sam Wong on 11/24/14.
//  Copyright (c) 2014 Sam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (retain, nonatomic) IBOutlet UIButton *burgerButton;
@property (strong, nonatomic) UIViewController *currentVC;
@property (strong, nonatomic) UIViewController *burgerVC;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *teams;
@property BOOL isActiveBurger;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Create the burgerVC
    self.burgerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BURGER_VC"];
    [self addChildViewController:self.burgerVC];
    self.burgerVC.view.frame = self.view.frame;
    [self.view insertSubview:self.burgerVC.view belowSubview:self.burgerButton];
    [self.view insertSubview:self.tableView.viewForBaselineLayout belowSubview:self.burgerVC.view];
    [self.burgerVC didMoveToParentViewController:self];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.teams = [[[NSArray alloc] initWithObjects: @"49ers",@"Giants",@"Warriors",nil] autorelease];
    
    self.isActiveBurger = NO;
}

- (IBAction)burgerDidPress:(id)sender {
    if (self.isActiveBurger == NO) {
        [UIView animateWithDuration:0.4 animations:^{
            self.burgerVC.view.frame = CGRectMake(self.view.frame.size.width * 0.8, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
        self.isActiveBurger = YES;
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            self.burgerVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
        self.isActiveBurger = NO;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.teams.count == 0) {
        return 0;
    } else {
        return self.teams.count;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textLabel.text = self.teams[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)dealloc {
    [_burgerButton release];
    [_currentVC release];
    [_burgerVC release];
    [_teams release];
    [_tableView release];
    [super dealloc];
}
@end
