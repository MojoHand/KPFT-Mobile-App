//
//  FeedsViewController.m
//

#import "FeedsViewController.h"
#import "SimpleWebViewController.h"
#import "FeedsDetailViewController.h"
#import "RssParser.h"
#import "FastFeedCell.h"

#define	DEFAULT_FONT_SIZE	18


@implementation FeedsViewController

- (id)initWithTitle:(NSString *)title withNavigationTitle:(NSString *)navTitle withPropertyFile:(NSString *)propFile 
{
	self = [super init];
	
	if (self) 
	{
		// Custom initialization
		[[self tabBarItem] setImage:[UIImage imageNamed:@"calendar.png"]];
		
		self.title = title;
		self.navigationItem.title = navTitle;
			
		needsRefresh = YES;
	
		NSString *localeDatabase = [[[NSBundle mainBundle] resourcePath]
								stringByAppendingPathComponent:propFile];
	
		feedsDictionary = [[NSDictionary dictionaryWithContentsOfFile:localeDatabase] retain];
		readStatus = [[NSMutableDictionary alloc] init];
		feeds = [[NSMutableArray alloc] init];
		totalFeeds = 0;
		
		// Counter indicating the number of items awaiting feed updates.
		waitingFeeds = [feedsDictionary count];
	}
	
	return self;
}


- (void)loadView 
{
	refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshFeeds:)];
	
	[[self navigationItem] setRightBarButtonItem:refreshButton];
	[refreshButton setEnabled:NO];
	
	UIView *contentView = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
	
	contentView.autoresizesSubviews = YES;
	self.view = contentView;
	[self.view setBackgroundColor:[UIColor colorWithRed:0.14 green:0.18 blue:0.25 alpha:1.00]];

	CGRect frame = contentView.frame;
	frame.origin.x = 0;
	frame.origin.y = contentView.bounds.size.height - frame.size.height;
	frame.size.width = contentView.bounds.size.width;
	frame.size.height = contentView.bounds.size.height - 92;
	
	tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
	tableView.delegate = self;
	tableView.dataSource = self;
	tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	tableView.scrollEnabled = YES;
	[tableView setBackgroundColor:[UIColor colorWithRed:0.14 green:0.18 blue:0.25 alpha:1.00]];

	[tableView reloadData];
	[self.view addSubview:tableView];
	
	[self refresh];
}

- (void)viewDidAppear:(BOOL)animated 
{
	if (needsRefresh) 
	{
		needsRefresh = NO;
		[self refresh];
	}
}

- (void)refresh 
{
	totalFeeds = 0;
	
	for(NSInteger i = 0; i < [feedsDictionary count]; i++) 
	{
		RssParser *parser = [[RssParser alloc] init:i];
		
		[parser parse:[feedsDictionary valueForKey:[[feedsDictionary allKeys] objectAtIndex:i]]
		 withDelegate:self
		   onComplete:@selector(refreshTable:)];
		[feeds addObject:[parser retain]];
	}
}

// This refreshes the feeds when the refresh button is tapped.
- (void)refreshFeeds:(id)sender 
{
	[refreshButton setEnabled:NO];
	
	[feeds removeAllObjects];
	[readStatus removeAllObjects];
	
	waitingFeeds = [feedsDictionary count];
	
	[tableView reloadData];
	[self refresh];
}

- (void)refreshTable:(RssParser *)objectParser
{
	[readStatus setObject:[[NSMutableDictionary alloc] init] forKey:[NSString stringWithFormat:@"%d", [objectParser getId]]];
	[tableView reloadData];
	
	waitingFeeds--;
	
	if (waitingFeeds <= 0)
	{
		[refreshButton setEnabled:YES];
	}
	
	NSLog(@"Load: %d, Success: %d, Count: %d", [objectParser isLoading], [objectParser isSuccessful], [[objectParser getItems] count]);
	
	if ([objectParser isSuccessful]) 
	{
		totalFeeds += [[objectParser getItems] count];
//		[[self tabBarItem] setBadgeValue:[NSString stringWithFormat:@"%d", totalFeeds]];
	}
}

