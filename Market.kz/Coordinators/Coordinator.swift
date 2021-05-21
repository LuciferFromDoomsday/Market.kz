//
//  Coordinator.swift
//  Market.kz
//
//  Created by admin on 5/3/21.
//

import Foundation
import UIKit

enum Event {
    case confirmNameButtonTapped(itemName : String)
    case confirmCategory(category : AdsTypeResponse)
    case confirmSecondaryInfo(secondaryInfo : ItemSecondaryInfoViewModel)
    case confirmImagesSelected(images : [UIImage])
    case confirmAddress(address : ItemAddressViewModel)
}

protocol Coordinator {
    var navigationViewController: UINavigationController? {get  set}
    //var children : [Coordinator]? {get set}
    
    func eventOccured(with type : Event)
    func start()
    
    
}

protocol Coordinating {
    var coordinator : Coordinator? {get set}
    
}
