//
//  ScheduleDayDataSource.h
//  KPFT_App
//
//  Created by Nathan King of Mojo Hand Development
//

#import <Three20/Three20.h>

@class ScheduleDayModel; 

@interface ScheduleDayDataSource : TTListDataSource
{
	ScheduleDayModel* scheduleDayModel;
}

@end
