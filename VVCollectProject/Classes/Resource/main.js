require('UIButton,UIColor');
defineClass('ViewController', {
            
            viewDidLoad: function() {
            self.super().viewDidLoad();
            self.initUI();
            },
            
            initUI: function() {
            var btn = UIButton.buttonWithType(1);
            btn.setBounds({x:0, y:0, width:200, height:50});
            btn.setCenter(self.view().center());
            btn.setTitle_forState("点击TestButton", 0);
            
            btn.setTitleColor_forState(UIColor.whiteColor(), 0);
            btn.setBackgroundColor(UIColor.colorWithRed_green_blue_alpha(100 / 255.0, 180 / 255.0, 220 / 255.0, 1.0));
            btn.layer().setCornerRadius(10.0);
            btn.layer().setMasksToBounds(1);
            
            btn.addTarget_action_forControlEvents(self, 'testAction:' , 1 <<  6);
            self.view().addSubview(btn);
            },
            
            testAction:function(obc) {
            var alertView = require('UIAlertView').alloc().init();
            alertView.setTitle('TestTitle');
            alertView.setMessage('TestTitle内容');
            alertView.addButtonWithTitle('1111');
            alertView.addButtonWithTitle('222');
            alertView.show();
            }
            
            });