// Table View Delegates
- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	FastFeedCell *tvCell = (FastFeedCell *) [tView dequeueReusableCellWithIdentifier:@"feedsListViewCell"];
	
	if (tvCell == nil) 
	{
		tvCell = [[[FastFeedCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"feedsListViewCell"] autorelease];
	}
	
	// Since this is the only time the object could ever get updated, we update the logic so that we display the cells
	// here.  Otherwise, if no feeds are present, we skip this.
	
	if ([feeds count] > 0) 
	{
		RssParser *parser = nil;
		
		if ([feeds count] >= [indexPath section]) 
		{
			parser = [feeds objectAtIndex:[indexPath section]];
			
			if ([[parser getItems] count] > 0) 
			{
				NSDictionary *tableDict = [[parser getItems] objectAtIndex:[indexPath row]];

				[tvCell setMainLabel:[tableDict objectForKey:@"title"]];
				//[tvCell setSubLabel:[tableDict objectForKey:@"pubDate"]];
				
				if ([[readStatus objectForKey:[NSString stringWithFormat:@"%d", [indexPath section]]] objectForKey:[NSString stringWithFormat:@"%d", [indexPath row]]] != nil) 
				{
					[tvCell setMarkedRead:YES];
				} 
				else 
				{
					[tvCell setMarkedRead:NO];
				}

				[tvCell setSelectionStyle:UITableViewCellSelectionStyleGray];
				[tvCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
				
				return tvCell;
			} 
			else 
			{
				if (![parser isSuccessful] && ![parser isLoading]) 
				{
					[tvCell setMainLabel:@"Feed Not Available."];
					[tvCell setSelectionStyle:UITableViewCellSelectionStyleNone];
					[tvCell setAccessoryType:UITableViewCellAccessoryNone];
					
					return tvCell;
				}
			}
		}
	}

	[tvCell setMainLabel:@"Updating Feed ..."];
	
	
	return tvCell;
}

//****************************************************************************************

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if ([feeds count] > 0) 
	{
		RssParser *parser = nil;
		
		if ([feeds count] >= [indexPath section]) 
		{
			parser = [feeds objectAtIndex:[indexPath section]];
			
			if ([[parser getItems] count] > 0) 
			{
				CGSize displaySize = CGSizeMake(288, 200);
				CGSize fitSize;
				NSDictionary *tableDict = [[parser getItems] objectAtIndex:[indexPath row]];
				
				fitSize = [[tableDict objectForKey:@"title"] sizeWithFont:[UIFont boldSystemFontOfSize:DEFAULT_FONT_SIZE]
														constrainedToSize:displaySize
															lineBreakMode:UILineBreakModeWordWrap];
				
				return fitSize.height + 24.0;
			}
		}
	}
	
	return 48.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tView 
{
	return [feedsDictionary count];
}

- (NSInteger)tableView:(UITableView *)tView numberOfRowsInSection:(NSInteger)section 
{
	RssParser *parser = nil;
	
	if ([feeds count] == 0)
	{
		return 1;
	}

	if ([feeds count] >= section) 
	{
		parser = [feeds objectAtIndex:section];
		
		
		if ([[parser getItems] count] > 0) 
		{
			return [[parser getItems] count];
		}
	}
	
	return 1;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if ([feeds count] > 0) 
	{
		RssParser *parser = nil;
		
		if ([feeds count] >= [indexPath section]) 
		{
			parser = [feeds objectAtIndex:[indexPath section]];
			
			if ([[parser getItems] count] > 0) 
			{
				NSDictionary *itemDictionary = [[[feeds objectAtIndex:[indexPath section]] getItems] objectAtIndex:[indexPath row]];
	
				FeedsDetailViewController *fdvController = [[FeedsDetailViewController alloc] initWithDictionary:itemDictionary];
	
				[self.navigationController pushViewController:fdvController animated:YES];
				[fdvController release];

				if ([[readStatus objectForKey:[NSString stringWithFormat:@"%d", [indexPath section]]] objectForKey:[NSString stringWithFormat:@"%d", [indexPath row]]] == nil) 
				{
					totalFeeds--;
					
//					if (totalFeeds <= 0) {
//						[[self tabBarItem] setBadgeValue:@""];
//					} else {
//						[[self tabBarItem] setBadgeValue:[NSString stringWithFormat:@"%d", totalFeeds]];
//					}
				}

				[[readStatus objectForKey:[NSString stringWithFormat:@"%d", [indexPath section]]] setObject:[NSObject class] forKey:[NSString stringWithFormat:@"%d", [indexPath row]]];
				[tableView reloadData];
			}
		}
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
	return [[feedsDictionary allKeys] objectAtIndex:section];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
