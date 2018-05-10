//
//  TestSumVC.swift
//  Test2
//
//  Created by Monrada Juycharoen on 3/2/2561 BE.
//  Copyright © 2561 Monrada Juycharoen. All rights reserved.
//

import UIKit



class TestSumVC: BaseViewController, DataManagementDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        TEST DELEGATE
        DataManagement.sharedInstance.delegate2 = self
        
//        let dataManagement = DataManagement()
//        dataManagement.getAbort()
        
        
    }
    
    func onDataReceived(data: String) {
        //        update abort
        print("update abort:", data)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToSumDidTap(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Folding", bundle: Bundle.main)
//        let viewController = storyboard.instantiateInitialViewController() as MainTableViewCont
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func show_pop_up(_ sender: Any) {
        print("pop up!")
        let alertView = UIAlertController(title: "Loss Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "Ok", style: .destructive){
            (action) in print("ok")
        }
        alertView.addAction(ok)
        
        present(alertView, animated: true, completion: nil)
        
    }

    @IBAction func show_mission_end_pop_up(_ sender: Any) {

        let folding = storyboard?.instantiateViewController(withIdentifier: "Folding") as! MainTableViewController
        
        let alertView = UIAlertController(title: "Mission has ended!", message: "Proceed to the mission summary page to view objects found.", preferredStyle: .actionSheet)
        
        let ok = UIAlertAction(title: "Ok", style: .destructive){
            (action) in self.navigationController?.pushViewController(folding, animated: true)
        }
        
        alertView.addAction(ok)
        
        present(alertView, animated: true, completion: nil)
    }
    

}
