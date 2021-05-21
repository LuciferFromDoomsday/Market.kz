//
//  ViewController.swift
//  Market.kz
//
//  Created by admin on 4/3/21.
//

import UIKit
import SDWebImage


enum SeachSectionType{
    case categories(viewModels : [AdsTypeResponse])
    case searchedItems(viewModels : [AdsResponse])
    case items(viewModels : [AdsResponse])
    
    mutating  func updateItems(items : [AdsResponse]){
    switch self {
    case .items(var viewModels):
        viewModels = items
    default:
        return
    }
        
    }
}

class SearchViewController: UIViewController , UISearchBarDelegate {
    
    
    private var sections = [SeachSectionType]()
    
    private var collectionView : UICollectionView = UICollectionView(frame : .zero , collectionViewLayout : UICollectionViewCompositionalLayout{ sectionIndex, _ -> NSCollectionLayoutSection in
        let layout = SearchViewController.createSectionLayout(section: sectionIndex)
        return layout
    })
    
    let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(updateAds), name: .updateAds , object: nil)
        
        setUpNavBar()
        configureCollectionView()
        fetchData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
        collectionView.reloadData()
        
    }
    
    @objc func updateAds(){
        self.sections.removeAll()
        fetchData()
        
    }
    
    func setUpNavBar() {
        searchBar.delegate = self
      
        navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 221/255, blue: 97/255, alpha: 1)
        searchBar.sizeToFit()
        
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Поиск обьявлении "
        searchBar.tintColor = UIColor.lightGray
        searchBar.barTintColor = UIColor.lightGray
        navigationItem.titleView = searchBar
        searchBar.isTranslucent = true
        searchBar.searchTextField.borderStyle = .line
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.layer.borderWidth = 0.1
        searchBar.searchTextField.layer.borderColor = UIColor.gray.cgColor
        
    }
    
    private func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(SearchCategoryCollectionViewCell.self , forCellWithReuseIdentifier : SearchCategoryCollectionViewCell.identifier)
        collectionView.register(SearchedItemCollectionViewCell.self , forCellWithReuseIdentifier: SearchedItemCollectionViewCell.identifier)
        collectionView.register( ItemCollectionViewCell.self , forCellWithReuseIdentifier:  ItemCollectionViewCell.identifier)
       
        collectionView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        view.addSubview(collectionView)
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    
        navigationController?.pushViewController(FilterSearchViewController(), animated: true)
    }
  
    

}

extension SearchViewController : UICollectionViewDelegate , UICollectionViewDataSource{

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        
        switch type {
        case .categories(let viewModels):
            return viewModels.count
        
        case .searchedItems(let viewModels):
            return viewModels.count
        
        case .items(let viewModels):
            return viewModels.count
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type {
        case .categories(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier : SearchCategoryCollectionViewCell.identifier, for: indexPath) as? SearchCategoryCollectionViewCell else{
                return UICollectionViewCell()
            }
            
            cell.configure(with: viewModels[indexPath.row])
            cell.backgroundColor = .white
            return cell
            
        case .searchedItems(let viewModels):
           
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier :  SearchedItemCollectionViewCell.identifier, for: indexPath) as?  SearchedItemCollectionViewCell else{
                return UICollectionViewCell()
            }
            
            cell.configure(with: viewModels[indexPath.row])
            cell.backgroundColor = .white
            return cell
        case .items(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier :   ItemCollectionViewCell.identifier, for: indexPath) as?   ItemCollectionViewCell else{
                return UICollectionViewCell()
            }
            
            cell.configure(with: viewModels[indexPath.row])
            cell.backgroundColor = .white
            return cell
           
      
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = sections[indexPath.section]
        switch type {
        case .categories(let viewModels):
            
            var ads : [AdsResponse]? = [AdsResponse]()
            
            let group = DispatchGroup()
            
             group.enter()
            
            APICaller.shared.getAllAdsByAdsType(adsTypeIId: String(viewModels[indexPath.row].id!), completion: { result in
                    
                    defer {
               
                        group.leave()
                    }
                    
                    switch result {
                    case .failure(let error):
                        
                        print(error.localizedDescription)
                        
                    case .success(let fetchedAds):
                        
                      ads  = fetchedAds
                        
                        
                    }
            })
            
            group.notify(queue: .main){
                guard let adsCategories = ads
                else {

                    fatalError("Models are nill")
                }
                
                self.sections.removeLast()
                self.sections.append(.items(viewModels: adsCategories))
                
                self.collectionView.reloadData()
                
            }
           
        case .searchedItems(let viewModels):
           
            let group = DispatchGroup()
            
             group.enter()
            
            var imagesAds : [UIImage] = []
            
            var responses : [ImageResponse] = []
            
            APICaller.shared.getAdsImages(adsId: String(viewModels[indexPath.row].id), completion: {
                result in
                defer {
           
                    group.leave()
                }
                
                switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let images):
                    print("----------------------------------------------")
                    print(images.count)
                    print("----------------------------------------------")
                    
                    responses.append(contentsOf: images.compactMap({
                        return $0
                    }))
                
                
                }
                
            })
            group.notify(queue: .main){
                responses.forEach({
         
                    let imageUrl = URL(string: "http://localhost:8080/api/market/viewAdsPictures/" + $0.url)!

                    let image = try? UIImage(withContentsOfUrl: imageUrl)
                    
                    imagesAds.append(image!)
                })
                self.navigationController?.pushViewController(AdsDetailViewController(item: Ads(name: viewModels[indexPath.row].name , price: String(viewModels[indexPath.row].price), images: imagesAds, city: viewModels[indexPath.row].city, address: viewModels[indexPath.row].adress, wasInUse: viewModels[indexPath.row].isNew, description: viewModels[indexPath.row].description, category: AdsTypeResponse(id: nil, imageUrl: nil, name: nil))), animated: true)
                
            }

            
       
            
          
