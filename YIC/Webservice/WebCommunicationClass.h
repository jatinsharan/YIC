
#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"

#import "ALServiceInvoker.h"
//#import "NSString+URLEncoding.h"

@class UserInfo;
@class AppDelegate;

@interface WebCommunicationClass : NSObject <ALServiceInvokerDelegate> {

	AppDelegate *AnAppDelegatObj;
		id aCaller;
	
}
@property(nonatomic,strong)NSString *MethoodName;
;
@property(nonatomic,retain)	id aCaller;
@property(nonatomic,assign)	BOOL isCancelAllRequest;

-(void)GetRegestater:(NSString*)name  mobile:(NSString*)mobile email:(NSString*)email city:(NSString*)city localAddress:(NSString*)localAddress collegeName:(NSString*)collegeName course:(NSString*)course semester:(NSString*)semester;

-(void)GetCity:(NSString *)cityId;

-(void)getUserNotices:(NSString *)userId;

+ (NSString *)urlEncodeValue:(NSString *)str;
+ (NSString *)urlDecodeValue:(NSString *)str;
-(void)ASICallSyncToServerWithUrl:(NSString *)urlString FunctionName:(NSString*)FunctionName;
-(void) dataDownloadFail:(ASIHTTPRequest*)aReq;
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq;
//-(NSDictionary * )getUTCFormateDate:(NSString *)aDate:(NSString *)aTimeStr;
@end




@protocol WebCommunicationClassDelegate

-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj;
-(void) dataDownloadFail:(ASIHTTPRequest*)aReq  withMethood:(NSString *)MethoodName;



@end
