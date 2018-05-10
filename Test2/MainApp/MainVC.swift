//
//  MainVC.swift
//  Test2
//
//  Created by Monrada Juycharoen on 10/8/2560 BE.
//  Copyright © 2560 Monrada Juycharoen. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyOnboard

class MainVC: UIViewController {

    @IBOutlet weak var bg: UIImageView!
    
    @IBOutlet weak var textfield: UITextField!
    let imagepicker = UIImagePickerController()
    var ipStr : String!
    var vase_image = UIImage()
    
    @IBOutlet weak var image_test: UIImageView!
    
    var socket : SocketIOClient!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pragard wa imagepicker pen look-jang gu
        
//        imagepicker.delegate = self *****************IMPORTANT
        
        // connect pai nhai
//        RAS PI
//         socket = SocketIOClient(socketURL: URL(string: "http://" + "192.168.95.239" + ":8000")!,config: [.log(true), .compress])
//        LOCAL HOST
        socket = SocketIOClient(socketURL: URL(string: "http://localhost:8000")!,config: [.log(true), .compress])
        socket.connect()
        
        socket.on(clientEvent : .connect){ data,ack in
            print("connected")
            self.socket.emit("check_connection", "app123")
        }
        
        
//        receive text from raspi
        socket.on("SomeMessage") { ( dataArray, ack) -> Void in
//            print("somemessage")
            print(dataArray[0])
        }
        

        
        
        
        
        //          receive photo from raspi
        socket.on("photo") { data,ack in
            let dataData = data[0] as! Data
            let decodeData:NSData = NSData(base64Encoded: dataData, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
            print(type(of: decodeData))
            
            let img = UIImage(data: decodeData as Data)
            self.vase_image = img!
            
            
            
//            if let buffer = dataData as? NSData {
//                let img = UIImage(data: buffer as Data)
//
//                self.vase_image = img!
//            }
        }
        
        
        
//        RECEIVE PHOTO FROM RAS PI
//        socket.on("photo") { ( dataArray, ack) -> Void in
//            print("receive photo")
//            print(dataArray[0])
//
//            print(type(of: dataArray[0]))
        
////             Data to NSData
//            let aDataReference = dataArray[0] as! NSData
//            print(type(of: aDataReference))
////            let image1: UIImage = UIImage(data:aDataReference as Data,scale:1.0)!
//
//            if let image1 = UIImage(data: aDataReference as Data){
//                print(type(of: image1))
//                self.vase_image = image1
//            }
//
//            if let image1 = UIImage(data: dataArray[0] as! Data){
//                print(type(of: image1))
//                self.vase_image = image1
//            }
//        }
        
        
        
        
        

        self.socket.emit("test_message", "self.textfield.text!")
    }
    
    
    
    
//    func change_bg (image1: UIImage){
//        print("bg change")
//        bg.isHidden = false
//        image_test.image = image1
//    }
    
    
//    called by ipVC to edit ip
    func customInit(ipStr : String, title : String) {
        self.ipStr = ipStr
        self.title = title
    }
    
    @IBAction func watch_live_click(_ sender: Any) {
        let vc = RTSPVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func onButtonClicked(_ sender: Any) {
        self.socket.emit("test_message", self.textfield.text!)
    }
    
    
    @IBAction func showMoomin(_ sender: Any) {
        bg.image = vase_image
        bg.isHidden = false
        
        // can edit like crop ?
        imagepicker.allowsEditing = false
        imagepicker.sourceType = .photoLibrary
        self.present(imagepicker, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendImage(image : UIImage){
        //send image to socket
        //encoded to base64
        //send base64 to socket
        
        //encode
        let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
        let imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))

        // to make sure to other data is attach to imageStr when send through socket; send using json format
        let payload = [
            "image" : imageStr
        ]
        
        //send image
        self.socket.emit("test_image", payload)
    }
    
}

//UIImagePickerControllerDelegate,UINavigationControllerDelegate >>>>they ma koo gaan
//extension MainVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    // picker is controller(look-jang)
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        print(info)
//        //if pickedImage mee roob, cast mun pen UIImage and do if's {}
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
//            bg.image = pickedImage
//            self.sendImage(image: pickedImage)
//        }
//        dismiss(animated: true, completion: nil)
//    }
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        print("cancel")
//        dismiss(animated: true, completion: nil)
//    }
//}




