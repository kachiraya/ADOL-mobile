//
//  ipVC.swift
//  Test2
//
//  Created by Monrada Juycharoen on 10/8/2560 BE.
//  Copyright © 2560 Monrada Juycharoen. All rights reserved.
//

import UIKit
import SwiftyOnboard
import AlertOnboarding
import SocketIO
import RAMReel
import CoreData


class Input1_VC: BaseViewController, AlertOnboardingDelegate, UICollectionViewDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet var viewDropDown: UIView!
    @IBOutlet var logoImageView: UIImageView!
    
//    var drones = [Drone]()
    var drone_string: String = ""
    
    ///////DROPDOWN
    var dataSource: SimplePrefixQueryDataSource!
    var ramReel: RAMReel<RAMCell, RAMTextField, SimplePrefixQueryDataSource>!
    ///////DROPDOWN///
    
    ///////INTRO
    var alertView: AlertOnboarding!

    var arrayOfImage = ["Intro1", "Intro2", "Intro3"]
    var arrayOfTitle = ["SEARCH OBJECT", "LOCALIZATION & MAPPING", "LIVE STREAMING"]
    var arrayOfDescription = ["Choose target object to search for from list of variety objects while drone flies around to search for the object",
                              "Naviagte the environment along with locate and return the position of target object within a map",
                              "Watch video  of the surround environment taken from the drone at real-time"]
    ///////INTRO///////
    
    
    override func viewDidLoad() {
//        var data_fetch = UserDefaults.standard.array(forKey: "dataArray")
//        print("data_fetch", data_fetch!)
        
        self.title = "Drone Id"
        
//        --- Connect to server
        socket = SocketIOClient(socketURL: URL(string: "http://localhost:8000")!,config: [.log(true), .compress])
        socket.connect()

        
        ///////INTRO
        super.viewDidLoad()
        
        alertView = AlertOnboarding(arrayOfImage: arrayOfImage, arrayOfTitle: arrayOfTitle, arrayOfDescription: arrayOfDescription)
        alertView.delegate = self
        
        // Edit
        self.alertView.colorForAlertViewBackground = UIColor().HexToColor(hexString: "#f3F2f8", alpha: 1.0)
        self.alertView.colorButtonText = UIColor.white
        self.alertView.colorButtonBottomBackground = UIColor().HexToColor(hexString: "#785bdc", alpha: 1.0)

        self.alertView.show()
        ///////INTRO///////
        

        //////DROPDOWN

        dataSource = SimplePrefixQueryDataSource(data)

//        ramReel = RAMReel(frame: view.bounds, dataSource: dataSource, placeholder: "Start by typing…", attemptToDodgeKeyboard: true) {
//            print("Plain:", $0)
//        }
        let rect = CGRect(x: 200, y: 200, width: 200, height: 200)
        ramReel = RAMReel(frame: viewDropDown.bounds, dataSource: dataSource, placeholder: "Enter drone id...", attemptToDodgeKeyboard: true)
        {
            print("Plain:", $0)
//  Assign chosen object string to variable
            self.drone_string = $0
        }

        ramReel.textFieldDelegate = self
        ramReel.hooks.append {
            let r = Array($0.reversed())
            let j = String(r)
            print("Reversed:", j)
        }

//        view.addSubview(ramReel.view)
        viewDropDown.addSubview(ramReel.view)
        ramReel.view.autoresizingMask = [.flexibleWidth]
        
        ///////DROPDOWN/////
        
//        socket.on("command_message") { ( dataArray, ack) -> Void in
//            print(dataArray[0])
//        }
        

    }
    
    //  Fetch String[] from core data
//    func fetch_data() -> [String] {
//        var temp = [String]()
//        for i in self.drones {
//            print ("Hello, \(i)!")
//            temp.append(i.id!)
//        }
//        return temp
//    }
//
     //////DROPDOWN
    
