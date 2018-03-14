%hook CydiaWebViewController
- (id)requestWithHeaders:(id) request {	

	NSMutableURLRequest *copy([[request mutableCopy] autorelease]);

    NSURL *url([copy URL]);
    NSString *href([url absoluteString]);
    NSString *host([url host]);

    if ([href hasPrefix:@"https://cydia.saurik.com/TSS/"]) {
        if (NSString *agent = [copy valueForHTTPHeaderField:@"X-User-Agent"]) {
            [copy setValue:agent forHTTPHeaderField:@"Mozilla/5.0 (iPhone; CPU iPhone OS 10_1 like Mac OS X) AppleWebKit/604.3.5 (KHTML, like Gecko) Mobile/15B202 Safari/604.1 Cydia/1.1.30 CyF/1445.32"];
            [copy setValue:nil forHTTPHeaderField:@"X-User-Agent"];
        }

        [copy setValue:nil forHTTPHeaderField:@"Referer"];
        [copy setValue:nil forHTTPHeaderField:@"Origin"];

        [copy setURL:[NSURL URLWithString:[@"http://gs.apple.com/TSS/" stringByAppendingString:[href substringFromIndex:29]]]];
        return copy;
    }

    if ([copy valueForHTTPHeaderField:@"X-Cydia-Cf"] == nil)
        [copy setValue:[NSString stringWithFormat:@"%.2f", kCFCoreFoundationVersionNumber] forHTTPHeaderField:@"X-Cydia-Cf"];
    if (Machine_ != NULL && [copy valueForHTTPHeaderField:@"X-Machine"] == nil)
        [copy setValue:[NSString stringWithUTF8String:"iPhone9,1"] forHTTPHeaderField:@"X-Machine"];

    bool bridged; @synchronized (HostConfig_) {
        bridged = [BridgedHosts_ containsObject:host];
    }

    if ([url isCydiaSecure] && bridged && UniqueID_ != nil && [copy valueForHTTPHeaderField:@"X-Cydia-Id"] == nil)
        [copy setValue:UniqueID_ forHTTPHeaderField:@"X-Cydia-Id"];

    return copy;
	
}
%end



%hook CydiaWebViewController
+ (NSURLRequest *) requestWithHeaders:(NSURLRequest *)request {
	
	id copy = %orig(request);
    NSURL *url([copy URL]);
	NSString *href([url absoluteString]);
    NSString *host([url host]);

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello World!"
	message:@ href
		delegate:nil
	cancelButtonTitle:@"Youhou!"
	otherButtonTitles:nil];
	[alert show];
	[alert release];
	
	[copy setValue:"Mozilla/5.0 (iPhone; CPU iPhone OS 10_1 like Mac OS X) AppleWebKit/604.3.5 (KHTML, like Gecko) Mobile/15B202 Safari/604.1 Cydia/1.1.30 CyF/1445.32" forHTTPHeaderField:@"User-Agent"];
	
	[copy setValue:[NSString stringWithUTF8String:"iPhone9,1"] forHTTPHeaderField:@"X-Machine"];

	return copy;
}
%end