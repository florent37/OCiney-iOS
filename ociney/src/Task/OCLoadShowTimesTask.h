#import <Foundation/Foundation.h>
#import "AsyncTask.h"
#import "Theater.h"
#import "AllocineResponse.h"

@class OCLoadShowTimesTask;

@protocol OCLoadShowTimesDelegate <AsyncTaskDelegate>

-(void)onLoadShowTimesTaskCallBack:(NSArray*)result;

@end

@interface OCLoadShowTimesTask : AsyncTask

@property (assign,nonatomic) BOOL cinemaList;
@property (strong,nonatomic) id<OCLoadShowTimesDelegate> delegate;

-(id)initWithDelegate:(id)delegate andCinemaList:(BOOL)cinemaList;

@end

