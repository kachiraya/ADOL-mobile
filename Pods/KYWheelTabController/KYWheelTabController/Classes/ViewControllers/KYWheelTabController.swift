//
//  KYWheelTabController.swift
//  KYWheelTabController
//
//  Created by kyo__hei on 2016/02/20.
//  Copyright © 2016年 kyo__hei. All rights reserved.
//

import UIKit

open class KYWheelTabController: UITabBarController {
    
    /* ====================================================================== */
    // MARK: Properties
    /* ====================================================================== */
    
    @IBInspectable open var tintColor: UIColor = UIColor().HexToColor(hexString: "#785BDC", alpha: 1.0) {
        didSet {
            wheelMenuView.tintColor = tintColor
        }
    }
    
    override open var viewControllers: [UIViewController]? {
        didSet {
            wheelMenuView.tabBarItems = tabBarItems
            
        }
    }
    
    open internal(set) lazy var wheelMenuView: WheelMenuView = {
        return WheelMenuView(
            frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 201, height: 201)),
            tabBarItems: self.tabBarItems)
    }()
    
    fileprivate var tabBarItems: [UITabBarItem] {
        return viewControllers?.map { $0.tabBarItem } ?? []
    }
    
    
    /* ====================================================================== */
    // MARK:  Life Cycle
    /* ====================================================================== */
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Abort", style: .plain, target: self, action: #selector(abort))
        
        tabBar.isHidden = true
        
        wheelMenuView.tintColor = tintColor
        wheelMenuView.boarderColor = UIColor().HexToColor(hexString: "#E5DDFE", alpha: 1.0)
        wheelMenuView.menuBackGroundColor = UIColor().HexToColor(hexString: "#F7F5FC", alpha: 1.0)
        wheelMenuView.centerButton.backgroundColor = UIColor().HexToColor(hexString: "#F3F2F8", alpha: 1.0)
        
        wheelMenuView.delegate = self
        wheelMenuView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wheelMenuView)
        
        view.addConstraints([
            NSLayoutConstraint(
                item: wheelMenuView,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .width,
                multiplier: 1.0,
                constant: 201
            ),
            NSLayoutConstraint(
                item: wheelMenuView,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .height,
                multiplier: 1.0,
                constant: 201
            ),
            NSLayoutConstraint(
                item: wheelMenuView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: view,
                attribute: .centerX,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: wheelMenuView,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: view,
                attribute: .bottom,
                multiplier: 1.0,
                constant: 44
            )
        ])
    }
    
    @objc func abort(){
        let alertView = UIAlertController(title: "Abort Mission!", message: "Are you sure you want to abort the mission?", preferredStyle: .actionSheet)
        let yes = UIAlertAction(title: "Yes", style: .destructive){
            (action) in print("yes")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive){
            (action) in print("cancel")
        }
        alertView.addAction(yes)
        alertView.addAction(cancel)
        
        present(alertView, animated: true, completion: nil)
    }

}

extension KYWheelTabController: WheelMenuViewDelegate {
    
    public func wheelMenuView(_ view: WheelMenuView, didSelectItem: UITabBarItem) {
        selectedIndex = view.selectedIndex
    }
    
}

// Extension of UI color
extension UIColor{
    func HexToColor(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}
