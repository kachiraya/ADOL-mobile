//
//  MainTable_VC.swift
//  Test2
//
//  Created by Monrada Juycharoen on 2/12/2561 BE.
//  Copyright © 2561 Monrada Juycharoen. All rights reserved.
//

import FoldingCell
import UIKit


fileprivate struct C {
    struct CellHeight {
        static let close: CGFloat = 75 // equal or greater foregroundView height
        static let open: CGFloat = 456 // equal or greater containerView height
    }
}

class MainTVC: UITableViewController {

//    @IBOutlet var foregroundView: RotatedView!
//
//    @IBOutlet var containerView: UIView!
    
    @IBInspectable var itemCount: NSInteger = 3
    
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    let kRowsCount = 10
    var cellHeights: [CGFloat] = []
    
    var foundObjects: [String] = ["1", "2", "3"]
    
    //var cellHeights = (0..<CELLCOUNT).map { _ in C.CellHeight.close}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemCount = foundObjects.count;
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return foundObjects.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }
    
    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as SummaryCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
        cell.number = indexPath.row
    }

}
