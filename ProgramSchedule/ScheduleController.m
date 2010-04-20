//
//  ScheduleController.m
//  KPFT_App
//
//  Created by Nathan King of Mojo Hand Development
//

#import "ScheduleController.h"
#import "ScheduleDataSource.h"

@implementation ScheduleController

//======================================================================================================

- (id)init 
{
	self = [super init];

	self.dataSource = [TTListDataSource dataSourceWithObjects:
					   [TTTableTextItem itemWithText:@"Sunday" URL:@"kpft://programSchedule/Sunday" ],
					   [TTTableTextItem itemWithText:@"Monday" URL:@"kpft://programSchedule/Monday" ],
					   [TTTableTextItem itemWithText:@"Tuesday" URL:@"kpft://programSchedule/Tuesday" ],
					   [TTTableTextItem itemWithText:@"Wednesday" URL:@"kpft://programSchedule/Wednesday" ],
					   [TTTableTextItem itemWithText:@"Thursday" URL:@"kpft://programSchedule/Thursday" ],
					   [TTTableTextItem itemWithText:@"Friday" URL:@"kpft://programSchedule/Friday" ],
					   [TTTableTextItem itemWithText:@"Saturday" URL:@"kpft://programSchedule/Saturday" ],
					   nil];
							
			
	return self;
}

//======================================================================================================

- (void)dealloc 
{
	[super dealloc];
}

//======================================================================================================

//- (void)createModel 
//{
//	self.dataSource = [[[ScheduleDataSource alloc] init]
//					   autorelease];
//}

//======================================================================================================

@end
