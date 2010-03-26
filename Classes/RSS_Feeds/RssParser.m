//
//  RssParser.m
//  RSS
//
//  Copyright 2008 WillowTree Consulting Group, Inc. All rights reserved.
//

#import "RssParser.h"


@implementation RssParser

- (id) init:(NSInteger)identifier {
	self = [super init];
	
	if (self) {
		callId = identifier;
		root = [[NSMutableDictionary alloc] init];
		items = [[NSMutableArray alloc] init];
		success = NO;
		loading = NO;
		parsed = NO;
		currentElement = nil;
	}
	
	return self;
}

- (void)parse:(NSString *)url withDelegate:(id)sender onComplete:(SEL)callback {
	parentDelegate = sender;
	onCompleteCallback = callback;
	requestUrl = [url retain];
	loading = YES;
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	
	[request setURL:[[NSURL alloc] initWithString:requestUrl]];
	[request setHTTPMethod:@"GET"];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	[request release];
	
	webData = [[NSMutableData data] retain];
}

- (BOOL)isSuccessful {
	return success;
}

- (BOOL)isLoading {
	return loading;
}

- (BOOL)isParsed {
	return parsed;
}

- (NSInteger)getId {
	return callId;
}

- (NSArray *)getItems {
	return items;
}

- (NSDictionary *)getRoot {
	return root;
}

// HTTP Request Handling functionality
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	success = NO;
	loading = NO;
	
	if ([parentDelegate respondsToSelector:onCompleteCallback]) {
		[parentDelegate performSelector:onCompleteCallback withObject:self];
	}
}

- (void)connection:(NSURLConnection *)connection didReceivedAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	success = NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
		
		NSLog(@"RssParser: Response is an NSHTTPURLResponse: Response=%d", [httpResponse statusCode]);
		
		// Does not handle authentication quite yet.
		if ([httpResponse statusCode] >= 400 && [httpResponse statusCode] <= 599) {
			success = NO;
		} else if ([httpResponse statusCode] >= 100 && [httpResponse statusCode] <= 299) {
			success = YES;
		} else {
			NSLog(@"RssParser: Status code is unknown.");
		}
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *dataString = [[[NSString alloc] initWithData:webData encoding:NSASCIIStringEncoding] autorelease];
	
	if ([dataString length] > 0) {
		[self parseResponse];
	}
	
	loading = NO;
}

- (void)parseResponse {
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:webData];
	
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	
	[parser parse];
}

// XML Parser functionality

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSLog(@"RestResponse: Parsing error occurred.");
	parsed = NO;
	loading = NO;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	NSString *element = [elementName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	currentElement = element;
	
	if ([[currentElement lowercaseString] isEqual:@"item"]) {
		inItem = YES;
		itemsDictionary = [[NSMutableDictionary alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
	NSString *element = [elementName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if ([[element lowercaseString] isEqual:@"item"]) {
		inItem = NO;
		[items addObject:itemsDictionary];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	NSString *stringValue = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *element = [currentElement stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	// Skip over blank elements.
	if (stringValue == nil || [stringValue isEqual:@""]) {
		return;
	}
	
	if (element != nil && [element length] > 0) {
		if (inItem) {
			if ([itemsDictionary objectForKey:element] != nil) {
				// If we're adding categories, we can safely add a comma.  Otherwise, we don't, and append the string data.
				if ([element isEqual:@"category"]) {
					[itemsDictionary setObject:[NSString stringWithFormat:@"%@, %@", [itemsDictionary objectForKey:element], stringValue]
								forKey:element];
				} else {
					[itemsDictionary setObject:[NSString stringWithFormat:@"%@%@", [itemsDictionary objectForKey:element], stringValue]
										forKey:element];
				}
			} else {
				[itemsDictionary setObject:stringValue forKey:element];
			}
		} else {
			if ([root objectForKey:element] != nil) {
				if ([element isEqual:@"category"]) {
					[root setObject:[NSString stringWithFormat:@"%@, %@", [root objectForKey:element], stringValue] forKey:element];
				} else {
					[root setObject:[NSString stringWithFormat:@"%@%@", [root objectForKey:element], stringValue] forKey:element];
				}
			} else {
				[root setObject:stringValue forKey:element];
			}
		}
	}
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	NSLog(@"RssParser: Started document.");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	parsed = YES;
	loading = NO;

	if ([parentDelegate respondsToSelector:onCompleteCallback]) {
		[parentDelegate performSelector:onCompleteCallback withObject:self];
	}
}


- (void)dealloc {
	[super dealloc];
	
	[requestUrl release];
	requestUrl = nil;
	
	[webData release];
	webData = nil;
}

@end
