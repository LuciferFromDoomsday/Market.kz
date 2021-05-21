//
//  SearchedItemCollectionReusableView.swift
//  Market.kz
//
//  Created by admin on 4/8/21.
//

import UIKit
import SDWebImage

class SearchedItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "ItemWithPriceCollectionViewCell"
      
      private lazy var imageView : UIImageView = {
          let iv = UIImageView()
         

          return iv
      }()
      
      private var titleLabel : UILabel = {
          let label = UILabel()
          label.font = UIFont.boldSystemFont(ofSize: 16)
          label.numberOfLines = 1
          label.textColor = .black
          
          
          return label
      }()
      

      
      private var priceLabel : UILabel = {
          let label = UILabel()
          label.font = UIFont.boldSystemFont(ofSize: 12)
          label.numberOfLines = 1
        label.textColor = .black
          
          
          return label
      }()
      
      
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          setup()
        self.layer.cornerRadius = 6
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

      
      private func setup(){
        
          addSubview(imageView)
          addSubview(titleLabel)

          addSubview(priceLabel)
      }
      
      override func layoutSubviews() {
          super.layoutSubviews()
          
      
          imageView.frame = CGRect(x: 0, y: 0, width: width , height: height * 0.6)
       
          titleLabel.frame = CGRect(x: 10, y: imageView.bottom , width: width - 30, height: 35)
          priceLabel.frame = CGRect(x: 10, y: titleLabel.bottom - 5 , width: width, height: 20)
          
      }
      override func prepareForReuse() {
          super.prepareForReuse()
          
          titleLabel.text = nil
          priceLabel.text = nil
         imageView.image = nil
          
          
      }
      
      public func configure(with viewModel : AdsResponse){
        titleLabel.text = viewModel.name
        priceLabel.text = String(viewModel.price)
        
        APICaller.shared.getAdsImages(adsId: String(viewModel.id), completion: {
            result in
            
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
                self.imageView.image = UIImage(named: "marketkz")
            case .success(let images):
                self.imageView.sd_setImage(with: URL(string: "http://localhost:8080/api/market/viewAdsPictures/" + images.first!.url), completed: nil)
            }
            
        })
        
      }
      
     
      
      
}
