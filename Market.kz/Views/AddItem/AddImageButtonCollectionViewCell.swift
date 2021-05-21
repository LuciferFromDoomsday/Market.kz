//
//  AddImageButtonCollectionViewCell.swift
//  Market.kz
//
//  Created by admin on 5/5/21.
//

import UIKit


protocol AddImageButtonCollectionViewCellDelegate : AnyObject {
    func addImageButtonPressed()
}

class AddImageButtonCollectionViewCell: UICollectionViewCell {
    static let identifier = "AddImageButtonCollectionViewCell"
      
    weak var delegate : AddImageButtonCollectionViewCellDelegate?

    private let addButton : UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Добавить Фотографию", for: .normal)
        btn.setTitleColor(UIColor.systemBlue.withAlphaComponent(0.8), for: .normal)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.numberOfLines = 2
        return btn
    }()
      
      
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          setup()
        self.addDashedBorder()
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

      
      private func setup(){
        
        
        addSubview(addButton)
        addButton.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
      }
    
    @objc func addImageButtonTapped(){
        delegate?.addImageButtonPressed()
    }
      
      override func layoutSubviews() {
          super.layoutSubviews()
          
      
        
        addButton.frame = bounds
          
      }
    

      
     
}

