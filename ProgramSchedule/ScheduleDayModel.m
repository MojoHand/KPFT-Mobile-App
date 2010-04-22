//
//  ScheduleModel.c
//  KPFT_App
//
//  Created by Nathan King of Mojo Hand Development
//

#import "CXMLDocument.h"
#import "CXMLElement.h"
#import "CXMLNode.h"
#import "CXMLNode_XPathExtensions.h"
#import "ScheduleDayModel.h"
#import "ShowInfo.h"



@implementation ScheduleDayModel

@synthesize properties = _properties;
@synthesize ProgramDay = programDay;

//==================================================================================================

- (id)initWithDay:(NSString*)ProgramDay
{
	if ( self = [super init] )
	{
		self.ProgramDay = ProgramDay;
	}
	
	return self;
}

//=====================================================================================================

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more 
{
	if( !self.isLoading ) 
	{
		NSString* url = @"http://www.kpft.org/documents/ProgramSchedule.xml";
		
		TTURLRequest* request = [TTURLRequest
								 requestWithURL: url
								 delegate: self];
		
		id<TTURLResponse> response = [[TTURLDataResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		request.cachePolicy = cachePolicy;
		[request send];
	}
}

//=====================================================================================================

- (void)requestDidFinishLoad:(TTURLRequest*)request 
{
	TTURLDataResponse* response = request.response;
	
	// Useful debugging logic.
	//NSString* string = [[NSString alloc] initWithData: response.data
	//	                                          encoding: NSUTF8StringEncoding];
	//	NSLog(@"string: %@", string);
	//	TT_RELEASE_SAFELY(string);
	
	// Ensure that we don't cause a leak.
	TT_RELEASE_SAFELY(_properties);
	_properties = [[NSMutableArray alloc] init];
	
	CXMLDocument *scheduleParser = [[[CXMLDocument alloc] initWithData:response.data options:0 error:nil] autorelease];
	
	// Create a new Array object to be used with the looping of the results from the rssParser
    NSArray *titleNodes = NULL;
	NSArray *startTimeNodes = NULL;
	NSArray *endTimeNodes = NULL;
	
	NSString *titlePath = [NSString stringWithFormat:@"//Schedule/%@/show/title",self.ProgramDay];
	NSString *startTimePath = [NSString stringWithFormat:@"//Schedule/%@/show/time/start",self.ProgramDay];
	NSString *endTimePath = [NSString stringWithFormat:@"//Schedule/%@/show/time/end",self.ProgramDay];
	
	
	
	titleNodes = [scheduleParser nodesForXPath:titlePath error:nil];
	startTimeNodes = [scheduleParser nodesForXPath:startTimePath error:nil];
	endTimeNodes = [scheduleParser nodesForXPath:endTimePath error:nil];
	
	ShowInfo *showInfo;
	
	for (int i = 0; i < [titleNodes count]; i++)
	{
		showInfo = [[ShowInfo alloc] init];
		
		showInfo.ShowTitle = [[titleNodes objectAtIndex:i] stringValue];
		showInfo.StartTime = [[startTimeNodes objectAtIndex:i] stringValue];
		showInfo.EndTime = [[endTimeNodes objectAtIndex:i] stringValue];
	
		
		[_properties addObject:showInfo];
	}
	
	[super requestDidFinishLoad:request];
}

//=====================================================================================================

-(void)dealloc
{	
	TT_RELEASE_SAFELY(_properties);
	//TT_RELEASE_SAFELY(_activePropertyKey);
	
	[super dealloc];
}

//=====================================================================================================


@end
