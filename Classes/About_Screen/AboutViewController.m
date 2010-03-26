//
//  AboutViewController.m
//  Simple RSS
//
//  Copyright 2008 WillowTree Consulting Group, Inc. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
	{
        self.title = @"About";
		[[self tabBarItem] setImage:[UIImage imageNamed:@"about.png"]];
    }
    return self;
}

- (void)loadView 
{
	UIView *contentView = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
	
	contentView.autoresizesSubviews = YES;
	self.view = contentView;
	[self.view setBackgroundColor:[UIColor lightGrayColor]];
	
	CGRect frame = contentView.frame;
	frame.origin.x = 0;
	frame.origin.y = contentView.bounds.size.height - frame.size.height;
	frame.size.width = contentView.bounds.size.width;
	frame.size.height = contentView.bounds.size.height - 20;
	
	UIWebView *webView = [[[UIWebView alloc] initWithFrame:frame] retain];
	webView.delegate = self;
	webView.scalesPageToFit = NO;
	webView.userInteractionEnabled = YES;
	webView.backgroundColor = [UIColor colorWithRed:0.14 green:0.18 blue:0.25 alpha:1.00];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"About_Screen" ofType:@"html"]]]];
	
	[self.view addSubview:webView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if ([[request URL] isFileURL]) {
		return YES;
	}
	
	[[UIApplication sharedApplication] openURL:[request URL]];
	
	return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
