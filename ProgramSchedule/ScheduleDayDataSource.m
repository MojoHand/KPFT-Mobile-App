//
//  ScheduleDayDataSource.m
//  KPFT_App
//
//  Created by Nathan King of Mojo Hand Development
//


#import "ScheduleDayDataSource.h"
#import "ScheduleDayModel.h"

@implementation ScheduleDayDataSource


//==================================================================================================

- (id)initWithDay:(NSString*)ProgramDay
{
	scheduleDayModel = [[ScheduleDayModel alloc] init];
	
	return self;
}

//==================================================================================================

- (void)dealloc 
{
	TT_RELEASE_SAFELY(scheduleDayModel);
	
	[super dealloc];
}

//==================================================================================================

- (id<TTModel>)model 
{
	return scheduleDayModel;
}

//==================================================================================================

- (void)tableViewDidLoadModel:(UITableView*)tableView 
{
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	NSLog(@"Properties: %@", scheduleDayModel.properties);
	
	for (NSString *showName in scheduleDayModel.properties)
	{
		//[items addObject:showName];
		//[TTTableTextItem itemWithText:@"Sunday" URL:@"kpft://programSchedule/Sunday" ],
		[items addObject: [TTTableTextItem itemWithText:showName]];
	}
		
	
	
	self.items = items;
	
	TT_RELEASE_SAFELY(items);
}

//==================================================================================================


@end
