//
//  MainTableViewController.swift
//
// Copyright (c) 21/12/15. Ramotion Inc. (http://ramotion.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import FoldingCell
import UIKit

class MainTableViewController: UITableViewController {

    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    let kRowsCount = 5
    var cellHeights: [CGFloat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneSummary))
        
//        self.performSegue(withIdentifier: "unwindToInput1VC", sender: self)
        
//        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func doneSummary(){
        self.navigationController?.popToRootViewController(animated: true)
        
//        let mainView: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let initialViewController = mainView.instantiateViewController(withIdentifier: "input1VC")
//        let navController = UINavigationController.init(rootViewController: initialViewController)
        
//        UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: nil)
    }

    private func setup() {
        cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        tableView.backgroundColor = UIColor().HexToColor(hexString: "#f3F2f8", alpha: 1.0)

    }
}

// MARK: - TableView

extension MainTableViewController {

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 5
    }

    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as DemoCell = cell else {
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }

    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
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
}

// Extension of UI color
//extension UIColor{
//    func HexToColor(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
//        // Convert hex string to an integer
//        let hexint = Int(self.intFromHexString(hexStr: hexString))
//        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
//        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
//        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
//        let alpha = alpha!
//        // Create color object, specifying alpha as well
//        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
//        return color
//    }
//
//    func intFromHexString(hexStr: String) -> UInt32 {
//        var hexInt: UInt32 = 0
//        // Create scanner
//        let scanner: Scanner = Scanner(string: hexStr)
//        // Tell scanner to skip the # character
//        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
//        // Scan hex value
//        scanner.scanHexInt32(&hexInt)
//        return hexInt
//    }
//}

