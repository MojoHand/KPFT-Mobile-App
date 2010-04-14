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

//
//- (id<TTTableViewDataSource>)createDataSource 
//{
//	ScheduleDataSource *dataSource = [[[ScheduleDataSource alloc] init] autorelease];
//	[dataSource.delegates addObject:self];
//	[dataSource load:TTURLRequestCachePolicyDefault nextPage:NO];
//
//	return dataSource;
//}
//
////======================================================================================================
//
//- (void)loadScheduleXML
//{
//	self.title = @"Program Schedule";
//	
//			
//	//if (_page == MenuPageBreakfast) {
////		self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
////						   @"Food",
////						   [TTTableTextItem itemWithText:@"Porridge" URL:@"tt://food/porridge"],
////						   [TTTableTextItem itemWithText:@"Bacon & Eggs" URL:@"tt://food/baconeggs"],
////						   [TTTableTextItem itemWithText:@"French Toast" URL:@"tt://food/frenchtoast"],
////						   @"Drinks",
////						   [TTTableTextItem itemWithText:@"Coffee" URL:@"tt://food/coffee"],
////						   [TTTableTextItem itemWithText:@"Orange Juice" URL:@"tt://food/oj"],
////						   @"Other",
////						   [TTTableTextItem itemWithText:@"Just Desserts" URL:@"tt://menu/4"],
////						   [TTTableTextItem itemWithText:@"Complaints" URL:@"tt://about/complaints"],
////						   nil];
////	} 
//}
//
@end
