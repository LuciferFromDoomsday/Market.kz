//
//  ItemCollectionReusableView.swift
//  Market.kz
//
//  Created by admin on 4/8/21.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "temCollectionViewCell"
      
      private lazy var imageView : UIImageView = {
          let iv = UIImageView()
        iv.layer.cornerRadius = 15
        iv.contentMode = .scaleToFill

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
          label.font = UIFont.boldSystemFont(ofSize: 14)
          label.numberOfLines = 1
        label.textColor = .black
          
          
          return label
      }()
    
    private var locationLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
      label.textColor = .gray
        
        
        return label
    }()
    
    private var dateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
      label.textColor = .gray
        
        
        return label
    }()
      
      
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          setup()
        self.layer.cornerRadius = 5
      }
      
    private var favoriteButton : UIButton = {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        
        btn.tintColor = .white
        
        return btn
    }()
      
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      private func setup(){
        
          addSubview(imageView)
          addSubview(titleLabel)
addSubview(favoriteButton)
          addSubview(priceLabel)
        addSubview(locationLabel)
        addSubview(dateLabel)
      }
      
      override func layoutSubviews() {
          super.layoutSubviews()
          
      
          imageView.frame = CGRect(x: 0, y: 0, width: width , height: height * 0.5)
        favoriteButton.frame = CGRect(x : width * 0.8 , y : 5 , width: 30 , height: 30)
          titleLabel.frame = CGRect(x: 10, y: imageView.bottom , width: width - 10, height: 35)
          priceLabel.frame = CGRect(x: 10, y: titleLabel.bottom - 5 , width: width - 10, height: 20)
        locationLabel.frame = CGRect(x: 10, y: priceLabel.bottom + 5 , width: width - 10, height: 20)
        dateLabel.frame =  CGRect(x: 10, y: locationLabel.bottom  , width: width - 10, height: 20)
          
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
        locationLabel.text = viewModel.city + ", " + viewModel.adress
        dateLabel.text = viewModel.addedDate 
      APICaller.shared.getAdsImages(adsId: String(viewModel.id), completion: {
          result in
          
          switch result{
          case .failure(let error):
              print(error.localizedDescription)
              self.imageView.image = UIImage(named: "marketkz")
          case .success(let images):
              self.imageView.sd_setImage(with: URL(string: "http://localhost:8080/api/market/viewAdsPictures/" + images.first!.url), completed: nil)
            print("http://localhost:8080/api/market/viewAdsPictures/" + images.first!.url)
          }
          
      })
      
    }
      
     
      
}
