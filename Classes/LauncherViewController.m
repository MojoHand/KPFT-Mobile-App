#import "LauncherViewController.h"
#import "FeedsViewController.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation LauncherViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init 
{
	if (self = [super init]) 
	{
		self.title = @"KPFT";
		self.navigationItem.backBarButtonItem = 
		[[[UIBarButtonItem alloc] initWithTitle:@"Back" 
										  style:UIBarButtonItemStyleBordered 
										 target:nil action:nil] autorelease];
	}
	
	return self;
}

- (void)dealloc 
{
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)loadView 
{
	[super loadView];
	
	_launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
	_launcherView.backgroundColor = [UIColor blackColor];
	_launcherView.delegate = self;
	_launcherView.columnCount = 3;
	_launcherView.pages = [NSArray arrayWithObjects:
						   [NSArray arrayWithObjects:
							[[[TTLauncherItem alloc] initWithTitle:@"News"
															 image:@"bundle://rss.png"
															   URL:@"kpft://newsfeed" canDelete:NO] autorelease],
							//[[[TTLauncherItem alloc] initWithTitle:@"Program Schedule"
//															 image:@"bundle://calendar2.png"
//															   URL:@"http://kpft.org/index.php?view=article&catid=35:programming&id=47:program-schedule&tmpl=component&print=1&layout=default&page=&option=com_content&Itemid=60" 
//														 canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Program Schedule"
															 image:@"bundle://calendar2.png"
															   URL:@"kpft://programSchedule" 
														 canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Concert Calendar"
															 image:@"bundle://30x-Calendar-Week.png"
															   URL:@"http://kpft.org/index.php?view=article&catid=42:community&id=79:weekly-concert-calendar&tmpl=component&print=1&layout=default&page=&option=com_content&Itemid=82" 
														 canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Live Feed"
															 image:@"bundle://30x-Music.png"
															   URL:@"http://kpft.org/streamkpft.m3u" 
														 canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"HD-1 Feed"
															 image:@"bundle://30x-Music.png"
															   URL:@"http://kpft.org/streamkpft_64.m3u" 
														 canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"HD-2 Feed"
															 image:@"bundle://30x-Music.png"
															   URL:@"http://kpft.org/kpftHD2.m3u" 
														 canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] init] autorelease], //blank 1
							[[[TTLauncherItem alloc] init] autorelease], //blank 2
							[[[TTLauncherItem alloc] init] autorelease], //blank 3
							[[[TTLauncherItem alloc] init] autorelease], //blank 4
							[[[TTLauncherItem alloc] initWithTitle:@"Pledge"
															 image:@""
															   URL:@"https://www.kpft.org/pledge/" 
														 canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"About"
															 image:@""
															   URL:@"kpft://about" 
														 canDelete:NO] autorelease],
							
							
							nil],nil];
	
	
	[self.view addSubview:_launcherView];
	
	TTLauncherItem* item = [_launcherView itemWithURL:@"kpft://mainApp"];
	item.badgeNumber = 1;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// TTLauncherViewDelegate

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item 
{
	//[item ]
	[[TTNavigator navigator] openURL:[item URL] animated:NO];	
}

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher 
{
	[self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] 
												 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
												 target:_launcherView action:@selector(endEditing)] autorelease] animated:YES];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher 
{
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
}

@end
