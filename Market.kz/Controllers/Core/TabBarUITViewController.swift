//
//  TabBarUITViewController.swift
//  Market.kz
//
//  Created by admin on 4/3/21.
//

import UIKit

class TabBarViewController: UITabBarController , UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = SearchViewController()
       let vc2 = FavoritesViewController()
        let vc3 = SearchViewController()
        let vc4 = MessagesViewController()
         let vc5 = CabinetViewController()
        
        self.tabBar.tintColor = .black
        self.delegate = self
       
        vc2.title = "Избранные"
        vc4.title = "Сообщения"
        vc4.title = "Кабинет"
        vc1.navigationItem.largeTitleDisplayMode = .never
        vc2.navigationItem.largeTitleDisplayMode = .never
        vc3.navigationItem.largeTitleDisplayMode = .never
        vc4.navigationItem.largeTitleDisplayMode = .never
        vc5.navigationItem.largeTitleDisplayMode = .never
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        let nav5 = UINavigationController(rootViewController: vc5)
        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
    
        nav1.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 1)
      
       
        nav1.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass")?.withTintColor(.black)
        nav2.tabBarItem = UITabBarItem(title: "Избранные", image: UIImage(systemName: "heart.fill"), tag: 2)

        
       
        
        nav3.tabBarItem = UITabBarItem(title: "Подать", image: UIImage(systemName: "plus.app.fill"), tag: 3)
      
  
       
        
        nav4.tabBarItem = UITabBarItem(title: "Сообщения", image: UIImage(systemName: "envelope"), tag: 4)
       
        nav5.tabBarItem = UITabBarItem(title: "Кабинет", image: UIImage(systemName: "person.circle"), tag: 5)
       
        nav1.navigationBar.prefersLargeTitles = false
        nav2.navigationBar.prefersLargeTitles = false
        nav3.navigationBar.prefersLargeTitles = false
        nav4.navigationBar.prefersLargeTitles = false
        nav5.navigationBar.prefersLargeTitles = false
        
  
        
       

 
        
        setViewControllers([nav1, nav2 , nav3 , nav4 , nav5], animated: false)
        
        if let items = self.tabBar.items {
           
            let button = items[2]
            button.image = button.image?.tabBarImageWithCustomTint(tintColor: UIColor.systemBlue)
            
            button.setTitleTextAttributes([NSAttributedString.Key.backgroundColor: UIColor.systemBlue], for:.normal)
            button.titleTextAttributes(for: .normal)

            
        }
        
    }
    
    // MARK: UITabbar Delegate

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == (self.tabBar.items!)[2]{
            
            if UserDefaults.standard.string(forKey: "access_token") != nil {
          
            
           let navVC = UINavigationController()
            navVC.modalPresentationStyle = .fullScreen
            let coordinator = AddItemCoordinator()
            coordinator.navigationViewController = navVC
            
            coordinator.start()
            
           
            
            present(navVC , animated: true, completion: {
                self.selectedIndex = 0
            })
        }
            else{
                let alert = UIAlertController(title: "Оппа..", message: "Похоже вы еще не вошли в систему , Попробуй пройти в кабинет и пройти авторизацию", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
       
    }
     


}
