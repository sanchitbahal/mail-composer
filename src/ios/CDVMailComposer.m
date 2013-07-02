#import "CDVMailComposer.h"

@interface CDVMailComposer ()

- (void)launchMailClient:(CDVInvokedUrlCommand *)command;

- (void)alertUserToConfigureMail;

@end

@implementation CDVMailComposer

- (void)composeMail:(CDVInvokedUrlCommand *)command {
    if ([MFMailComposeViewController canSendMail])
        [self launchMailClient:command];
    else
        [self alertUserToConfigureMail];
}

- (void)launchMailClient:(CDVInvokedUrlCommand *)command {
    NSString *url = [command argumentAtIndex:0];
    NSString *fileName = [command argumentAtIndex:1];

    NSURL *baseUrl = [self.webView.request URL];
    NSURL *filePath = [[NSURL URLWithString:url relativeToURL:baseUrl] absoluteURL];
    NSString *fileNameWithExtension = [[[filePath path] lastPathComponent] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *fileExtension = [fileNameWithExtension pathExtension];
    NSString *attachmentName = [fileName stringByAppendingPathExtension:fileExtension];
    NSArray *recipients = [NSArray arrayWithObject:@""];

    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:fileName];
    [mc setMessageBody:@"" isHTML:NO];
    [mc setToRecipients:recipients];
    [mc addAttachmentData:[NSData dataWithContentsOfURL:filePath] mimeType:@"zip" fileName:attachmentName];

    [self.viewController presentViewController:mc animated:YES completion:nil];
}

- (void)alertUserToConfigureMail {
    NSString *alertMessage = [NSString stringWithFormat:@"Please configure your email"];
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:@"No Account Configured"
                  message:alertMessage
                 delegate:self cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
    [alert show];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    switch (result) {
        {
            case MFMailComposeResultCancelled:
                NSLog(@"Mail cancelled");
            break;
            case MFMailComposeResultSaved:
                NSLog(@"Mail saved");
            break;
            case MFMailComposeResultSent:
                NSLog(@"Mail sent");
            break;
            case MFMailComposeResultFailed:
                NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
            default:
                break;
        }
    }

    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end