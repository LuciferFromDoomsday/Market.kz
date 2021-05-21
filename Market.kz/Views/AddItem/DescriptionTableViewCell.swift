//
//  DescriptionTableViewCell.swift
//  Market.kz
//
//  Created by admin on 5/6/21.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    static let identifier = "DescriptionTableViewCell"
        
 
   
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Описание"
        label.textColor = .black
        return label
    }()
    
    var descriptionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = .max
        label.textColor = .black
        return label
    }()
    
   
    
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            backgroundColor = .white

            addSubview(titleLabel)
            addSubview(descriptionLabel)
              
        }
    
  

        
 
    
        required init?(coder: NSCoder) {
            fatalError()
        }
        override func layoutSubviews() {
            super.layoutSubviews()
          
      
            titleLabel.frame = CGRect(x: 10, y: 5  , width: width * 0.5, height: height * 0.35)
          
            descriptionLabel.frame = CGRect(x: 10, y: titleLabel.bottom + height * 0.05, width: width * 0.95, height: height * 0.5)
            
        
   
        
        }
    
  
        
     
        func configure(with viewModel : String){

            descriptionLabel.text = viewModel
 
           
        }

}
