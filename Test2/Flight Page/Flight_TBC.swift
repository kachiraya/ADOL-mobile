//
//  Flight_TBC.swift
//  Test2
//
//  Created by Monrada Juycharoen on 2/10/2561 BE.
//  Copyright © 2561 Monrada Juycharoen. All rights reserved.
//

import UIKit
import KYWheelTabController

class Flight_TBC: UIViewController {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let vc0 = UIViewController()
        vc0.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "sample0"),
            selectedImage: UIImage(named: "sample0_selected"))

        let vc1 = UIViewController()
        vc1.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "sample1"),
            selectedImage: UIImage(named: "sample1_selected"))

        let vc2 = UIViewController()
        vc2.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "sample2"),
            selectedImage: UIImage(named: "sample2_selected"))

        let vc3 = UIViewController()
        vc3.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "sample3"),
            selectedImage: UIImage(named: "sample3_selected"))

        let wheelTabController = KYWheelTabController()
        wheelTabController.viewControllers = [vc0, vc1, vc2, vc3]

        /* Customize
         // selected boardre color.
         wheelTabController.tintColor = UIColor.redColor()
         */
        wheelTabController.tintColor = UIColor.red

        window?.rootViewController = wheelTabController

        return true
    }
    
    /* ====================================================================== */
    // MARK: Properties
    /* ====================================================================== */
    
//    @IBInspectable open var tintColor: UIColor = UIColor(colorLiteralRed: 0, green: 122/255, blue: 1, alpha: 1) {
//        didSet {
//            wheelMenuView.tintColor = tintColor
//        }
//    }
//
//    override open var viewControllers: [UIViewController]? {
//        didSet {
//            wheelMenuView.tabBarItems = tabBarItems
//        }
//    }
//
//    open internal(set) lazy var wheelMenuView: WheelMenuView = {
//        return WheelMenuView(
//            frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 201, height: 201)),
//            tabBarItems: self.tabBarItems)
//    }()
//
//    fileprivate var tabBarItems: [UITabBarItem] {
//        return viewControllers?.map { $0.tabBarItem } ?? []
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let wheelTabController = KYWheelTabController()
        wheelTabController.tintColor = UIColor.red
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
