//
//  ScheduleViewController.h
//

#import <UIKit/UIKit.h>


@interface ScheduleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 
{
@private
	//UIBarButtonItem *refreshButton;
	UITableView *tableView;
	//NSMutableArray *scheduleList;
	NSArray *scheduleList;
	
	NSDictionary *scheduleDictionary;
	//NSMutableDictionary *loadedFeeds;
	//NSMutableDictionary *readStatus;
	//BOOL needsRefresh;
	//int waitingFeeds;
	//int totalFeeds;
}

@property (nonatomic,retain) NSArray *scheduleList;
@end
