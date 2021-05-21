//
//  SelectSecondaryInfoViewController.swift
//  Market.kz
//
//  Created by admin on 5/4/21.
//

import UIKit

class SelectSecondaryInfoViewController: UIViewController & Coordinating {
    var coordinator: Coordinator?
    

    private let mainLabel : UILabel = {
        let label = UILabel()
        label.text = "Заполните Подробности"
        label.font = .boldSystemFont(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let descriptionTextField : UITextView = {
        let textField = UITextView()
        

        textField.layer.borderWidth = 0.5
        
       
        
        textField.layer.borderColor = UIColor.gray.cgColor
        
        textField.layer.cornerRadius = 15
        
        textField.font = UIFont.systemFont(ofSize: 18.0)
        
        
        return textField
    }()
    

    
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "Цена*"
        label.font = .boldSystemFont(ofSize: 22)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let priceTextField : UITextField = {
        let textField = UITextField()
        
        textField.placeholder  = "Цена товара в тенге"
        
        textField.setLeftPaddingPoints(15)
        
        textField.keyboardType = .numberPad
        
        textField.layer.borderWidth = 0.5
        
        textField.layer.borderColor = UIColor.gray.cgColor
        
        
        return textField
    }()
    
    
    private let stateLabel : UILabel = {
        let label = UILabel()
        label.text = "Б/У"
        label.font = .systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let stateSwitcher : UISwitch = {
        let switcher = UISwitch()
        
        return switcher
    }()
    
    private let separatorView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "separator")!
        return imageView
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
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .done, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
       setup()
    }
    @objc  func cancelButtonTapped(){
        dismiss(animated: true, completion: {
            
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainLabel.frame = CGRect(x: 20, y: (navigationController?.navigationBar.bottom)! + 10, width: view.width * 0.6, height: view.height * 0.03)
        descriptionTextField.frame = CGRect(x: 20, y: mainLabel.bottom + 10, width: view.width * 0.9, height: view.height * 0.1)
        
        priceLabel.frame = CGRect(x: 20, y: descriptionTextField.bottom + 10, width: view.width * 0.9, height: view.height * 0.03)
        
        priceTextField.frame = CGRect(x: 20, y: priceLabel.bottom + 5, width: view.width * 0.9, height: view.height * 0.05)
        
        stateLabel.frame = CGRect(x: 20, y: priceTextField.bottom + 20, width: view.width * 0.4, height: view.height * 0.03)
        stateSwitcher.frame = CGRect(x: view.width * 0.85, y: priceTextField.bottom + 20, width: view.width * 0.1, height: view.height * 0.04)
        separatorView.frame = CGRect(x: 0, y: stateLabel.bottom + 5, width: view.width, height: 1)
        confirmButton.frame = CGRect(x: view.width *  0.02, y: view.height * 0.8, width: view.width * 0.96, height: 60)
    }
    
    @objc func validateTextfields(sender: UITextField){
      
        if  descriptionTextField.text!.count > 10 && priceTextField.text!.count > 0 {
            
            self.confirmButton.isEnabled = true
            self.confirmButton.backgroundColor = UIColor.systemBlue
            
        }
        else{
            self.confirmButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.4)
            self.confirmButton.isEnabled = false
        }
        
        
    }
    

    private func setup(){
        view.addSubview(mainLabel)
        view.addSubview(descriptionTextField)
        descriptionTextField.delegate = self
        descriptionTextField.becomeFirstResponder()
        priceTextField.addTarget(self, action: #selector(validateTextfields), for: .editingChanged)
        view.addSubview(priceLabel)
        view.addSubview(priceTextField)
        view.addSubview(stateLabel)
        view.addSubview(stateSwitcher)
        view.addSubview(separatorView)

        view.addSubview(confirmButton)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
        
    }
    
    @objc func confirmButtonTapped(){
        coordinator?.eventOccured(with: .confirmSecondaryInfo(secondaryInfo:
         ItemSecondaryInfoViewModel(price: priceTextField.text!, description: descriptionTextField.text, wasInUse: stateSwitcher.isOn)))
    }

}

extension SelectSecondaryInfoViewController : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {

            textView.text = "Расскажите про ваш товар или услугу более подробнее..."
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }

        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }

        // ...otherwise return false since the updates have already
        // been made
        return false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
          if  descriptionTextField.text!.count > 10 && priceTextField.text!.count > 0 {
              
              self.confirmButton.isEnabled = true
              self.confirmButton.backgroundColor = UIColor.systemBlue
              
          }
          else{
              self.confirmButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.4)
              self.confirmButton.isEnabled = false
          }
          
    }
}
