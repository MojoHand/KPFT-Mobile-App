//
//  ScheduleDayDataSource.m
//  KPFT_App
//
//  Created by Nathan King of Mojo Hand Development
//


#import "ScheduleDayDataSource.h"
#import "ScheduleDayModel.h"
#import "ShowInfo.h"

@implementation ScheduleDayDataSource

//@synthesize ProgramDay = programDay;

//==================================================================================================

- (id)initWithDay:(NSString*)ProgramDay
{
	if ( self = [super init] )
	{
		scheduleDayModel = [[ScheduleDayModel alloc] initWithDay:ProgramDay];
	}
	
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
	
	for (ShowInfo *show in scheduleDayModel.properties)
	{
		NSString *showTitle = show.ShowTitle;
		
		// Convert string to date object
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"HH:mm"];
		NSDate *startTime = [dateFormat dateFromString:show.StartTime];  
		NSDate *endTime = [dateFormat dateFromString:show.EndTime];  
		
		// Convert date object to desired output format
		[dateFormat setDateFormat:@"h:mma"];
		NSString *startTimeStr = [dateFormat stringFromDate:startTime];  
		NSString *endTimeStr = [dateFormat stringFromDate:endTime];  
		[dateFormat release];
		
		//NSString *time = [NSString stringWithFormat:@"%@ - %@", [show.StartTime formatTime], 
		//				  [show.EndTime formatTime]];
		NSString *time = [NSString stringWithFormat:@"%@ - %@", startTimeStr, endTimeStr];
		
		[items addObject: [TTTableSubtitleItem itemWithText:showTitle subtitle:time ]];
	}
		
	
	
	self.items = items;
	
	TT_RELEASE_SAFELY(items);
}

//==================================================================================================


@end
