//
//  ScheduleDetailViewController.h
//

#import <UIKit/UIKit.h>


@interface ScheduleDetailViewController : UIViewController 
{
@private
	NSDictionary *detailDictionary;
	NSArray *categories;
	UILabel *categoryLabel;
	NSTimer *categoryLabelTimer;
	int categoryPosition;
}

@property (nonatomic, retain) NSDictionary *detailDictionary;
@property (nonatomic, retain) NSArray *categories;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
