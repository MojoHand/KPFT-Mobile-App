//
//  ScheduleDayController.m
//  KPFT_App
//
//  Created by Nathan King of Mojo Hand Development
//

#import "ScheduleDayController.h"
#import "ScheduleDayDataSource.h"

@implementation ScheduleDayController

@synthesize ProgramDay = programDay;

//======================================================================================================

- (id)initWithDay:(NSString*)ProgramDay
{
	if ( self = [super init] )
	{
		self.ProgramDay = ProgramDay;
	}
	
	return self;
}

//======================================================================================================

- (void)createModel 
{
	self.dataSource = [[[ScheduleDayDataSource alloc] initWithDay:self.ProgramDay]
					   autorelease];
}

//======================================================================================================

@end
