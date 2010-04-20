//
//  ScheduleDayController.h
//  KPFT_App
//
//  Created by Nathan King of Mojo Hand Development
//

#import <Three20/Three20.h>


//typedef enum {
//	ProgramDaySunday,
//	ProgramDayMonday,
//	ProgramDayTuesday,
//	ProgramDayWednesday,
//	ProgramDayThursday,	
//	ProgramDayFriday,
//	ProgramSaturday
//} ProgramDay;

@interface ScheduleDayController : TTTableViewController
{
	NSString* programDay;
}

@property(nonatomic,copy) NSString* ProgramDay;

@end
