//
//  DataRetrieveAndDistribute.swift
//  Test2
//
//  Created by Monrada Juycharoen on 4/27/2561 BE.
//  Copyright © 2561 Monrada Juycharoen. All rights reserved.
//

import Foundation
import SocketIO

class DataManagement {
    
//    TEST DELEGATE
    var delegate1 : DataManagementDelegate!
    var delegate2 : DataManagementDelegate!
    
    static let sharedInstance = DataManagement()
    
    var drone_id = String()
    var object_search = String()
    var map_photo = String()
    var foundedObjectPhotos = [String]()
    
    var video: RTSPPlayer!
    var socket : SocketIOClient!
    
    
    //map : [MapData]
    //foundedObject : []
//    var mapDatas: [String]
    
    
    
    init() {

    }

    func customInit(socket : SocketIOClient) {
        self.socket = socket
        
//        ----------- Receive data from server
        
        //        ----------- Receive drone id from server
        self.socket.on("drone_id") { ( dataArray, ack) -> Void in
            self.drone_id = dataArray[0] as! String
            print("drone_id:", self.drone_id)
        }
        
        //        ----------- Receive object to search from server
        self.socket.on("object_search") { ( dataArray, ack) -> Void in
            self.object_search = dataArray[0] as! String
            print("object_search:", self.object_search)
        }
        
        //        ----------- Receive map photo from server
        self.socket.on("map_photo") { ( dataArray, ack) -> Void in
            self.map_photo = dataArray[0] as! String
            print("map_photo:", self.map_photo)
        }
        
        //        ----------- Receive photo of object found from server
        self.socket.on("object_found_photo") { ( dataArray, ack) -> Void in
//            object_found_photo = dataArray[0] as! String
            self.foundedObjectPhotos.append(dataArray[0] as! String)
            print("foundedObjectPhotos:", self.foundedObjectPhotos)
            print("foundedObjectPhotos_size:", self.foundedObjectPhotos.count)
        }
        
        
        
        
        
        
        
        
        //        ----------- Receive map coordinate construction data from server
//        self.socket.on("map_data") { ( dataArray, ack) -> Void in
//            print("Map data: ", dataArray[0])
////            self.mapDatas.append(dataArray[0] as! String)
//            if let delegate1 = self.delegate1{
//                delegate1.onDataReceived(data: dataArray[0] as! String)
//            }
//        }
        
        //        ----------- Receive abort from server
//        self.socket.on("abort") { ( dataArray, ack) -> Void in
//            print("Abort: ", dataArray[0])
//            if let delegate2 = self.delegate2{
//                delegate2.onDataReceived(data: dataArray[0] as! String)
//            }
//        }
        
        //        ----------- Receive streaming from server
//        video = RTSPPlayer(video: "rtsp://192.168.95.239:8554/unicast", usesTcp: false)
        

        
        
    }
    
    
    
    
//         ----------- Receive object found photo & text from server
    func getObjectFoundData(){
        socket.on("object_found_photo") { ( dataArray, ack) -> Void in
        print("object_found_photo")
        }
        socket.on("object_found_photo_data") { ( dataArray, ack) -> Void in
        print("object_found_photo_data")
        }
    }
    
//        ----------- Receive abort from server
    func getAbort() {
        print("Abort")
//        socket.on("abort") { ( dataArray, ack) -> Void in
//            print("abort")
//        }
    }
    
//    Get video
    func getVideo(){
        //        ----------- Receive streaming from server
//                video = RTSPPlayer(video: "rtsp://192.168.95.239:8554/unicast", usesTcp: false)
        //        video.outputWidth = Int32(UIScreen.main.bounds.width)
        //        video.outputHeight = Int32(UIScreen.main.bounds.height)
        //        video.seekTime(0.0)
        
        //        let timer = Timer.scheduledTimer(timeInterval: 1.0/30, target: self, selector: #selector(RTSPVC.update), userInfo: nil, repeats: true)
        //        timer.fire()
    }
    
    
    
    
    
    
//    @objc func update(timer: Timer) {
//        if(!video.stepFrame()){
//            timer.invalidate()
//            video.closeAudio()
//        }
//        imageView.image = video.currentImage
//    }
}
