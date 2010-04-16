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
	
	//NSLog(@"Properties: %@", scheduleModel.properties);
	
	//NSMutableArray* itemRows = [[NSMutableArray alloc] init];
	
	
	//[items addObject:@"Sunday"];
	[items addObject:[TTTableTextItem itemWithText:@"Sunday" ]];
	[items addObject:[TTTableTextItem itemWithText:@"Monday"]];
	[items addObject:[TTTableTextItem itemWithText:@"Tuesday"]];
	[items addObject:[TTTableTextItem itemWithText:@"Wednesday"]];
	[items addObject:[TTTableTextItem itemWithText:@"Thursday"]];
	[items addObject:[TTTableTextItem itemWithText:@"Friday"]];
	[items addObject:[TTTableTextItem itemWithText:@"Saturday"]];
	
	//[items addObject:itemRows];
    
	//TT_RELEASE_SAFELY(itemRows);

	self.items = items;
		
	TT_RELEASE_SAFELY(items);
}

//==================================================================================================

@end