//    fileprivate var data: [String] {
//        get{
//            return fetch_data()
//        }
//    }
    
    fileprivate let data: [String] = {
        do {
//            guard let dataPath = Bundle.main.path(forResource: "data", ofType: "txt") else {
//                return []
//            }
//            let data = try WordReader(filepath: dataPath)
//
//
//            return data.words
            var data_fetch = UserDefaults.standard.array(forKey: "dataArray")
            var temp3 = [String]()
            if data_fetch != nil {
                for var i in data_fetch! {
                    i = i as! String
                    print("i = ", i)
                    temp3.append(i as! String)
                }
            }
            
            print("temp3 = ", temp3)
            return temp3
        }
        catch let error {

            return []
        }
    }()
    
    ///////DROPDOWN/////
    

    
    
    @IBAction func press_nextButton(_ sender: Any) {
        //  --- Tell server it's app and want to connect to drone #123
//        socket.on(clientEvent : .connect){ data,ack in
//            // It's application & I want to connect to drone #123
//            self.socket.emit("check_connection", "{\"type\": \"app\", \"number\": \"" + self.textField.text! + "\"}")
//        }
        
//       self.socket.emit("check_connection", "{\"type\": \"app\", \"number\": \"" + self.textField.text! + "\"}")
        self.socket.emit("check_connection", "{\"type\": \"app\", \"number\": \"" + self.drone_string + "\"}")
        
        let input2 = storyboard?.instantiateViewController(withIdentifier: "Input2") as! Input2_VC
        input2.customInit(socket: self.socket)
        
//        Save String[] to UserDefaults
        var data_save = UserDefaults.standard.array(forKey: "dataArray")
        var has = false
        var temp2 = [String]()
        if data_save != nil {
            for var i in data_save! {
                i = i as! String
                print("i = ", i)
                temp2.append(i as! String)
                if (self.drone_string == (i as! String)){
                    has = true
                }
            }
        }
        
        if (has == false){
            temp2.append(self.drone_string)
        }

        print("temp2 = ", temp2)
        UserDefaults.standard.set(temp2, forKey: "dataArray")
        
        
        
        //        Check connection with drone
        //        Show pop up showing success/not success connection
        
        
        navigationController?.pushViewController(input2, animated: true)
        
        
//              append [String]
//              save [String]
        
        
//        let drone = Drone(context: PersistenceService.context)
//        drone.id = self.drone_string
//        PersistenceService.saveContext()
//        print("Save!")
        
//        Save object string
//        print("self.drone_string = ", self.drone_string)
//        var data_save = UserDefaults.standard.array(forKey: "dataArray")
////        var data_save = [String]()
//        data_save = [String](data_save!)
//
//        print("data_save_before = ", data_save)
//
//        data_save.append(self.drone_string )
//        print("data_save_after = ", data_save)
//        UserDefaults.standard.set(data_save, forKey: "dataArray")
        

    }
    
    
    
    ///////INTRO
    @IBAction func showAlert(_ sender: Any) {
        print("WORK")
        
        
//         self.alertView.colorForAlertViewBackground = UIColor(red: 173/255, green: 206/255, blue: 183/255, alpha: 1.0)
//         self.alertView.colorButtonText = UIColor.whiteColor()
//         self.alertView.colorButtonBottomBackground = UIColor(red: 65/255, green: 165/255, blue: 115/255, alpha: 1.0)
//
//         self.alertView.colorTitleLabel = UIColor.whiteColor()
//         self.alertView.colorDescriptionLabel = UIColor.whiteColor()
//
//         self.alertView.colorPageIndicator = UIColor.whiteColor()
//         self.alertView.colorCurrentPageIndicator = UIColor(red: 65/255, green: 165/255, blue: 115/255, alpha: 1.0)
//
//         self.alertView.percentageRatioHeight = 0.5
//         self.alertView.percentageRatioWidth = 0.5
        

        self.alertView.show()
    }
    
    func alertOnboardingSkipped(_ currentStep: Int, maxStep: Int) {
        print("Onboarding skipped the \(currentStep) step and the max step he saw was the number \(maxStep)")
    }
    
    func alertOnboardingCompleted() {
        print("Onboarding completed!")
    }
    
    func alertOnboardingNext(_ nextStep: Int) {
        print("Next step triggered! \(nextStep)")
    }
    ///////INTRO///////
    
    

    
//    Send input ip and page title to MainVC page
//    @IBAction func doneAC(_ sender: Any) {
//        let vc = MainVC()
//        let intro1 = Intro1()
//        vc.customInit(ipStr: textfield.text!, title: "ADOL")
//        self.navigationController?.pushViewController(intro1, animated: true)
//    }
    
}

extension Input1_VC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1, animations: {
            self.logoImageView.alpha = 0.0
//            self.logoImageView.isHidden = true
        })
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1, animations: {
            self.logoImageView.alpha = 1.0
//            self.logoImageView.isHidden = false
        })
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