        case .items(let viewModels):
            let group = DispatchGroup()
            
             group.enter()
            
            var imagesAds : [UIImage] = []
            
            var responses : [ImageResponse] = []
            
            APICaller.shared.getAdsImages(adsId: String(viewModels[indexPath.row].id), completion: {
                result in
                defer {
           
                    group.leave()
                }
                
                switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let images):
                    print("----------------------------------------------")
                    print(images.count)
                    print("----------------------------------------------")
                    
                    responses.append(contentsOf: images.compactMap({
                        return $0
                    }))
                
                
                }
                
            })
            group.notify(queue: .main){
                responses.forEach({
         
                    let imageUrl = URL(string: "http://localhost:8080/api/market/viewAdsPictures/" + $0.url)!

                    let image = try? UIImage(withContentsOfUrl: imageUrl)
                    
                    imagesAds.append(image!)
                })
                self.navigationController?.pushViewController(AdsDetailViewController(item: Ads(name: viewModels[indexPath.row].name , price: String(viewModels[indexPath.row].price), images: imagesAds, city: viewModels[indexPath.row].city, address: viewModels[indexPath.row].adress, wasInUse: viewModels[indexPath.row].isNew, description: viewModels[indexPath.row].description, category: AdsTypeResponse(id: nil, imageUrl: nil, name: nil))), animated: true)
                
            }
        }
        
    }
    
    static func createSectionLayout(section : Int) -> NSCollectionLayoutSection{
        
        let supplementaryView = [
              NSCollectionLayoutBoundarySupplementaryItem(layoutSize:
              NSCollectionLayoutSize(
                  widthDimension: .fractionalWidth(1),
                  heightDimension: .absolute(50)) ,
                  elementKind: UICollectionView.elementKindSectionHeader,
                  alignment: .top)
            
          ]
        
        switch section{
        case 0:
            let item = NSCollectionLayoutItem(layoutSize:
            NSCollectionLayoutSize(
                widthDimension: .absolute(100),
              heightDimension: .absolute(180))
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 1, bottom: 1, trailing: 1)
            
            // Vertical group in horizontall
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize:
                   NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(180)),
                    subitem: item ,
                    count: 2)
            
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize:
                   NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(170)),
                    subitem: verticalGroup ,
                    count: 1)
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
          section.orthogonalScrollingBehavior = .groupPaging
            
            return section
            
            
        case 1 :
            let item = NSCollectionLayoutItem(layoutSize:
            NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(170))
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize:
                   NSCollectionLayoutSize(
                    widthDimension: .absolute(250),
                    heightDimension: .absolute(190)),
                    subitem:    item ,
                    count: 2)
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
          section.boundarySupplementaryItems = supplementaryView
            return section
        case 2:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(195)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize:  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200)), subitem: item , count: 2)
            
         
           
            
            let section = NSCollectionLayoutSection(group: group)

           
            return section
        default :
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize:  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitem: item , count: 1)
            
           
            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
           
            return section
        
    }
    
    
        
    
    
}
    
    private func fetchData(){
        
       
        
        
        let group = DispatchGroup()
        
         group.enter()
        group.enter()
        
        var categories : [AdsTypeResponse]? = [AdsTypeResponse]()
        var ads : [AdsResponse]? = [AdsResponse]()
        
  
        APICaller.shared.getAdsTypes(completion: {  result in
            
            defer {
       
                group.leave()
            }
            
            switch result {
            case .failure(let error):
                
                print(error.localizedDescription)
                
            case .success(let fetchedCategories):
                
               categories = fetchedCategories
                
                
            }
        })
        
        APICaller.shared.getAllAds(completion: { result in 
            defer {
       
                group.leave()
                
            }
            
            switch result {
            case .failure(let error):
                
                print(error.localizedDescription)
                
            case .success(let fetchedAds):
                
               ads = fetchedAds
                
                
            }
        })
        group.notify(queue: .main){
            guard let adsCategories = categories , let Allads = ads
            else {

                fatalError("Models are nill")
            }
           
            self.configureModels(categories: adsCategories , ads : Allads)
        }
    }
        
    
    private func configureModels(categories : [AdsTypeResponse] , ads : [AdsResponse]){
        

        
        sections.append(.categories(viewModels: categories.compactMap({
            return $0
        })))
        sections.append(.searchedItems(viewModels: ads.compactMap({
            return $0
        })))
        sections.append(.items(viewModels: ads.compactMap({
            return $0
        })))
        collectionView.reloadData()
    }

}
