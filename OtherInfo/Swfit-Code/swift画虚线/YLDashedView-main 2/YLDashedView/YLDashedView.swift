//
//  YLDashedView.swift
//  YLDashedView
//
//  Created by AlbertYuan on 2021/2/23.
//

import UIKit

//虚线颜色类型
enum YLDashedViewColorType {

    case SingleColorDashed

    case MultipleColorDashed

}

//虚线绘制方向
enum YLDashedViewDirection {

    case DashedDirectionHorizontal

    case DashedDirectionVertical
}


class YLDashedView: UIView {

    var imgView : UIImageView?

    var dashedViewColorType:YLDashedViewColorType = .SingleColorDashed
    var dashedViewDirection :YLDashedViewDirection = .DashedDirectionHorizontal
    var dashedViewLineCap  = CGLineCap.square

    var dashedColcor :UIColor = UIColor.lightGray

    // MARK: -- 计算标注
    //对于多色虚线，间隔设置公式15n-10(10为线长，15为单位线长+单位间隔)
    //起始点位置：15*index(15为单位线长+单位间隔,index为线下标)
    var dashedlenghts: [CGFloat] = [10,10] // 绘制 跳过 无限循环

    var startPhase: CGFloat = 0 //绘制起始位置
    var lineWidth :CGFloat = 1

    //多色虚线
    var dashedColcorArray :[UIColor] = [UIColor.red,UIColor.yellow]

    override init(frame:CGRect){
        super.init(frame: frame)
        print("init frame")

        setupSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //        super.init(coder: aDecoder)
        //        setupSubViews()
    }

    func setupSubViews() {
        print("setupSubViews")
        //使用 default value 初始化设置
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))

        self.addSubview(imgView!)
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        print("draw")

        guard let imageView = imgView else {
            return
        }

        switch dashedViewColorType {
        case .SingleColorDashed:
            drawSingleColorDashedView(imageView: imageView)
            break
        default:
            drawMultipleColorDashedView(imageView: imageView)
            break
        }
    }


    override func layoutSubviews() {
        //...
        print("layoutSubviews")
    }


    //绘制单色虚线
    func drawSingleColorDashedView(imageView :UIImageView){

        UIGraphicsBeginImageContext(imageView.frame.size) // 位图上下文绘制区域
        imageView.image?.draw(in: imageView.bounds)

        //获取绘图上下文
        let context:CGContext = UIGraphicsGetCurrentContext()!

        //设置虚线边沿：线条样式
        context.setLineCap(dashedViewLineCap)

        //设置虚线绘制规则
        let lengths:[CGFloat] = dashedlenghts // 绘制 跳过 无限循环

        //绘制虚线颜色
        context.setStrokeColor(dashedColcor.cgColor)

        //绘制虚线框度：线条粗细宽度
        context.setLineWidth(lineWidth)

        //虚线绘制规则
        /**
         ①phase表示开始绘制之前跳过多少点进行绘制，默认一般设置为0，第二张图片是设置5的实际效果图.
         ②lengths通常都包含两个数字，第一个是绘制的宽度，第二个表示跳过的宽度，也可以设置多个，第三张图是设置为三个参数的实际效果图.绘制按照先绘制，跳过，再绘制，再跳过，无限循环.
         */
        context.setLineDash(phase: startPhase, lengths: lengths)

        //添加路径：设置下一个坐标点
        switch dashedViewDirection {
        case .DashedDirectionHorizontal:
            //开始一个起始路径
            context.move(to: CGPoint(x: 0, y: self.frame.height/2))
            //添加路径：设置下一个坐标点
            //添加路径：设置下一个坐标点
            //添加路径：设置下一个坐标点
            //......
            context.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height/2))
            break
        case .DashedDirectionVertical:
            context.move(to: CGPoint(x: self.frame.width/2, y: 0))
            context.addLine(to: CGPoint(x: self.frame.width/2, y: self.frame.height))
            break
        //        default:
        //            break
        }
        //上下文绘制:连接上面定义的坐标点
        context.strokePath()
        //得到绘制的虚线
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
    }


    //绘制多色虚线
    func drawMultipleColorDashedView(imageView :UIImageView){
        UIGraphicsBeginImageContext(imageView.frame.size) // 位图上下文绘制区域
        imageView.image?.draw(in: imageView.bounds)
        //获取绘图上下文
        let context:CGContext = UIGraphicsGetCurrentContext()!
        //设置虚线边沿：线条样式
        context.setLineCap(dashedViewLineCap)

        for (index,color) in dashedColcorArray.enumerated() {
            //print(color,index)
            context.setStrokeColor(color.cgColor)
            context.setLineWidth(lineWidth)

            //设置虚线绘制规则
            let lengths:[CGFloat] = dashedlenghts // 绘制 跳过 无限循环
            context.setLineDash(phase: startPhase, lengths: lengths)

            switch dashedViewDirection {

            case .DashedDirectionHorizontal:
                //开始一个起始路径
                context.move(to: CGPoint(x:CGFloat(15*index), y: self.frame.height/2))
                context.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height/2))
                break
            case .DashedDirectionVertical:
                context.move(to: CGPoint(x: self.frame.width/2, y: CGFloat(15*index)))
                context.addLine(to: CGPoint(x: self.frame.width/2, y: self.frame.height))
                break
            }
            context.strokePath()
        }
        //得到绘制的虚线
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
    }
}

/**

 执行顺序
 init frame
 setupSubViews
 layoutSubviews
 layoutSubviews
 draw

 */
