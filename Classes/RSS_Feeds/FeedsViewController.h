//
//  FeedsViewController.h
//

#import <UIKit/UIKit.h>


@interface FeedsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 
{
@private
	UIBarButtonItem *refreshButton;
	UITableView *tableView;
	NSMutableArray *feeds;
	NSDictionary *feedsDictionary;
	NSMutableDictionary *loadedFeeds;
	NSMutableDictionary *readStatus;
	BOOL needsRefresh;
	int waitingFeeds;
	int totalFeeds;
}

- (id)initWithTitle:(NSString *)title withNavigationTitle:(NSString *)navTitle withPropertyFile:(NSString *)propFile;

- (void)refresh;

@end
