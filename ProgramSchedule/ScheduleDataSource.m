//
//  ScheduleDataSource.m
//  KPFT_App
//
//  Created by Nathan King of Mojo Hand Development
//
//	Thanks to Mark at reventkn.com
//

#import "ScheduleDataSource.h"


@implementation ScheduleDataSource

@end
//===================================================================================================

//(void)load:(TTURLRequestCachePolicy)cachePolicy nextPage:(BOOL)nextPage 
//{
//	TTURLRequest *request =
//	[TTURLRequest requestWithURL:@"http://kpft.org/ProgramSchedule.xml" delegate:self];
//	
//	request.cachePolicy = cachePolicy;
//	request.response = [[[TTURLDataResponse alloc] init] autorelease];
//	request.httpMethod = @"GET";
//	[request send];
//}
//
////===================================================================================================
//
//- (void)requestDidFinishLoad:(TTURLRequest*)request 
//{
//	TTURLDataResponse *response = request.response;
//	NSString *json = [[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding];
//	
//	// Load up self.items with json data however you'd like
//	
//	[json release];
//	
//	_loading = NO;
//	_loaded = YES;  
//	
//	[self dataSourceDidFinishLoad];
//}
//
////===================================================================================================
//
//- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error 
//{
//	_loading = NO;
//	_loaded = YES;
//	[self dataSourceDidFailLoadWithError:error];
//}
//
////===================================================================================================
//
//
//@end
