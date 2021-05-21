//
//  FilterSearchViewController.swift
//  Market.kz
//
//  Created by admin on 4/7/21.
//

import UIKit

class FilterSearchViewController: UIViewController, UISearchBarDelegate {
    // SearchView items
    private  let searchfiledView : UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Поиск Обьявлении"
       bar.searchTextField.borderStyle = .line
        return bar

    }()
    
    private let searchLabel : UILabel = {
        let label = UILabel()
        
        label.text = "Поиск по тексту"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    //CategoryView items
    
    private  let categoriesView : UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    private  let categoriesLabel : UILabel = {
        let label = UILabel()
        
        label.text = "Категория"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
  private  let categoryName : UILabel = {
        
        let label = UILabel()
        
        label.text = "Все"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemBlue
        return label
        
    }()
    private let chevronImageView : UIImageView = {
        let image = UIImageView()
        image.image =  UIImage(systemName : "chevron.right")
        image.contentMode = .scaleAspectFill
        image.tintColor = .systemBlue
        return image
    }()
    
    // RegionView items
    private  let regionsView : UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    private  let regionsLabel : UILabel = {
        let label = UILabel()
        
        label.text = "Выбрать Регион"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
  private  let regionsName : UILabel = {
        
        let label = UILabel()
        
        label.text = "Весь Казахстан"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemBlue
        return label
        
    }()
    private let regionsChevronImageView : UIImageView = {
        let image = UIImageView()
        image.image =  UIImage(systemName : "chevron.right")
        image.contentMode = .scaleAspectFill
        image.tintColor = .systemBlue
        return image
    }()
    
    //PriceView items
    private  let priceView : UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private  let priceLabel : UILabel = {
        let label = UILabel()
        
        label.text = "Цена"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    private let fromPriceTextfield : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "От"
        textfield.layer.borderWidth = 0.5
        return textfield
    }()
    private let toPriceTextfield : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "До"
        textfield.layer.borderWidth = 0.5
        return textfield
    }()
    private  let deviderLabel : UILabel = {
        let label = UILabel()
        
        label.text = "-"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        configureSearchView()
        configureCategoryView()
        configureRegionView()
        configurePriceView()
    }
    func setUpNavBar() {
       title = "Filter"
        view.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark" ), style: .done, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func configureSearchView(){
        view.addSubview(searchfiledView)
        
        searchfiledView.addSubview(searchBar)
        searchfiledView.addSubview(searchLabel)
        
    }
    
    func configureCategoryView()  {
        view.addSubview(categoriesView)
        
        categoriesView.addSubview(categoriesLabel)
        categoriesView.addSubview(categoryName)
        categoriesView.addSubview(chevronImageView)
    }
    
    func configureRegionView()  {
        view.addSubview(regionsView)
        
        regionsView.addSubview(regionsLabel)
        regionsView.addSubview(regionsName)
        regionsView.addSubview(regionsChevronImageView)
    }
    
    func configurePriceView()  {
        view.addSubview(priceView)
        
        priceView.addSubview(priceLabel)
        priceView.addSubview(fromPriceTextfield)
        priceView.addSubview(toPriceTextfield)
        priceView.addSubview(deviderLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //SearchView
        searchfiledView.frame = CGRect(x: 0, y: 120, width: view.width, height: 80)
        
        searchLabel.frame = CGRect(x: 15, y: 5, width: view.width * 0.5, height: 15)
        searchBar.frame = CGRect(x: 10, y: searchLabel.bottom + 10, width: view.width - 40, height: 40)
        
        //CategoryView
        categoriesView.frame = CGRect(x: 0, y: searchfiledView.bottom + 10, width: view.width, height: 60)
        categoriesLabel.frame = CGRect(x: 15, y: 5, width: view.width * 0.5, height: 15)
        categoryName.frame = CGRect(x: 15, y: categoriesLabel.bottom + 10, width: view.width * 0.75, height: 20)
        chevronImageView.frame = CGRect(x: view.width * 0.9, y: categoriesLabel.bottom + 10, width: 10, height: 10)
        //RegionView
        regionsView.frame = CGRect(x: 0, y: categoriesView.bottom + 10, width: view.width, height: 60)
        regionsLabel.frame = CGRect(x: 15, y: 5, width: view.width * 0.5, height: 15)
        regionsName.frame = CGRect(x: 15, y: regionsLabel.bottom + 10, width: view.width * 0.75, height: 20)
        regionsChevronImageView.frame = CGRect(x: view.width * 0.9, y: regionsLabel.bottom + 10, width: 10, height: 10)
        //PriceView
        priceView.frame = CGRect(x: 0, y: regionsView.bottom + 10, width: view.width, height: 60)
        priceLabel.frame = CGRect(x: 15, y: 5, width: view.width * 0.5, height: 15)
        fromPriceTextfield.frame = CGRect(x: 15, y: regionsLabel.bottom + 10, width: view.width * 0.4, height: 25)
        deviderLabel.frame = CGRect(x: fromPriceTextfield.right + 5, y: regionsLabel.bottom + 10, width: 15, height: 20)
        toPriceTextfield.frame = CGRect(x: deviderLabel.right + 3, y: regionsLabel.bottom + 10, width: view.width * 0.4, height: 25)
    }
    
    
    @objc func closeButtonTapped(){
        switchRootViewController(rootViewController: TabBarViewController(), animated: false, completion: nil)
    }
  
}
