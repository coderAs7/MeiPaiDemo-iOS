//
//  MPChannelsViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPChannelsViewController.h"
#import "MPChannelsHeaderTableViewCell.h"
#import "MPChannelsTableViewCell.h"

@interface MPChannelsViewController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation MPChannelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self insertViewController];
}

NSString * MPChannelsTableViewCellIndetifier = @"MPChannelsTableViewCell";
NSString * MPChannelsHeaderTableViewCellIndetifier = @"MPChannelsHeaderTableViewCell";

-(void)insertViewController
{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = MPColor_VCBackgroundGray;
    
    self.title = @"频道";
    
    
    [self.view addSubview:self.tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        MPChannelsHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MPChannelsHeaderTableViewCellIndetifier];
        if (cell == nil)
        {
            cell = [[MPChannelsHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MPChannelsHeaderTableViewCellIndetifier];
        }
        
        return cell;

    }
    else
    {
        MPChannelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MPChannelsTableViewCellIndetifier];
        if (cell == nil)
        {
            cell = [[MPChannelsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MPChannelsTableViewCellIndetifier];
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
    {
        return 410;
    }
    else
    {
        return 60;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 33;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
