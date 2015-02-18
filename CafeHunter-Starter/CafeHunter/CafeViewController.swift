//
//  CafeViewController.swift
//  CafeHunter
//
//  Created by Anyuan on 15/2/17.
//  Copyright (c) 2015年 Razeware. All rights reserved.
//

import Foundation

@objc protocol CafeViewControllerDelegate {
    
    optional func cafeViewControllerDidFinish(viewController: CafeViewController)
    
}

class CafeViewController: UIViewController {
    
    var cafe: Cafe? {
        didSet {
            self.setupWithCafe()
        }
    }
    
    
    weak var delegate: CafeViewControllerDelegate?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var streetLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var zipLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWithCafe()
    }
    
    private func setupWithCafe() {
        if !self.isViewLoaded() {
            return
        }
        
        if let cafe = self.cafe {
            self.title = cafe.name
            
            self.nameLabel.text = cafe.name
            self.streetLabel.text = cafe.street
            self.cityLabel.text = cafe.city
            self.zipLabel.text = cafe.zip
            
            let request = NSURLRequest(URL: cafe.pictureURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }
    }
    
    @IBAction private func back(sender: AnyObject) {
        self.delegate?.cafeViewControllerDidFinish?(self)
    }


    
}