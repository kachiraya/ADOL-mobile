//
//  ViewController.swift
//  photosApp2
//
//  Created by Muskan on 10/4/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import UIKit
import Photos

protocol DataManagementDelegate{
    func onDataReceived(data: String)
}

class ShowSummaryDuringFlight_VC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, DataManagementDelegate {
    

    

    
    var myCollectionView: UICollectionView!
    var imageArray=[UIImage]()
    weak var dataManagement : DataManagement!
    
//    init () {
//        super.init(nibName: nil, bundle: nil)
//        dataManagement = DataManagement()
//        dataManagement.delegate = self
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        TEST DELEGATE
        DataManagement.sharedInstance.delegate1 = self

        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor=UIColor.black
        self.title = "Photos"
        
        let layout = UICollectionViewFlowLayout()
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(PhotoItemCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.backgroundColor=UIColor().HexToColor(hexString: "#f3F2f8", alpha: 1.0)
        self.view.addSubview(myCollectionView)
        
        myCollectionView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        
        grabPhotos()
    }
    
    
    
//    TEST DELEGATE
    func onDataReceived(data: String) {
        //        update map
        print("update map:", data)
    }
    
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoItemCell
        cell.img.image=imageArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        let vc=ImagePreview_VC()
        vc.imgArray = self.imageArray
        vc.passedContentOffset = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        //        if UIDevice.current.orientation.isPortrait {
        //            return CGSize(width: width/4 - 1, height: width/4 - 1)
        //        } else {
        //            return CGSize(width: width/6 - 1, height: width/6 - 1)
        //        }
        if DeviceInfo.Orientation.isPortrait {
            return CGSize(width: width/2 - 1, height: width/2 - 1)
        } else {
            return CGSize(width: width/3 - 1, height: width/3 - 1)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    //MARK: grab photos
    func grabPhotos(){
        imageArray = []
        
        //        DispatchQueue.global(qos: .background).async {
        //            print("This is run on the background queue")
        //            let imgManager=PHImageManager.default()
        //
        //            let requestOptions=PHImageRequestOptions()
        //            requestOptions.isSynchronous=true
        //            requestOptions.deliveryMode = .highQualityFormat
        //
        //            let fetchOptions=PHFetchOptions()
        //            fetchOptions.sortDescriptors=[NSSortDescriptor(key:"creationDate", ascending: false)]
        //
        //            let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        //            print(fetchResult)
        //            print(fetchResult.count)
        //            if fetchResult.count > 0 {
        //                for i in 0..<fetchResult.count{
        //                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width:500, height: 500),contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
        //                        self.imageArray.append(image!)
        ////                        self.imageArray.append(UIImage(named: ""))
        //                    })
        //                }
        //            } else {
        //                print("You got no photos.")
        //            }
        //            print("imageArray count: \(self.imageArray.count)")
        //
        //            DispatchQueue.main.async {
        //                print("This is run on the main queue, after the previous code in outer block")
        //                self.myCollectionView.reloadData()
        //            }
        //        }
        self.imageArray.append(UIImage(named: "lamp1")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


class PhotoItemCell: UICollectionViewCell {
    
    var img = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        img.contentMode = .scaleAspectFill
        img.clipsToBounds=true
        self.addSubview(img)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct DeviceInfo {
    struct Orientation {
        // indicate current device is in the LandScape orientation
        static var isLandscape: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isLandscape
                    : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        // indicate current device is in the Portrait orientation
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }
}

