#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <Cordova/CDVPlugin.h>


@interface CDVMailComposer : CDVPlugin <MFMailComposeViewControllerDelegate> {
}

- (void)composeMail:(CDVInvokedUrlCommand *)command;

@end