//
//  MessagesViewController.swift
//  Market.kz
//
//  Created by admin on 4/8/21.
//

import UIKit

class MessagesViewController: UIViewController {

    let imageView : UIImageView = {
        let img = UIImageView()
        
        img.image = UIImage(named: "emptyMessages")!
        img.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сообщения"
        navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 221/255, blue: 97/255, alpha: 1)
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.bounds
    }

}
