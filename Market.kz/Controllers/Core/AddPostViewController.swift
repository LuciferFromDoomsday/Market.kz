//
//  AddPostViewController.swift
//  Market.kz
//
//  Created by admin on 4/8/21.
//

import UIKit

class AddPostViewController: UIViewController , Coordinating {
    var coordinator: Coordinator?
    
    

    let imageView : UIImageView = {
        let img = UIImageView()
        
        img.image = UIImage(named: "add")!
        img.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        return img
    }()
    
    private let mainLabel : UILabel = {
        let label = UILabel()
        label.text = "Придумайте Название"
        label.font = .boldSystemFont(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let nameTextField : UITextField = {
        let textField = UITextField()
        
        textField.placeholder  = "Название Товара или Услуги"
        
        textField.setLeftPaddingPoints(15)
        
        textField.layer.borderWidth = 0.5
        
        textField.layer.borderColor = UIColor.gray.cgColor
        
        
        return textField
    }()
    
    
    let confirmButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Продолжить", for: .normal)
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
        view.addSubview(mainLabel)
        view.addSubview(nameTextField)
        view.addSubview(confirmButton)
        nameTextField.addTarget(self, action: #selector(validateTextfields), for: .editingChanged)
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
    }
    @objc func validateTextfields(sender: UITextField){
      
        if  nameTextField.text!.count > 0 {
            
            self.confirmButton.isEnabled = true
            self.confirmButton.backgroundColor = UIColor.systemBlue
            
        }
        else{
            self.confirmButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.4)
            self.confirmButton.isEnabled = false
        }
        
        
    }
    
    @objc func confirmButtonPressed(){
        
        coordinator?.eventOccured(with: .confirmNameButtonTapped(itemName: nameTextField.text!))
        
       // navigationController?.pushViewController(SelectCategoryViewController(), animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        mainLabel.frame = CGRect(x: 20, y: (navigationController?.navigationBar.bottom)! + 2, width: view.width * 0.6, height: view.height * 0.03)
        nameTextField.frame = CGRect(x: 20, y: mainLabel.bottom + 10, width: view.width * 0.9, height: view.height * 0.05)
        confirmButton.frame = CGRect(x: view.width *  0.02, y: view.height * 0.8, width: view.width * 0.96, height: 60)
        
    }
    
}
