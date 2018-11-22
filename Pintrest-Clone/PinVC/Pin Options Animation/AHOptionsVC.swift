//
//  AHOptionsVC.swift
//  Pintrest-Clone
//
//  Created by apple on 22/11/18.
//  Copyright © 2018 stopstalk. All rights reserved.
//

import Foundation
import UIKit

fileprivate let minimumRingFollowDistance: CGFloat = 100.0

fileprivate let radius: CGFloat = 80.0

fileprivate let btnSize: CGSize = CGSize(width: 55, height: 55)

fileprivate let fingerRingSize:CGSize = CGSize(width: 60, height: 60)

/// triggerDistance will be used agaist the distance between the touch point to btn.center used in buttonSelectionAnimation and maybe buttonPushAnimation
fileprivate let triggerDistance = radius * 0.7

class AHOptionsVC: UIViewController {
    
    let btnLeft = UIButton(type: .custom)
    let btnMiddle = UIButton(type: .custom)
    let btnRight = UIButton(type: .custom)
    var fingerRingView = UIImageView(image: UIImage(named: "finger-ring"))
    var allButtons: [UIButton]?
    
    fileprivate var buttonsPositions: ButtonsPositions? = nil {
        
    }
    
}

fileprivate struct ButtonsPositions {
    
    var left: CGPoint = .zero
    var middle: CGPoint = .zero
    var right: CGPoint = .zero
    var anchor: CGPoint = .zero
    var radius: CGFloat = 0.0
    
    init(anchor: CGPoint, radius: CGFloat) {
        self.anchor = anchor
        self.radius = radius
    }
    
    mutating func decide() {
        // We first calculate 3,4,5,6,7 since all the methods above are based on scenarios on the right side, faced-up of the screen.
        let unit = UIScreen.main.bounds.width / 7.0
        
        if anchor.x >= 2 * unit && anchor.x <= 5 * unit {
            zero_pi_up()
        }
        else if (anchor.x <= 6 * unit && anchor.x > 5 * unit) ||
            (anchor.x < 2 * unit && anchor.x >= 1 * unit){
            pi_radian_up_left()
        }
        else if (anchor.x < 7 * unit && anchor.x > 6 * unit) ||
            (anchor.x < 1 * unit && anchor.x > 0.0 * unit){
            pi_4_up_left()
        }
        
        // We flip points if anchor is on the left side of the screen.
        if anchor.x < 2 * unit {
            self.left = flipBasedOnY(for: self.left, basedOn: self.anchor)
            self.right = flipBasedOnY(for: self.right, basedOn: self.anchor)
            self.middle = flipBasedOnY(for: self.middle, basedOn: self.anchor)
            
            // switch the left and right positions according to Pinterest, which is good design for right-handed people -- making more-btn less useful ??
            let temp = self.left
            self.left = self.right
            self.right = temp
        }
        
        if anchor.y - radius - btnSize.height < 0 {
            // this means the 3 buttons are too close to top edge screen
            // flip baed on anchor.x
            self.left = flipBasedOnX(for: self.left, basedOn: self.anchor)
            self.right = flipBasedOnX(for: self.right, basedOn: self.anchor)
            self.middle = flipBasedOnX(for: self.middle, basedOn: self.anchor)
        }
    }
    
    func flipBasedOnX(for point: CGPoint, basedOn anchor: CGPoint) -> CGPoint {
        let x = point.x
        let y = anchor.y + (anchor.y - point.y)
        return CGPoint(x: x, y: y)
    }
    
    func flipBasedOnY(for point: CGPoint, basedOn anchor: CGPoint) -> CGPoint {
        let y = point.y
        let x = anchor.x + (anchor.x - point.x)
        return CGPoint(x: x, y: y)
    }
}

// ButtonsPositions is a struct so we can make their methods as mutating
extension ButtonsPositions {
    //    o
    //  o   o
    //    0
    mutating func zero_pi_up() {
        let radius = self.radius
        let anchor = self.anchor
        
        let r_cos_pi_4 = radius * CGFloat(cos(Double.pi/4))
        let left = CGPoint(x: anchor.x - r_cos_pi_4, y: anchor.y - r_cos_pi_4)
        let middle = CGPoint(x: anchor.x, y: anchor.y - radius)
        let right = CGPoint(x: anchor.x + r_cos_pi_4, y: anchor.y - r_cos_pi_4)
        
        self.left = left
        self.right = right
        self.middle = middle
    }
    
    /// middle btn pointing pi/6(30) radian faced-up relative to anchor.y, o is button, 0 is anchor. The radian here is up to you
    //   o  o
    // o
    //    0
    mutating func pi_radian_up_left() {
        let radius = self.radius
        let anchor = self.anchor
        
        let radian = Double.pi / 8
        let r_sin_radian = radius * CGFloat(sin(radian))
        let r_cos_radian = radius * CGFloat(cos(radian))
        let r_sin_3_radian = radius * CGFloat(sin(3 * radian))
        let r_cos_3_radian = radius * CGFloat(cos(3 * radian))
        
        let left = CGPoint(x: anchor.x - r_sin_3_radian, y: anchor.y - r_cos_3_radian)
        let middle = CGPoint(x: anchor.x - r_sin_radian, y: anchor.y - r_cos_radian)
        let right = CGPoint(x: anchor.x + r_sin_radian, y: anchor.y - r_cos_radian)
        
        self.left = left
        self.right = right
        self.middle = middle
    }
    
    /// middle btn pointing pi/4(45) radian faced-up relative to anchor.y, o is button, 0 is anchor
    //     o
    //   o
    //  o   0
    mutating func pi_4_up_left() {
        let radius = self.radius
        // move achor.x to the left a bit to avoid the right most btn intercept with left edge of screen
        let anchor = CGPoint(x: self.anchor.x - 10, y: self.anchor.y)
        
        let r_cos_pi_4 = radius * CGFloat(cos(Double.pi/4))
        let left = CGPoint(x: anchor.x - radius, y: anchor.y)
        let middle = CGPoint(x: anchor.x - r_cos_pi_4, y: anchor.y - r_cos_pi_4)
        let right = CGPoint(x: anchor.x, y: anchor.y - radius)
        
        self.left = left
        self.right = right
        self.middle = middle
    }
    
}

