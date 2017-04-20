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

@interface MPChannelsViewController () <UITableViewDelegate,UITableViewDataSource,MPChannelsHeaderTableViewCellDelegate>

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
            cell.delegate = self;
        }
        
        return cell;

    }
    else
    {
        MPChannelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MPChannelsTableViewCellIndetifier];
        if (cell == nil)
        {
            cell = [[MPChannelsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MPChannelsTableViewCellIndetifier];
            [cell insertCellWithTitle:@"#明日之子#" subTitle:@"2582.3万播放" image:[UIImage imageNamed:@"icon_cell_like"]];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPChannelsTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIViewController * VC = [[UIViewController alloc]init];
    VC.title = cell.titleLabel.text;
    VC.view.backgroundColor = MPColor_VCBackgroundGray;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)channelsHeaderTableViewCellDidSelected:(MPTopChannelsCollectionViewCell *)sender
{
    UIViewController * VC = [[UIViewController alloc]init];
    VC.title = sender.title;
    VC.view.backgroundColor = MPColor_VCBackgroundGray;
    [self.navigationController pushViewController:VC animated:YES];

}

-(void)channelsHeaderTopbuttonDidClicked:(UIButton *)sender
{
    UIViewController * VC = [[UIViewController alloc]init];
    VC.title = sender.titleLabel.text;
    VC.view.backgroundColor = MPColor_VCBackgroundGray;
    [self.navigationController pushViewController:VC animated:YES];
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
