//
//  KPFT_AppAppDelegate.m
//  KPFT_App
//
//  Created by Nathan King on 3/8/10.
//  Copyright Mojo Hand Development 2010. All rights reserved.
//

#import "AppDelegate.h"
#import "LauncherViewController.h"
#import "FeedsViewController.h"
#import "AboutViewController.h"
#import "ScheduleController.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AppDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
	TTNavigator* navigator = [TTNavigator navigator];
	TTURLMap* map = navigator.URLMap;
	
	FeedsViewController *fvController = [[FeedsViewController alloc] initWithTitle:@"News" withNavigationTitle:@"KPFT 90.1FM" withPropertyFile:@"feeds.plist"];
	AboutViewController *avController = [[AboutViewController alloc] init];
	//NSString *urlString = [[NSString alloc] initWithString:@"bundle://About_Screen.html"];
	//NSURL *scheduleURL = [[NSURL alloc] initWithString:urlString];
	//TTWebController *webController = [[TTWebController alloc] initWithNavigatorURL:scheduleURL  (NSDictionary *)quer]
	//fvController.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.14 green:0.18 blue:0.25 alpha:1.00];
	//avController.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.14 green:0.18 blue:0.25 alpha:1.00];
	
	
	[map from:@"*" toViewController:[TTWebController class]];
	[map from:@"kpft://launcher" toViewController:[LauncherViewController class]];
	[map from:@"kpft://newsfeed" toViewController:fvController];
	[map from:@"kpft://about" toViewController:avController];
	[map from:@"kpft://programSchedule" toViewController:[ScheduleController class]];

	
	[navigator openURLAction:[TTURLAction actionWithURLPath:@"kpft://launcher"]];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)navigator:(TTNavigator*)navigator shouldOpenURL:(NSURL*)URL 
{
  return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL 
{
  [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
  return YES;
}


@end
