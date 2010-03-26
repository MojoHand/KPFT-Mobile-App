//
//  FeedsDetailViewController.m
//

#import "FeedsDetailViewController.h"
//#import "SimpleWebViewController.h"
//#import "SettingsSupport.h"
#import <QuartzCore/QuartzCore.h>


@implementation FeedsDetailViewController

@synthesize detailDictionary;
@synthesize categories;

- (id)initWithDictionary:(NSDictionary *)dict 
{
	self = [super init];
	
	if (self) 
	{
		self.title = @"Details";
		self.detailDictionary = dict;
		self.categories = [[dict valueForKey:@"category"] componentsSeparatedByString:@", "];
		
		[[self navigationItem] setLeftBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backButton:)] autorelease]];
		//self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
		//										  initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered
		//										  target:self action:@selector(dismiss)] autorelease];
		
		categoryPosition = 0;
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
	frame.size.height = contentView.bounds.size.height - 92;

	
	//UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 16)];
//	
//	[dateLabel setFont:[UIFont boldSystemFontOfSize:14]];
//	[dateLabel setTextColor:[UIColor whiteColor]];
//	//[dateLabel setText:[NSString stringWithFormat:@"   %@   ", [detailDictionary valueForKey:@"pubDate"]]];
//	//[dateLabel setText:""];
//	[dateLabel setBackgroundColor:[UIColor blackColor]];
//	[dateLabel setTextAlignment:UITextAlignmentCenter];
//	[self.view addSubview:dateLabel];
//	[dateLabel release];
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 24)];
	CGSize fitSize = CGSizeMake(320, 400);
	CGRect titleRect = titleLabel.frame;
	
	fitSize = [[detailDictionary valueForKey:@"title"] sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:fitSize lineBreakMode:UILineBreakModeWordWrap];
	titleRect.size.height = fitSize.height;
	
	[titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
	[titleLabel setTextColor:[UIColor whiteColor]];
	[titleLabel setText:[detailDictionary valueForKey:@"title"]];
	[titleLabel setNumberOfLines:5];
	[titleLabel setTextAlignment:UITextAlignmentCenter];
	[titleLabel setFrame:titleRect];
	[titleLabel setBackgroundColor:[UIColor darkGrayColor]];
	[self.view addSubview:titleLabel];
	[titleLabel release];
	
	// This was added so we can show the categories that is assigned to a feed.  It cycles through each category one-by-one,
	// but only if more than one was parsed out.
	//categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, fitSize.height + 16, 320, 16)];
//	
//	[categoryLabel setFont:[UIFont boldSystemFontOfSize:14]];
//	[categoryLabel setTextColor:[UIColor whiteColor]];
//	[categoryLabel setBackgroundColor:[UIColor blackColor]];
//	[categoryLabel setTextAlignment:UITextAlignmentCenter];
//	[categoryLabel setText:[self.categories objectAtIndex:categoryPosition]];
//	[self.view addSubview:categoryLabel];
	
	UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(4, titleLabel.frame.size.height + 3, 312, 480 - (titleLabel.frame.size.height))];
	
	[webView setBackgroundColor:[UIColor lightGrayColor]];
	[webView loadHTMLString:[NSString stringWithFormat:@"<body bgcolor=\"#aaaaaa\"><font face=\"Helvetica\">%@</font></body>",
							 [detailDictionary valueForKey:@"description"]]
					baseURL:[NSURL URLWithString:@"file:///"]];
	[self.view addSubview:webView];
	
	//UIButton *viewRssButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//	
//	[viewRssButton setTitle:@"Read More" forState:UIControlStateNormal];
//	[viewRssButton setFont:[UIFont boldSystemFontOfSize:14]];
//	//viewRssButton.font = [UIFont boldSystemFontOfSize:14];
//	[viewRssButton setFrame:CGRectMake(4, frame.size.height - 54, 312, 46)];
//	[self.view addSubview:viewRssButton];
//	[viewRssButton addTarget:self action:@selector(viewRssButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//	
	// Start the timer here only if the category count is greater than one.  This means we had more than one category parsed
	// from the categories found in the RSS feed.
	if ([self.categories count] > 1) 
	{
		categoryLabelTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(showCategories) userInfo:nil repeats:YES];
	}
}

- (void)backButton:(id)sender 
{
	[[self navigationController] popViewControllerAnimated:YES];
}

// Rotates through each category, with a Fade transition.
- (void)showCategories {
	categoryPosition++;
	
	if (categoryPosition >= [self.categories count]) 
	{
		categoryPosition = 0;
	}
	
	[CATransaction begin];
	CATransition *animation = [CATransition animation];
	animation.type = kCATransitionFade;
	animation.duration = 0.50;
	[categoryLabel setText:[self.categories objectAtIndex:categoryPosition]];
	[[categoryLabel layer] addAnimation:animation forKey:@"labelFade"];
	[CATransaction commit];
}

- (void)viewRssButtonTapped:(id)sender 
{
	//SimpleWebViewController *swvController = [[SimpleWebViewController alloc] initWithUrl:[self.detailDictionary valueForKey:@"link"]];
	
	//[self.navigationController pushViewController:swvController animated:YES];
	//[swvController release];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}
	
- (void)dealloc {
    [super dealloc];
	
	[categoryLabel release];
	categoryLabel = nil;
	
	[categoryLabelTimer invalidate];
	[categoryLabelTimer release];
	categoryLabelTimer = nil;
}


@end
