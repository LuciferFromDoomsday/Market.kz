//
//  ItemDetailsHeaderTableViewCell.swift
//  Market.kz
//
//  Created by admin on 5/5/21.
//

import UIKit

class ItemDetailsHeaderTableViewCell: UITableViewCell {

    static let identifier = "ItemDetailsHeaderTableViewCell"
        
    var scrollView = UIScrollView()
    
    private var images = [UIImage()]
    

    
    
    var pageControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .red
  
        return pageControl
    }()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    var priceLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    func resizeImageWithAspect(image: UIImage,scaledToMaxWidth width:CGFloat,maxHeight height :CGFloat)->UIImage? {
        let oldWidth = image.size.width;
        let oldHeight = image.size.height;
        
        let scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight;
        
        let newHeight = oldHeight * scaleFactor;
        let newWidth = oldWidth * scaleFactor;
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize,false,UIScreen.main.scale);
        
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height));
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage
    }
    
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            backgroundColor = .white
            pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
            addSubview(scrollView)
            scrollView.delegate = self
            addSubview(pageControl)
            addSubview(titleLabel)
            addSubview(priceLabel)
              
        }
    
  
    
    @objc func pageControlDidChange(_ sender : UIPageControl){
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: current * Int(width), y: 0) ,animated: true)
    }
        
 
    
        required init?(coder: NSCoder) {
            fatalError()
        }
        override func layoutSubviews() {
            super.layoutSubviews()
          
            scrollView.frame = CGRect(x: 0, y: 0, width: width, height: height * 0.8)
            pageControl.frame = CGRect(x: 10, y: scrollView.bottom + 5, width: width , height: height * 0.05)
            
            priceLabel.frame = CGRect(x: 10, y: pageControl.bottom , width: width * 0.5, height: height * 0.05)
            priceLabel.font = .boldSystemFont(ofSize: height * 0.05)
            
            titleLabel.frame = CGRect(x: 10, y: priceLabel.bottom + 5, width: width * 0.8, height: height * 0.05)
            
        
   
            if scrollView.subviews.count == 2{
                configureScrollView()
            }
        }
    
    private func configureScrollView(){
        print( width * CGFloat(images.count))
        print(width)
        scrollView.contentSize = CGSize(width: width * CGFloat(images.count), height: scrollView.height)
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
       
        for i in 0..<images.count {
            let imageView = UIImageView(frame: CGRect(x: width * CGFloat(i), y: 0, width: width, height: scrollView.height))
            imageView.contentMode  = .scaleToFill
            
            imageView.image =  images[i]
            
            scrollView.addSubview(imageView)
            
        }
    }
        
     
        func configure(with viewModel : Ads){
            pageControl.numberOfPages = (viewModel.images.count)
            images = viewModel.images
            titleLabel.text = viewModel.name
            priceLabel.text = viewModel.price + " KZT"
           
        }

}

extension ItemDetailsHeaderTableViewCell : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.width)))
    }
}

