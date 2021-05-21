//
//  UsersAdsDetailsViewController.swift
//  Market.kz
//
//  Created by admin on 5/21/21.
//

import UIKit

class UsersAdsDetailsViewController: UITableViewController {
    

       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
        
           guard self.navigationController?.topViewController === self else { return }
           self.transitionCoordinator?.animate(alongsideTransition: { [weak self](context) in
               self?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
               self?.navigationController?.navigationBar.shadowImage = UIImage()
               self?.navigationController?.navigationBar.backgroundColor = .clear
               self?.navigationController?.navigationBar.barTintColor = .clear
           }, completion: nil)
           
       }
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)

           self.transitionCoordinator?.animate(alongsideTransition: { [weak self](context) in
               self?.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
               self?.navigationController?.navigationBar.shadowImage = nil
               self?.navigationController?.navigationBar.backgroundColor = .white
               self?.navigationController?.navigationBar.barTintColor = .white
               }, completion: nil)
       }
       
       let confirmButton : UIButton = {
           let btn = UIButton()
           btn.setTitle("Удалить", for: .normal)
           btn.setTitleColor(.white, for: .normal)
           btn.backgroundColor = UIColor.systemRed

           btn.layer.cornerRadius = 5
           return btn
       }()
       
       
       let item : AdsWithId?
       
       init(item : AdsWithId){
           self.item = item
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       
       override func viewDidLoad() {
           super.viewDidLoad()

           title = "Your Ad Preview"
           
           tableView.register(ItemDetailsHeaderTableViewCell.self, forCellReuseIdentifier: ItemDetailsHeaderTableViewCell.identifier)
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
           tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
           
           view.addSubview(confirmButton)
           confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
       }

       @objc func  confirmButtonTapped(){
           
     
        APICaller.shared.deleteAd(adsId: item!.id, completion: {result in
            
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
              
            print(result)
                
    
            
            }
            
        })
        switchRootViewController(rootViewController: TabBarViewController(), animated: true, completion: nil)
       
       }

           
           
       
       
       override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           
        confirmButton.frame  = CGRect(x: view.width *  0.02, y: view.height * 0.7, width: view.width * 0.96, height: 60)
           
       }
       
     
    

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
           return 4
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           if indexPath.row == 0{
           guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemDetailsHeaderTableViewCell.identifier) as? ItemDetailsHeaderTableViewCell else {
               return UITableViewCell()
           }
           
            let neededItem = Ads(name: item!.name, price: item!.price, images: item!.images, city: item!.city, address: item!.address, wasInUse: item!.wasInUse, description: item!.description, category: item!.category)
            
           cell.configure(with: neededItem)
           cell.selectionStyle = .none
           cell.contentView.isUserInteractionEnabled = false;
           return cell
           }
           else if indexPath.row == 1{
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
               cell.textLabel?.text = UserDefaults.standard.string(forKey: "current_user_email")
               cell.selectionStyle = .none
               return cell
           }
           else if indexPath.row == 2{
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
               cell.textLabel?.text = item!.city + ", " + item!.address
               cell.selectionStyle = .none
               return cell
           }
           else if indexPath.row == 3{
               guard let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier) as? DescriptionTableViewCell else {
                   return UITableViewCell()
               }
               
               cell.configure(with: item!.description)
               cell.selectionStyle = .none

               return cell
           }
           else{
               return UITableViewCell()
           }
       }
       override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

           if indexPath.row == 0{
               return view.height * 0.45
           }
           else if indexPath.row == 3{
               return view.height * 0.15
           }
       
           else{
               return 40
           }
         
       }



   }



