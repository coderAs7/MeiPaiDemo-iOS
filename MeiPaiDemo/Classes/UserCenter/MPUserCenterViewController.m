 //
//  MPUserCenterViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPUserCenterViewController.h"
#import "MPUserCenterHeaderTableViewCell.h"
#import "MPUserCenterTableViewCell.h"
#import "MPUserCenterSectionHeaderView.h"

@interface MPUserCenterViewController () <UITableViewDelegate,UITableViewDataSource,MPUserCenterHeaderTableViewCellDelegate>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation MPUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    [self insertViewController];
}

NSString * MPUserCenterCellIndetifier = @"MPUserCenterCellIndetifier";
NSString * MPUserCenterHeaderCellIndetifier = @"MPUserCenterHeaderCellIndetifier";

-(void)insertViewController
{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = MPColor_VCBackgroundGray;
    
    self.title = @"我";
    
    
    [self.view addSubview:self.tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    if (indexPath.section == 0)
    {
        MPUserCenterHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MPUserCenterHeaderCellIndetifier];
        if (cell == nil)
        {
            cell = [[MPUserCenterHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MPUserCenterHeaderCellIndetifier];
            cell.delegate = self;
        }
        
        return cell;
    }
    else
    {
        MPUserCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MPUserCenterCellIndetifier];
        if (cell == nil)
        {
            cell = [[MPUserCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MPUserCenterCellIndetifier];
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            switch (indexPath.section)
            {
                case 1:
                {
                    if(indexPath.row == 0)
                    {
                        cell.imageView.image = [UIImage imageNamed:@"icon_cell_likesmall_a"];
                        cell.textLabel.text = @"草稿箱";
                    }
                    else if (indexPath.row == 1)
                    {
                        cell.imageView.image = [UIImage imageNamed:@"icon_cell_likesmall_a"];
                        cell.textLabel.text = @"我的钱包";
                    }
                    else if (indexPath.row == 2)
                    {
                        cell.imageView.image = [UIImage imageNamed:@"icon_cell_likesmall_a"];
                        cell.textLabel.text = @"我的等级";
                    }
                }
                    break;
                case 2:
                {
                    cell.imageView.image = [UIImage imageNamed:@"icon_cell_likesmall_a"];
                    cell.textLabel.text = @"我的等级";
                }
                    break;
                case 3:
                {
                    if(indexPath.row == 0)
                    {
                        cell.imageView.image = [UIImage imageNamed:@"icon_cell_likesmall_a"];
                        cell.textLabel.text = @"找好友";
                    }
                    else if (indexPath.row == 1)
                    {
                        cell.imageView.image = [UIImage imageNamed:@"icon_cell_likesmall_a"];
                        cell.textLabel.text = @"我赞过的美拍";
                    }
                }
                    break;
                case 4:
                {
                    cell.imageView.image = [UIImage imageNamed:@"icon_cell_likesmall_a"];
                    cell.textLabel.text = @"让视频更好玩";
                }
                    break;
                case 5:
                {
                    cell.imageView.image = [UIImage imageNamed:@"icon_cell_likesmall_a"];
                    cell.textLabel.text = @"设置";
                }
                    break;
                    
                default:
                    break;
            }
            
        }
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        return 230;
    }
    else
    {
        return 40;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[MPUserCenterSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    switch (section)
    {
        case 0:
            number = 1;
            break;
        case 1:
            number = 3;
            break;
        case 2:
            number = 1;
            break;
        case 3:
            number = 2;
            break;
        case 4:
            number = 1;
            break;
        case 5:
            number = 1;
            break;
            
        default:
            break;
    }
    return number;
}

-(void)topNameButtonClicked:(MPTopNameButtonView *)sender
{
    UIViewController * VC = [[UIViewController alloc]init];
    VC.title = sender.title;
    VC.view.backgroundColor = MPColor_VCBackgroundGray;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIViewController * VC = [[UIViewController alloc]init];
    VC.title = indexPath.section == 0 ? @"个人设置" : cell.textLabel.text;
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
