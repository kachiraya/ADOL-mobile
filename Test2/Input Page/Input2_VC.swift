//
//  Input2_VC.swift
//  Test2
//
//  Created by Monrada Juycharoen on 2/5/2561 BE.
//  Copyright © 2561 Monrada Juycharoen. All rights reserved.
//

import UIKit
import SearchTextField
import SocketIO
import RAMReel



class Input2_VC: BaseViewController {
    
    @IBOutlet var object_textfield: SearchTextField!
    
    @IBOutlet var dropDownView: UIView!
    @IBOutlet var logoImageView: UIImageView!
    
    var object_string: String = ""
    var data_array = [String]()
    // @IBOutlet var viewDropDown: UIView!
//    @IBOutlet var dropDownView: UIView!
    
    ///////DROPDOWN
    var dataSource: SimplePrefixQueryDataSource!
    var ramReel: RAMReel<RAMCell, RAMTextField, SimplePrefixQueryDataSource>!
    ///////DROPDOWN///
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Object"
        
        socket.on("command_message") { ( dataArray, ack) -> Void in
            print("tryyyyy: " , dataArray[0])
        }
        
        //////DROPDOWN
        dataSource = SimplePrefixQueryDataSource(data)

        ramReel = RAMReel(frame: view.bounds, dataSource: dataSource, placeholder: "Enter target object ex.ball", attemptToDodgeKeyboard: true) {
            print("Plain:", $0)
//            Assign chosen object string to variable
            self.object_string = $0
        }
//        Relate ramreel's textfield to extension
        ramReel.textFieldDelegate = self
        ramReel.hooks.append {
            let r = Array($0.reversed())
            let j = String(r)
            print("Reversed:", j)
        }


        dropDownView.addSubview(ramReel.view)
        ramReel.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        ///////DROPDOWN/////
    }
    
    //////DROPDOWN
    
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
    ///////DROPDOWN/////

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func press_search(_ sender: Any) {
        self.socket.emit("command_message", with: ["{\"object\": \"" + self.object_string + "\"}"] )

//        Send data to DataManagement
        DataManagement.sharedInstance.customInit(socket: self.socket)
//        dataManagement.tryy()
//        dataManagement.customInit(socket: self.socket)
        
        
    }

}

extension Input2_VC : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("In")
        textField.text = ""
        textField.textColor = UIColor.black
        UIView.animate(withDuration: 1, animations: {
            self.logoImageView.alpha = 0.0
            //            self.logoImageView.isHidden = true
        })
        print("In")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Out")
        UIView.animate(withDuration: 1, animations: {
            self.logoImageView.alpha = 1.0
            //            self.logoImageView.isHidden = false
        })
        
//        Check invalid input
        var has = false
        for var i in data{
            if (self.object_string == i){
                has = true
            }
        }
//        if entered object deosn't exist in list, change texfieldh holder to red "invalid input!"
        if (has == false){
            textField.textColor = UIColor.red
            textField.text = "Invalid Input!"
            
        }
        


        
    }
}
