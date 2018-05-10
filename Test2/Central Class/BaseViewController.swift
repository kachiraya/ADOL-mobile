//
//  BaseViewController.swift
//  Test2
//
//  Created by Monrada Juycharoen on 2/17/2561 BE.
//  Copyright © 2561 Monrada Juycharoen. All rights reserved.
//

import UIKit
import SocketIO

class BaseViewController: UIViewController {
    var socket : SocketIOClient!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customInit(socket : SocketIOClient) {
        self.socket = socket
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
