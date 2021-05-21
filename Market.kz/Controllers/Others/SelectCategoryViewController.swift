//
//  SelectCategoryViewController.swift
//  Market.kz
//
//  Created by admin on 5/3/21.
//

import UIKit
import SDWebImage

class SelectCategoryViewController: UIViewController , Coordinating {
    var coordinator: Coordinator?
    

    
    
    private let mainLabel : UILabel = {
        let label = UILabel()
        label.text = "Выберите Категорию"
        label.font = .boldSystemFont(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    

    
    var categories : [AdsTypeResponse] = [AdsTypeResponse]()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        
        tableView.rowHeight = 60
        
        tableView.separatorStyle = .singleLine
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .done, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
        fetchData()
       setup()
    }
    @objc  func cancelButtonTapped(){
        dismiss(animated: true, completion: {
            
        })
    }
    
    private func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(mainLabel)
        view.addSubview(tableView)

    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainLabel.frame = CGRect(x: 20, y: (navigationController?.navigationBar.bottom)! + 10, width: view.width * 0.6, height: view.height * 0.03)
        tableView.frame = CGRect(x: view.width * 0.03, y: mainLabel.bottom + 20, width: view.width * 0.94, height: view.height * 0.9)
       
    }


    func fetchData(){
        
        let group = DispatchGroup()
        
         group.enter()
        
        var categories : [AdsTypeResponse]? = [AdsTypeResponse]()
        
        
        APICaller.shared.getAdsTypes(completion: {  result in
           defer {
       
                group.leave()
            }
            
            switch result {
            case .failure(let error):
                
                print(error.localizedDescription)
                
            case .success(let fetchedCategories):
                
               categories = fetchedCategories
                print(categories!)
                
            }
            
            
        })
        
        group.notify(queue: .main){
            guard let adsCategories = categories
            else {

                fatalError("Models are nill")
            }
           
            self.configureModels(categories: adsCategories )
        }
        
        
    }
    
    private func configureModels(categories : [AdsTypeResponse]){
        self.categories = categories
        print("categories \(categories)")
        
        tableView.reloadData()
    }
    

}




extension SelectCategoryViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.imageView?.sd_setImage(with: URL(string: categories[indexPath.row].imageUrl ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2ZC2TDN6frdzhqpZQgz36xZyBiYq14hL2AA&usqp=CAU"), completed: nil)
        
        cell?.imageView?.contentMode = .redraw
        cell?.accessoryType = .disclosureIndicator
        cell?.imageView!.clipsToBounds = true
        cell?.textLabel?.text = categories[indexPath.row].name
        cell?.imageView?.frame = CGRect(x: 10,y: 0,width: 40,height: 40)
        cell?.imageView?.contentMode = .scaleAspectFit
        cell?.selectionStyle = .none
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.eventOccured(with: .confirmCategory(category: categories[indexPath.row]))
    }
    
    
}
