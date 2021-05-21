//
//  AddImageCollectionViewCell.swift
//  Market.kz
//
//  Created by admin on 5/5/21.
//

import UIKit

protocol AddImageCollectionViewCellDelegate : AnyObject {
    func deleteImageButtonTapped(_ cell : AddImageCollectionViewCell )
}

class AddImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "AddImageCollectionViewCell"
      
    weak var delegate : AddImageCollectionViewCellDelegate?
    
    
      private lazy var imageView : UIImageView = {
          let iv = UIImageView()
        iv.layer.cornerRadius = 10

          return iv
      }()
      

    private let deleteButton : UIButton = {
        let btn = UIButton()
        
        btn.setImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageView?.tintColor = .gray
        btn.backgroundColor = .white
        
        return btn
    }()
      
      
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          setup()
        self.layer.cornerRadius = 10
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

      
      private func setup(){
        
          addSubview(imageView)
        addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteImageButtonTapped), for: .touchUpInside)
      }
    
    @objc func deleteImageButtonTapped(){
        print("7: 0 ez UFC")
        delegate?.deleteImageButtonTapped(self)
    }
      
      override func layoutSubviews() {
          super.layoutSubviews()
          
      
          imageView.frame = CGRect(x: 0, y: 0, width: width , height: height)
       
        deleteButton.frame = CGRect(x: width * 0.9, y: 0, width: width * 0.15, height: width * 0.15)
          
      }
      override func prepareForReuse() {
          super.prepareForReuse()
          
          
         imageView.image = nil
          
          
      }
      
      public func configure(with viewModel : UIImage){

        imageView.image = viewModel
      }
      
     
}
