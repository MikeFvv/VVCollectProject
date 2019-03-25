
// 这个类可以作为参考写法

/**
 * Created by chenyun on 15/7/7.
 */
require('UIColor,UIViewController,NSNumber,UIView')

/**
 * 进行 tableveiw 数据源的替换
 */
defineClass('TestTableViewController',
            {
            tableView_cellForRowAtIndexPath: function(tableView, indexPath)
            {
            var cell = tableView.dequeueReusableCellWithIdentifier("CELL");
            if(!cell){
            cell = require('UITableViewCell').alloc().initWithStyle_reuseIdentifier(0,"CELL");
            }
            //            var num = self.dataSource().objectAtIndex(indexPath.row())
            //            cell.textLabel().setText(num + "js")
            var jsArray    = self.dataSource().toJS()
            cell.textLabel().setText(jsArray[indexPath.row()] + "JS")
            return cell;
            }
            }
            
            )

/**
 * 事件替换
 */
defineClass('TestViewController',
            {
            tableView_didSelectRowAtIndexPath: function(tableView, indexPath)
            {
            if(indexPath.section() == 1 && indexPath.row() == 0){
            var testVC = self.storyboard().instantiateViewControllerWithIdentifier("testVC");
            self.navigationController().pushViewController_animated(testVC,1)
            }
            if(indexPath.section() == 1 && indexPath.row() == 1){
            
            var tableVC = JSTableViewController.alloc().init()
            self.navigationController().pushViewController_animated(tableVC,YES);
            
            }
            }
            }
            )

/**
 * 声明一个类
 */
defineClass('JSTableViewController:UITableViewController',{
            dataSource:function()
            {
            var data = self.getProp('data')
            if(data)return data;
            var data = [];
            for(var i = 0 ; i < 12;i++)
            {
            data.push("from js " + i)
            }
            self.setProp_forKey(data,'data')
            return data;
            },
            numberOfSectionsInTableView: function(tableView) {
            return 1;
            },
            tableView_numberOfRowsInSection: function(tableView, section) {
            return self.dataSource().count();
            },
            tableView_cellForRowAtIndexPath: function(tableView, indexPath) {
            var cell = tableView.dequeueReusableCellWithIdentifier("cell")
            if (!cell) {
            cell = require('UITableViewCell').alloc().initWithStyle_reuseIdentifier(0, "cell")
            }
            cell.textLabel().setText(self.dataSource().objectAtIndex(indexPath.row()))
            return cell
            },
            tableView_heightForRowAtIndexPath: function(tableView, indexPath) {
            return 60
            },
            tableView_didSelectRowAtIndexPath: function(tableView, indexPath) {
            var alertView = require('UIAlertView').alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("Alert",self.dataSource().objectAtIndex(indexPath.row()), self, "OK", null);
            alertView.show()
            }
            })

/**
 * 重写 btn 点击事件
 */
defineClass('SomeTestViewController',
            {
            /**
             * 系统方法
             * @param animated
             */
            viewWillAppear:function(animated){
            self.super().viewWillAppear(1)
            self.setTitle("JSPatch Methods")
            
            },
            
            /**
             * 执行一段动画
             * @param sender
             */
            doAnimation:function(sender){
            
            var red = Math.floor(Math.random() * ( 255 +0.1))/255;
            var green = Math.floor(Math.random() * ( 255 +0.1))/255;
            var blue = Math.floor(Math.random() * ( 255 +0.1))/255;
            var color = UIColor.colorWithRed_green_blue_alpha(red,green,blue,1)
            
            UIView.animateWithDuration_animations_completion(1.0,block("",function(){
                                                                       self.view().setBackgroundColor(color)})
                                                             ,block("BOOL",function(finished){}));
            
            },
            
            /**
             * 背景色改变
             * @param sender
             */
            changeBackgroundColor:function(sender){
            var red = Math.floor(Math.random() * ( 255 +0.1))/255;
            var green = Math.floor(Math.random() * ( 255 +0.1))/255;
            var blue = Math.floor(Math.random() * ( 255 +0.1))/255;
            var color = UIColor.colorWithRed_green_blue_alpha(red,green,blue,1)
            self.view().setBackgroundColor(color)
            },
            
            /**
             * 增加控件
             * @param sender
             */
            addView:function(sender){
            var xx = Math.floor(Math.random() * (320 + 1))
            var yy = Math.floor(Math.random() * (640 + 1))
            
            var aView = require('UIView').alloc().initWithFrame({x:xx,y:yy,width:50,height:50})
            aView.setBackgroundColor(UIColor.redColor())
            self.view().addSubview(aView)
            },
            alert:function(sender){
            var alertView = require('UIAlertView').alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("Alert","test", self, "OK", null);
            alertView.show()
            },
            alertView_willDismissWithButtonIndex: function(alertView, idx) {
            console.log('click btn ')
            }
            })





/****************************************************************/

//修改ViewController控制器的handleBtn方法（原控制器漏此方法，会导致崩溃）。
defineClass('ViewController', {
            crashBtnClick: function(sender) {
            var tableViewCtrl = JPTableViewController.alloc().init()
            self.navigationController().pushViewController_animated(tableViewCtrl, YES)
            },
            
            })

