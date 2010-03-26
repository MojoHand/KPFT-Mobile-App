//
//  ScheduleViewController.m
//

#import "ScheduleViewController.h"
//#import "SimpleWebViewController.h"
#import "FeedsDetailViewController.h"
#import "RssParser.h"
#import "FastFeedCell.h"

#define	DEFAULT_FONT_SIZE	18


@implementation ScheduleViewController

@synthesize	scheduleList;


-(void)viewDidLoad
{
	// read plist from application bundle
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *finalPath = [path stringByAppendingPathComponent:@"schedule.plist"];
	scheduleDictionary = [NSDictionary dictionaryWithContentsOfFile:finalPath];
	
	NSArray *shows = [NSArray arrayWithArray:[scheduleDictionary objectForKey:@"Monday"]];	
	
	//scheduleList = [NSArray arrayWithArray:[scheduleDictionary objectForKey:@"Monday"]];
	scheduleList = shows;
	
	[super viewDidLoad];	
}

- (id)initWithTitle:(NSString *)title withNavigationTitle:(NSString *)navTitle withPropertyFile:(NSString *)propFile 
{
	self = [super init];
	
	if (self) 
	{
		// Custom initialization
		[[self tabBarItem] setImage:[UIImage imageNamed:@"calendar.png"]];
		
		self.title = title;
		self.navigationItem.title = navTitle;
	}
	
	return self;
}

- (void)loadView 
{
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
}

-(void)viewDidUnload
{
	self.scheduleList = nil;
	[super viewDidLoad];
}

-(void)dealloc
{
	[scheduleDictionary release];
	[super dealloc];
}



- (NSInteger)tableView:(UITableView *)tView numberOfRowsInSection:(NSInteger)section 
{
	return [[self scheduleList] count];
}

-(UITableViewCell *)tableView:(UITableView *)tView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *ScheduleTableIdentifier = @"Schedule";
	
	UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:ScheduleTableIdentifier];
	
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:ScheduleTableIdentifier] autorelease];
	}
	
	NSUInteger row = [indexPath row];
	cell.textLabel.text = [scheduleList objectAtIndex:row];
	return cell;
}




@end
