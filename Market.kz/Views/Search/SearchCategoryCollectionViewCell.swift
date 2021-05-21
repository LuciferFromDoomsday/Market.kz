//
//  SearchCategoryCollectionReusableView.swift
//  Market.kz
//
//  Created by admin on 4/8/21.
//

import UIKit
import SDWebImage

class SearchCategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchCategoryCollectionViewCell"
      
      private lazy var imageView : UIImageView = {
          let iv = UIImageView()
         

          return iv
      }()
      
      private var titleLabel : UILabel = {
          let label = UILabel()
          label.font = UIFont.boldSystemFont(ofSize: 12)
          label.numberOfLines = 2
          label.textColor = .black
        
        label.textAlignment = .center
          
          return label
      }()
      

      
      
      
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          setup()
      }
      
      
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      private func setup(){
        
          addSubview(imageView)
          addSubview(titleLabel)

      }
      
      override func layoutSubviews() {
          super.layoutSubviews()
          
      
        imageView.frame = CGRect(x: width * 0.25, y: 15, width: width * 0.5, height: height * 0.45)
       
          titleLabel.frame = CGRect(x: 5, y: imageView.bottom , width: width - 10, height: 35)
  
          
      }
      override func prepareForReuse() {
          super.prepareForReuse()
          
          titleLabel.text = nil
         
         imageView.image = nil
          
          
      }
      
      public func configure(with viewModel : AdsTypeResponse){
          titleLabel.text = viewModel.name
        
         
        imageView.sd_setImage(with: URL(string: viewModel.imageUrl!)!, completed: nil)
      }
      
}
