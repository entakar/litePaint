//
//  ViewController.swift
//  litePaint
//
//  Created by EndoTakashi on 2019/06/25.
//  Copyright © 2019 tak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var penButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var bezierPath:UIBezierPath!
    
    var canvas:UIImageView!
    
    var lastDrawImage:UIImage?
    
    var changeColor: UIColor!
    
    var changeText = String()
    
    var penColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if changeColor != nil {
            penColor = changeColor
            print ("チェンジ")
        } else {
            penColor = UIColor.black
            print ("初期")
        }
        let width = self.view.frame.width
        let height = self.view.frame.height
        // キャンパスを設置
        canvas = UIImageView()
        canvas.frame = CGRect(x:0,y:0,width:width,height:height)
        canvas.backgroundColor = UIColor.clear
        self.view.addSubview(canvas)
    }
    
    @IBAction func penChangeAction(_ sender: Any) {
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
    
        // red
        let redColor = UIAlertAction(title: "red", style: .default, handler: { (action:UIAlertAction) in
            self.penColor = UIColor.red
        })
        alertController.addAction(redColor)
        
        let blueColor = UIAlertAction(title: "blue", style: .default, handler: { (action:UIAlertAction) in
            self.penColor = UIColor.blue
        })
        alertController.addAction(blueColor)

        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = view
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: self.canvas)
        bezierPath = UIBezierPath()
        bezierPath.lineWidth = 4.0
        bezierPath.lineCapStyle = .butt
        bezierPath.move(to:currentPoint)
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: self.canvas)
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: canvas)
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
        self.lastDrawImage = canvas.image
        
    }
    
    // 描画処理
    func drawLine(path:UIBezierPath){
        UIGraphicsBeginImageContext(canvas.frame.size)
        if let image = self.lastDrawImage {
            image.draw(at: CGPoint.zero)
        }
        let pen = penColor
        let lineColor = pen
        lineColor?.setStroke()
        path.stroke()
        self.canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    

}

