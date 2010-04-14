//
//  ScheduleDataSource.m
//  KPFT_App
//
//  Created by Nathan King of Mojo Hand Development
//
//	Thanks to Mark at reventkn.com
//

#import "ScheduleDataSource.h"
#import "ScheduleModel.h"

@implementation ScheduleDataSource

//==================================================================================================

- (id)init
{
	scheduleModel = [[ScheduleModel alloc] init];
	
	return self;
}

//==================================================================================================

- (void)dealloc 
{
	TT_RELEASE_SAFELY(scheduleModel);
	
	[super dealloc];
}

//==================================================================================================

- (id<TTModel>)model 
{
	return scheduleModel;
}

//==================================================================================================

- (void)tableViewDidLoadModel:(UITableView*)tableView 
{
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	self.items = items;
	
	NSLog(@"Properties: %@", scheduleModel.properties);
	
	
	TT_RELEASE_SAFELY(items);
}

//==================================================================================================

@end
