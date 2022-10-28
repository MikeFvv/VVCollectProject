//
//  ViewController.swift
//  YLDashedView
//
//  Created by AlbertYuan on 2021/2/23.
//

import UIKit

class ViewController: UIViewController {

    var dashed: YLDashedView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        dashed = YLDashedView.init(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 10))
        dashed.dashedColcor = UIColor.red
        //dashed.backgroundColor = UIColor.yellow
        view.addSubview(dashed)



        let dashedver = YLDashedView.init(frame: CGRect(x: 100, y: 100, width: 10, height: 400))
        dashedver.dashedColcor = UIColor.brown
        dashedver.dashedViewDirection = .DashedDirectionVertical
        dashedver.dashedlenghts = [10,5,15]
        dashedver.lineWidth = 3
        //dashed.backgroundColor = UIColor.yellow
        view.addSubview(dashedver)


        let dashedverMul = YLDashedView.init(frame: CGRect(x: 0, y: 300, width: self.view.frame.width, height: 10))
        dashedverMul.dashedColcorArray = [UIColor.green,UIColor.red,UIColor.black,UIColor.yellow]
        dashedverMul.dashedViewDirection = .DashedDirectionHorizontal
        dashedverMul.dashedlenghts = [10,50]    //15n-10
        dashedverMul.lineWidth = 2
        dashedverMul.dashedViewColorType = .MultipleColorDashed
        view.addSubview(dashedverMul)

        
        let dashedverMulv = YLDashedView.init(frame: CGRect(x: 200, y: 100, width: 10, height: 400))
        dashedverMulv.dashedColcorArray = [UIColor.green,UIColor.red,UIColor.black,UIColor.yellow]
        dashedverMulv.dashedViewDirection = .DashedDirectionVertical
        dashedverMulv.dashedlenghts = [10,CGFloat(15*dashedverMulv.dashedColcorArray.count-10)]    //15n-10
        dashedverMulv.lineWidth = 2
        dashedverMulv.dashedViewColorType = .MultipleColorDashed
        view.addSubview(dashedverMulv)
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dashed.frame = CGRect(x: 0, y: 110, width: self.view.frame.width, height: 10)
        dashed.dashedColcor = UIColor.blue
        dashed.setNeedsDisplay()
    }
}

