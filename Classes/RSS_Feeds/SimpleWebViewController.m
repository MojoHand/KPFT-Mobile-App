//
//  SimpleWebViewController.m
//  Simple RSS
//
//  Copyright 2008 WillowTree Consulting Group, Inc. All rights reserved.
//

#import "SimpleWebViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation SimpleWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"Web View";
		backTapped = NO;
    }
    return self;
}

- (id) initWithUrl:(NSString *)url {
	self = [super init];
	
	if (self) {
		self.title = @"More Info";
		backTapped = NO;
	}
	
	requestUrl = [url retain];
	
	return self;
}

- (void)loadView {
	refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshWeb:)];
	backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backButton:)];
	
	[[self navigationItem] setRightBarButtonItem:refreshButton];
	[[self navigationItem] setLeftBarButtonItem:backButton];
	
	UIView *contentView = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
	
	contentView.autoresizesSubviews = YES;
	self.view = contentView;
	[self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
	
	CGRect frame = contentView.frame;
	frame.origin.x = 0;
	frame.origin.y = contentView.bounds.size.height - frame.size.height;
	frame.size.width = contentView.bounds.size.width;
	frame.size.height = contentView.bounds.size.height - 92;
	
	webView = [[[UIWebView alloc] initWithFrame:frame] retain];
	
	[self.view addSubview:webView];
	
	webView.scalesPageToFit = YES;
	webView.backgroundColor = [UIColor colorWithRed:0.14 green:0.18 blue:0.25 alpha:1.00];
	[webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:requestUrl]]];
	[webView setDelegate:self];
	
	loadingView = [[UIView alloc] initWithFrame:CGRectMake(80, 160, 160, 60)];
	
	[loadingView setBackgroundColor:[UIColor lightGrayColor]];
	
	UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(10, 16, 32, 32)];
	UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 18, 100, 24)];
	
	[loadingLabel setBackgroundColor:[UIColor clearColor]];
	[loadingLabel setFont:[UIFont boldSystemFontOfSize:20]];
	[loadingLabel setText:@"Loading..."];
	[loadingLabel setShadowColor:[UIColor whiteColor]];
	[loadingView addSubview:loadingLabel];
	[loadingLabel release];
	
	[activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[activityView startAnimating];
	[loadingView addSubview:activityView];
	[activityView release];
	
	[self.view addSubview:loadingView];
	
	[refreshButton setEnabled:NO];
	[backButton setEnabled:NO];
	
	// Set the user interaction to disabled for the web view while it renders.
	[webView setUserInteractionEnabled:NO];
}

- (void)backButton:(id)sender {
	[backButton setEnabled:NO];
	backTapped = YES;
	
	[webView stopLoading];
	[webView loadHTMLString:@"<body bgcolor=\"#cccccc\"></body>" baseURL:[NSURL URLWithString:@"file:///"]];
	
	[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(moveBack) userInfo:nil repeats:NO];
}

- (void)moveBack {
	[[self navigationController] popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
	[webView stopLoading];
}

- (void)setUrl:(NSString *)url {
	[webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	if (!backTapped) {
		[loadingView setHidden:NO];
		[refreshButton setEnabled:NO];
		[backButton setEnabled:NO];
	}
}

// What can I say, I just love these fade transitions!
- (void)webViewDidFinishLoad:(UIWebView *)wView {
	if (!backTapped) {
		[CATransaction begin];
		CATransition *animation = [CATransition animation];
		animation.type = kCATransitionFade;
		animation.duration = 0.50;
		[loadingView setHidden:YES];
		[[loadingView layer] addAnimation:animation forKey:@"labelFade"];
		[CATransaction commit];
	
		[webView setUserInteractionEnabled:YES];
		[refreshButton setEnabled:YES];
		[backButton setEnabled:YES];
	}
}

- (void)webView:(UIWebView *)wView didFailLoadWithError:(NSError *)error {
	if (!backTapped) {
		[self webViewDidFinishLoad:wView];

		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Load Failed"
														message:@"This web page failed to load properly."
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
	
		[alertView show];
		[alertView release];
	}
}

- (void)refreshWeb:(id)sender {
	[refreshButton setEnabled:NO];
	[backButton setEnabled:NO];
	[webView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
	
	[requestUrl release];
	requestUrl = nil;
	
	[webView stopLoading];
}


@end
