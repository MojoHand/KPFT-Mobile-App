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
	
	
	return self;
}

//======================================================================================================

- (void)dealloc 
{
	[super dealloc];
}

//======================================================================================================

- (void)createModel 
{
	self.dataSource = [[[ScheduleDataSource alloc] init]
					   autorelease];
}

//======================================================================================================

@end
