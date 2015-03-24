//
//  ViewController.swift
//  week3Animation
//
//  Created by Jonlin Pei on 2/16/15.
//  Copyright (c) 2015 Jonlin Pei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bikerImageView: UIImageView!
    
    var scale: CGFloat! = 1
    var rotate: CGFloat! = 0
    var originalCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bikerImageView.alpha = 1.0
        originalCenter = bikerImageView.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func didPressGoButton(sender: AnyObject) {
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: nil, animations: { () -> Void in
            self.bikerImageView.center.y = 400
            self.bikerImageView.alpha = 1.0
            self.bikerImageView.transform = CGAffineTransformMakeScale(3, 3)
            }) { (finished: Bool) -> Void in
                var rotate = CGFloat(-10 * M_PI/180)
                self.bikerImageView.transform = CGAffineTransformRotate(self.bikerImageView.transform, rotate)
                UIView.animateWithDuration(0.3, delay:0, options:
                    UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                        var rotate = CGFloat(20 * M_PI/180)
                        self.bikerImageView.transform = CGAffineTransformRotate(self.bikerImageView.transform, rotate)
                }) { (Bool) -> Void in
                }
        }
    }
    
    
    //Gestures
    
    @IBAction func didTapBiker(sender: AnyObject) {
        println("Tapped Mr T")
        var alertView = UIAlertView(title: "YO!", message: "Who's tapping Mr T!!", delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }

    
    @IBAction func didPanBiker(sender: UIPanGestureRecognizer) {
        NSLog("Panning Mr. T")
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        bikerImageView.center = location
        
        if (sender.state == UIGestureRecognizerState.Began){
            //started to pan
            println("Pan started")
            scale = 1.5
            transformBiker()
            
        } else if (sender.state == UIGestureRecognizerState.Changed){
            //started to pan
            println("Pan changed")
            bikerImageView.center = CGPointMake(originalCenter.x + translation.x, originalCenter.y + translation.y)

        } else if (sender.state == UIGestureRecognizerState.Ended){
            //started to pan
            println("Pan ended")
            bikerImageView.transform = CGAffineTransformMakeScale(1.5, 1.5)

        }
        
        
        println("location: \(location)")
        println("velocity: \(velocity)")
        println("translation: \(translation)")
        
    }
    
    
    @IBAction func didPinchBiker(sender: UIPinchGestureRecognizer) {
        scale = sender.scale
        transformBiker()
    }
    
    @IBAction func didRotateBiker(sender: UIRotationGestureRecognizer) {
        rotate = sender.rotation
        transformBiker()
    }
    
    
    func transformBiker(){
        var scaleTransform = CGAffineTransformMakeScale(scale, scale)
        var rotateTransform = CGAffineTransformMakeRotation(rotate)
        var concatTransform = CGAffineTransformConcat(scaleTransform, rotateTransform)
        bikerImageView.transform = CGAffineTransformScale(bikerImageView.transform, scale, scale)
    }
    
    @IBAction func didPressReset(sender: AnyObject) {
        scale = 1
        rotate = 0
        bikerImageView.transform = CGAffineTransformIdentity
        bikerImageView.center = originalCenter
    }
    

}

