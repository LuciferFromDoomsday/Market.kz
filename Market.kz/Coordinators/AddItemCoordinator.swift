//
//  AddItemCoordinator.swift
//  Market.kz
//
//  Created by admin on 5/3/21.
//

import Foundation
import UIKit
class AddItemCoordinator: Coordinator {
    var navigationViewController: UINavigationController?
    var name : String?
    var category : AdsTypeResponse?
    var description : String?
    var price : String?
    var wasInUse : Bool?
    var images : [UIImage]?
    var address : String?
    var city : String?

    func eventOccured(with type: Event) {
        
        switch type {
        case .confirmNameButtonTapped(let name):
            var vc : UIViewController & Coordinating = SelectCategoryViewController()
            vc.coordinator = self
            self.name = name
            navigationViewController?.pushViewController(vc, animated: true)
            
        case .confirmCategory(let category):
            var vc : UIViewController & Coordinating = SelectSecondaryInfoViewController()
            vc.coordinator = self
            self.category = category
            navigationViewController?.pushViewController(vc, animated: true)
            
        case .confirmSecondaryInfo(let secondaryInfoViewModel):
            var vc : UIViewController & Coordinating = SelectImagesViewController()
            vc.coordinator = self
        self.description = secondaryInfoViewModel.description
        self.price = secondaryInfoViewModel.price
        self.wasInUse = secondaryInfoViewModel.wasInUse
            navigationViewController?.pushViewController(vc, animated: true)
            
        case .confirmImagesSelected(let images):
            var vc : UIViewController & Coordinating = SelectAddressCollectionViewCell()
            vc.coordinator = self
        self.images = images
            
            navigationViewController?.pushViewController(vc, animated: true)
            
        case .confirmAddress(let address):
            
            self.city = address.city
            self.address = address.address
            
            let ads = Ads(name: self.name!, price: self.price!, images: self.images!, city: self.city!, address: self.address!, wasInUse: self.wasInUse!, description: self.description!, category: self.category!)
            
            var vc : UIViewController & Coordinating = ItemPreviewViewController(item : ads)
                vc.coordinator = self
       
             navigationViewController?.pushViewController(vc, animated: true)
        }
        
        
        
        
        
        
        
    }
    
    func start() {
        var vc : UIViewController & Coordinating = AddPostViewController()
        vc.coordinator = self
        navigationViewController?.setViewControllers([vc], animated: false)
    }
    
    
}
