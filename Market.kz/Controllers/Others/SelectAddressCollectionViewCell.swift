//
//  SelectAddressCollectionViewCell.swift
//  Market.kz
//
//  Created by admin on 5/5/21.
//

import UIKit
import McPicker

class SelectAddressCollectionViewCell: UIViewController , Coordinating {
    var coordinator: Coordinator?
    
    

    let imageView : UIImageView = {
        let img = UIImageView()
        
        img.image = UIImage(named: "add")!
        img.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        return img
    }()
    
    private let mainLabel : UILabel = {
        let label = UILabel()
        label.text = "Укажите ваше местоположение"
        label.font = .boldSystemFont(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let cityTextField : UITextField = {
        let textField = UITextField()
        
        textField.placeholder  = "Название Города или области и тд"
        
        textField.setLeftPaddingPoints(15)
        
        textField.layer.borderWidth = 0.5
        
        textField.layer.borderColor = UIColor.gray.cgColor
        
        
        return textField
    }()
    private let addressLabel : UILabel = {
        let label = UILabel()
        label.text = "Укажите ваш адресс"
        label.font = .boldSystemFont(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let addressTextField : UITextField = {
        let textField = UITextField()
        
        textField.placeholder  = "Не более 70 знаков"
        
        textField.setLeftPaddingPoints(15)
        
        textField.layer.borderWidth = 0.5
        
        textField.layer.borderColor = UIColor.gray.cgColor
        
        
        return textField
    }()
    
    
    let confirmButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Посмотреть обьявление", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.4)
        btn.isEnabled = false
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Новое обьявление"
        navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 221/255, blue: 97/255, alpha: 1)
        
        view.backgroundColor = .systemBackground
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
  
        setup()
        setupNavBarButtons()
    }
    
    private func setupNavBarButtons(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .done, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc  func cancelButtonTapped(){
        dismiss(animated: true, completion: {
            
        })
    }
    
    private func setup(){
        
        cityTextField.delegate = self
        addressTextField.delegate = self
        view.addSubview(mainLabel)
        view.addSubview(cityTextField)
        view.addSubview(addressLabel)
        view.addSubview(addressTextField)
        view.addSubview(confirmButton)
        
        cityTextField.addTarget(self, action: #selector(validateTextfields), for: .editingChanged)
        addressTextField.addTarget(self, action: #selector(validateTextfields), for: .editingChanged)
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
    }
    @objc func validateTextfields(sender: UITextField){
      
        if  cityTextField.text!.count > 5 && addressTextField.text!.count > 10 {
            
            self.confirmButton.isEnabled = true
            self.confirmButton.backgroundColor = UIColor.systemBlue
            
        }
        else{
            self.confirmButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.4)
            self.confirmButton.isEnabled = false
        }
        
        
    }
    
    @objc func confirmButtonPressed(){
        
        coordinator?.eventOccured(with: .confirmAddress(address: ItemAddressViewModel(address: addressTextField.text!, city: cityTextField.text!)))
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        mainLabel.frame = CGRect(x: 20, y: (navigationController?.navigationBar.bottom)! + 2, width: view.width * 0.6, height: view.height * 0.03)
        cityTextField.frame = CGRect(x: 20, y: mainLabel.bottom + 10, width: view.width * 0.9, height: view.height * 0.05)
        
        addressLabel.frame = CGRect(x: 20, y: cityTextField.bottom + 10, width: view.width * 0.9, height: view.height * 0.05
        )
        addressTextField.frame = CGRect(x: 20, y: addressLabel.bottom + 5, width: view.width * 0.9, height: view.height * 0.05)
        confirmButton.frame = CGRect(x: view.width *  0.02, y: view.height * 0.8, width: view.width * 0.96, height: 60)
        
    }
}
    


extension SelectAddressCollectionViewCell : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == cityTextField{
        
            var cities = [String]()
       
                cities = [
                    "Алматы",
                    "Астана",
                    "Талдыкорган",
                    "Тараз",
                    "Актобе",
                    "Шымкент",
                    "Атырау",
                    "Актау",
                    "усть-каменогорск",
                    "Жезказган",
                    "Уральск",
                    "Петропавл",
                    "Павлодар",
                    "Семей",
                    "Кокшетау",
                    "Костанай"
              ]
       
          
            McPicker.show(data: [cities]) {  [weak self] (selections: [Int : String]) -> Void in
                if let name = selections[0] {
                    self?.cityTextField.text = name
                }
            }
        }
 
        
       
    }
    
   
    
}

