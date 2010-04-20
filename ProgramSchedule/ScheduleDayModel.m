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




@implementation ScheduleDayModel

@synthesize properties = _properties;

//=====================================================================================================


- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more 
{
	if( !self.isLoading ) 
	{
		NSString* url = @"http://mojohanddev.com/ProgramSchedule.xml";
		
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
    NSArray *resultNodes = NULL;
	
	// Set the resultNodes Array to contain an object for every instance of an  node in our RSS feed
	resultNodes = [scheduleParser nodesForXPath:@"//Schedule/Sunday/show/title" error:nil];
	
	
	for (CXMLElement *resultElement in resultNodes)
	{
		
		//NSLog(@" resultElement: %@", resultElement);
				
		[_properties addObject:[resultElement stringValue]];
	}

		
	[super requestDidFinishLoad:request];
}

//=====================================================================================================
//
//- (void)setActivePropertyKey:(NSString*)activePropertyKey
//{
//	NSString* keyCopy = [activePropertyKey copy];
//	[_activePropertyKey release];
//	_activePropertyKey = keyCopy;
//	
//}
//
////=====================================================================================================
//
//- (void)parser:          (NSXMLParser*)parser
//didStartElement: (NSString*)elementName
//  namespaceURI: (NSString*)namespaceURI
// qualifiedName: (NSString*)qName
//	attributes: (NSDictionary*)attributeDict 
//{
//	
//	[self setActivePropertyKey: elementName];
//	
//}
//
////=====================================================================================================
//
//- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
//{
//	if( nil != _activePropertyKey ) 
//	{
//		NSString* property = [_properties objectForKey:_activePropertyKey];
//		if( nil == property ) 
//		{
//			property = [[NSString alloc] init];
//			[_properties setObject:property forKey:_activePropertyKey];
//			[property release];
//		}
//		
//		[_properties setObject: [property stringByAppendingString:string]
//						forKey: _activePropertyKey];
//	}
//}
//
////=====================================================================================================
//
//- (void)parser:        (NSXMLParser *)parser
// didEndElement: (NSString *)elementName
//  namespaceURI: (NSString *)namespaceURI
// qualifiedName: (NSString *)qName 
//{
//	if( nil != _activePropertyKey )
//	{
//		//if( [_activePropertyType isEqualToString:@"integer"] ) 
//		//{
//		//	NSString* property = [_properties objectForKey:_activePropertyKey];
//		//			[_properties setObject: [NSNumber numberWithInt:[property intValue]]
//		//							forKey: _activePropertyKey];
//		
//		//[_properties setValue:[NSNumber numberWithInt:42]   forKey: _activePropertyKey];
//		
//		//}
//		//else if( [_activePropertyType isEqualToString:@"datetime"] ) 
//		//		{
//		//			NSString* property = [_properties objectForKey:_activePropertyKey];
//		//			
//		//			NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//		//			[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
//		//			[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
//		//			
//		//			NSDate* date = [dateFormatter dateFromString:property];
//		//			TT_RELEASE_SAFELY(dateFormatter);
//		//			
//		//			[_properties setObject:date forKey:_activePropertyKey];
//		//		}
//	}
//	
//	[self setActivePropertyKey:nil];
//}

//=====================================================================================================

-(void)dealloc
{	
	TT_RELEASE_SAFELY(_properties);
	TT_RELEASE_SAFELY(_activePropertyKey);
	
	[super dealloc];
}

//=====================================================================================================


@end
