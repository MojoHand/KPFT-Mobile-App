//
//  ScheduleDataSource.h
//  KPFT_App
//
//  Created by Nathan King of Mojo Hand Development
//
//	Thanks to Mark at reventkn.com

@interface ScheduleDataSource : TTListDataSource<TTURLRequestDelegate> 
{
	@private
		BOOL _loading;
		BOOL _loaded;
}


@end