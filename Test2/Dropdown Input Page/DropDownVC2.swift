//
//  ViewController.swift
//  RAMReel
//
//  Created by Mikhail Stepkin on 4/2/15.
//  Copyright (c) 2015 Ramotion. All rights reserved.
//

import UIKit
import RAMReel

@available(iOS 8.2, *)
class DropDownVC2: BaseViewController, UICollectionViewDelegate {
    
    var dataSource: SimplePrefixQueryDataSource!
    var ramReel: RAMReel<RAMCell, RAMTextField, SimplePrefixQueryDataSource>!
    
    @IBOutlet var textView: UIView!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = SimplePrefixQueryDataSource(data)
        
        ramReel = RAMReel(frame: view.bounds, dataSource: dataSource, placeholder: "Start by typing…", attemptToDodgeKeyboard: true) {
            print("Plain:", $0)
        }
        
        ramReel.hooks.append {
            let r = Array($0.reversed())
            let j = String(r)
            print("Reversed:", j)
            let h: Int;
        }
        
        //view.addSubview(ramReel.view)
        
        //NSLayoutConstraint
        //ramReel.view.addConstraint(<#T##constraint: NSLayoutConstraint##NSLayoutConstraint#>)
        
        textView.addSubview(ramReel.view)
        
        
        
        ramReel.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
    @IBAction func press(_ sender: Any) {
        print("In !")
    }
    
    fileprivate let data: [String] = {
        do {
            guard let dataPath = Bundle.main.path(forResource: "data", ofType: "txt") else {
                return []
            }
            
            let data = try WordReader(filepath: dataPath)
            return data.words
        }
        catch let error {
            print(error)
            return []
        }
    }()
}
