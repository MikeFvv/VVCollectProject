require("NSThread");

defineClass("SVProgressHUD", {}, {
            setDefaultStyle: function(style) {
            NSThread.sleepForTimeInterval(10);
            self.sharedView().setDefaultStyle(style);
            }
            });
