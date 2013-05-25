var mailComposer = {
    composeMail: function (arguments, success, fail) {
        return cordova.exec(success, fail, "MailComposer", "sendMail", arguments);
    }
};