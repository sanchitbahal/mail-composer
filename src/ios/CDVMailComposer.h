#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <Cordova/CDVPlugin.h>


@interface CDVMailComposer : CDVPlugin <MFMailComposeViewControllerDelegate> {
}

- (void)sendMail:(CDVInvokedUrlCommand *)command;

@end