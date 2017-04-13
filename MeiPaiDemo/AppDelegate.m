//
//  AppDelegate.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/12.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "AppDelegate.h"

#import "MPTabBarController.h"
#import "MPMainViewController.h"
#import "MPMyFollowViewController.h"
#import "MPChannelsViewController.h"
#import "MPUserCenterViewController.h"

@interface AppDelegate ()

@property(nonatomic,strong)MPTabBarController * tabBarC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self insertApplication:application didFinishLaunchingWithOptions:launchOptions];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)insertApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    MPTabBarController * tabBarC = [[MPTabBarController alloc]init];
    tabBarC.viewControllers = @[[self createNCWithClass:[MPMainViewController class] title:@"美拍"],
                                [self createNCWithClass:[MPMyFollowViewController class] title:@"我的关注"],
                                [self createNCWithClass:[MPChannelsViewController class] title:@"频道"],
                                [self createNCWithClass:[MPUserCenterViewController class] title:@"我"]];
    self.window.rootViewController = tabBarC;
    return YES;
}

-(UINavigationController *)createNCWithClass:(Class)class title:(NSString *)title
{
    UIViewController * VC = [[class alloc]init];
    UINavigationController * NC = [[UINavigationController alloc]initWithRootViewController:VC];
    NC.title = title;
    return NC;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
