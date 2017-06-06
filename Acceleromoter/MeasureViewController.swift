//
//  MeasureViewController.swift
//  Acceleromoter
//
//  Created by Leon Iwami on 2017/05/30.
//  Copyright © 2017年 Leon Iwami. All rights reserved.
//

import UIKit
import CoreMotion

class MeasureViewController: UIViewController {
    
    @IBOutlet var awaImageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    var accelerationX: Double!
    var accelerationY: Double!
    var radian: Double!
    
    let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.01
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { (data,error) in
                
                self.accelerationX = -(data?.acceleration.x)!
                self.accelerationY = (data?.acceleration.y)!
                
                var r = atan2((data?.acceleration.y)!, (data?.acceleration.x)!)
                if r < 0 {
                    r = r + 2 * M_PI
                }
                self.radian = floor(r * 360 / (2 * M_PI))
                
                let result: Double = fabs(self.radian)
                self.label.text = String(format: "%.f°",result)
                
                self.awaImageView.center.x =
                    self.awaImageView.center.x - CGFloat(self.accelerationX*20)
                if self.awaImageView.frame.origin.x < 30 {
                    self.awaImageView.frame.origin.x = 30
                }
                if self.awaImageView.frame.origin.x > 205 {
                    self.awaImageView.frame.origin.x = 205
                }
                
                self.awaImageView.center.y =
                    self.awaImageView.center.y - CGFloat(self.accelerationY*20)
                if self.awaImageView.frame.origin.y < 30 {
                    self.awaImageView.frame.origin.y = 30
                }
                if self.awaImageView.frame.origin.y > 480 {
                    self.awaImageView.frame.origin.y = 480
                }
                
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        resultViewController.accelerationX = self.accelerationX
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
