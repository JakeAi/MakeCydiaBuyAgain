
%hook CydiaWebViewController
+ (NSURLRequest *) requestWithHeaders:(NSURLRequest *)request {
	
	id copy = %orig(request);
    NSURL *url([copy URL]);
	NSString *href([url absoluteString]);
    NSString *host([url host]);

	if ([href hasPrefix:@"https://cydia.saurik.com"]){
		
		[copy setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 10_1 like Mac OS X) AppleWebKit/604.3.5 (KHTML, like Gecko) Mobile/15B202 Safari/604.1 Cydia/1.1.30 CyF/1445.32" forHTTPHeaderField:@"User-Agent"];
	
		[copy setValue:[NSString stringWithUTF8String:"iPhone9,1"] forHTTPHeaderField:@"X-Machine"];
		
	}
	
	return copy;
}
%end