//修改SecondViewController控制器的handleBtn3方法（原控制器漏此方法，会导致崩溃）。
defineClass('SecondViewController', {
            crashBtnClick: function(sender) {
            var tableViewCtrl = JPTableViewController.alloc().init()
            self.navigationController().pushViewController_animated(tableViewCtrl, YES)
            },
            
            })

//新建JPTableViewController控制器
defineClass('JPTableViewController : UITableViewController <UIAlertViewDelegate>', ['data'], {
            dataSource: function() {
            var data = self.data();
            if (data) return data;
            var data = [];
            for (var i = 0; i < 20; i ++) {
            data.push("通过js创建的cell " + i);
            }
            self.setData(data)
            return data;
            },
            numberOfSectionsInTableView: function(tableView) {
            return 1;
            },
            tableView_numberOfRowsInSection: function(tableView, section) {
            return self.dataSource().length;
            },
            tableView_cellForRowAtIndexPath: function(tableView, indexPath) {
            var cell = tableView.dequeueReusableCellWithIdentifier("cell")
            if (!cell) {
            cell = require('UITableViewCell').alloc().initWithStyle_reuseIdentifier(0, "cell")
            }
            cell.textLabel().setText(self.dataSource()[indexPath.row()])
            return cell
            },
            tableView_heightForRowAtIndexPath: function(tableView, indexPath) {
            return 60
            },
            tableView_didSelectRowAtIndexPath: function(tableView, indexPath) {
            var alertView = require('UIAlertView').alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("Alert",self.dataSource()[indexPath.row()], self, "OK",  null);
            alertView.show()
            },
            alertView_willDismissWithButtonIndex: function(alertView, idx) {
            console.log('click btn ' + alertView.buttonTitleAtIndex(idx).toJS())
            }
            })




/**************************已使用验证过**************************************/

defineClass('ChatViewController',['leftBtn'], {   // 动态添加属性
            
            viewDidLoad: function() {
            self.super().viewDidLoad();
            self.view().setBackgroundColor(UIColor.whiteColor());
            self.initSubviews();
            self.initLayout();
//            _enveModel = EnvelopeNet.shareInstance();   错误  // 不能使用下划线的属性
            self.setEnveModel(EnvelopeNet.shareInstance());  // 正确写法
            self.setEnableUnreadMessageIcon(YES);
            self.setEnableNewComingMessageIcon(YES);
            self.unreadMessage();
            self.setLeftBtn(self.navigationItem().leftBarButtonItem());
            },
            
            notifyUpdateUnreadMessageCount: function() {
            if (self.allowsMessageCellSelection()) {
            self.super().notifyUpdateUnreadMessageCount();
            return;
            }
            self.navigationItem().setLeftBarButtonItem(self.leftBtn());
            },
            
            
            
            });





require("NSString");

defineClass("NetRequestManager", {
            requestTockenWithPhone_smsCode_success_fail: function(phone, smsCode, successBlock, failBlock) {
            var info = self.requestInfoWithAct(9);
            var url = NSString.stringWithFormat("%@?mobile=%@&code=%@&grant_type=mobile&scope=server", info.url(), phone, smsCode);
            info.setUrl(url);
            self.requestWithData_requestInfo_success_fail(null, info, null, null);
            // 这里有block 传null就不再崩溃了
            }
            }, {});




defineClass("AppModel", {
            serverUrl: function() {
            self.setIsReleaseOrBeta(NO);
            // 因为不能使用下划线_   所有直接返回
            return  "http://api.5858hbw.com/api/";  
            },

            rongYunKey: function() {
            return "n19jmcy5na0i9";
            }

            }, {});

// #pragma mark - 这里注意
/**********错************/
//require("AppModel, NSString, NSUserDefaults");
//
//defineClass("ShareDetailViewController", {
//            shareUrl: function() {
//            return NSString.stringWithFormat("%@%@", _shareUrl, AppModel.shareInstance().user().invitecode());
//            }
//            }, {});
//
//defineClass("WXShareModel", {
//            setLink: function(link) {
//            var ud = NSUserDefaults.standardUserDefaults();
//            var url = ud.objectForKey("shareUrl");
//            var shareUrl = NSString.stringWithFormat("%@%@", url, AppModel.shareInstance().user().invitecode());
//            _link = shareUrl;
//            }
//            }, {});

/**********对************/
// 下划线属性获取值  _name
//var data = self.valueForKey("_shareUrl")
// 下划线属性赋值  _link   把shareUrl值赋值给 _link
//self.setValue_forKey(shareUrl,"_link");

//JSPatch 的坑
//https://blog.csdn.net/qq_31249697/article/details/79863759
require("AppModel, NSString, NSUserDefaults");

defineClass("ShareDetailViewController", {
            shareUrl: function() {
            
            var data = self.valueForKey("_shareUrl")
            return NSString.stringWithFormat("%@%@", data,AppModel.shareInstance().user().invitecode());
            
            }
            
            }, {});

defineClass("WXShareModel", {
            setLink: function(link) {
            
            var ud = NSUserDefaults.standardUserDefaults();
            var url = ud.objectForKey("shareUrl");
            var shareUrl = NSString.stringWithFormat("%@%@", url, AppModel.shareInstance().user().invitecode());
            self.setValue_forKey(shareUrl,"_link");
            }
            }, {});
