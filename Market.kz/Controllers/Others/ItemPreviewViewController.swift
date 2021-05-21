//
//  ItemPreviewViewController.swift
//  Market.kz
//
//  Created by admin on 5/5/21.
//

import UIKit

class ItemPreviewViewController: UITableViewController , Coordinating {
    var coordinator: Coordinator?
    
    let confirmButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Выложить обьявление", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.9)

        btn.layer.cornerRadius = 5
        return btn
    }()
    
    
    let item : Ads?
    
    init(item : Ads){
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
        
  
        
        APICaller.shared.uploadAds(name: item!.name, address: item!.address, city: item!.city, description: item!.description, price: item!.price, wasInUse: item!.wasInUse, category: item!.category, userId: UserDefaults.standard.string(forKey: "current_user_id")!, completion: { result in

            switch result{
            case .failure(let error):
                
                print(error.localizedDescription)
            case .success(let id):
                for (i,image) in self.item!.images.enumerated(){
                    APICaller.shared.uploadImage(paramName: "file", fileName: "itemName.png", image: image, adsId: id + String(i))
                    }
            }
                
            
           

        })
        NotificationCenter.default.post(name: .updateAds, object: nil)
        dismiss(animated: true, completion: {
            
        })
        

    
    }

        
        
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        confirmButton.frame  = CGRect(x: view.width *  0.02, y: view.height * 0.8, width: view.width * 0.96, height: 60)
        
    }
    
  
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemDetailsHeaderTableViewCell.identifier) as? ItemDetailsHeaderTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: item!)
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
