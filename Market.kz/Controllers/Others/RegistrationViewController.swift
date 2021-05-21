//
//  RegistrationViewController.swift
//  Market.kz
//
//  Created by admin on 4/21/21.
//

import UIKit

class RegistrationViewController: UIViewController {

    private let logoImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")

        image.layer.masksToBounds = false


        image.clipsToBounds = true


        return image
    }()

    private let mainLabel : UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        return label
    }()

    
    
    private let surNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "Фамилия"
        return label
    }()
    
    private var surNameTextField : UITextField = {

        let textField = UITextField()

        textField.borderStyle = .roundedRect




        return textField
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "Имя"
        return label
    }()
    
    private var nameTextField : UITextField = {

        let textField = UITextField()

        textField.borderStyle = .roundedRect




        return textField
    }()
    
    private let emailLabel : UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "Почта"
        return label
    }()
    
    private var emailTextField : UITextField = {

        let textField = UITextField()

        textField.borderStyle = .roundedRect

      


        return textField
    }()
    
    
    
    
    private let passwordLabel : UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "Пароль (больше 8 символов ,минимум 1 цифра  , 1 символ )"
        return label
    }()
    
    private var passwordTextField : UITextField = {

        let textField = UITextField()

        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true



        return textField
    }()
    
    private let confirmPasswordLabel : UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "Confirm a password"
        return label
    }()
    
    private var confirmPasswordTextField : UITextField = {
        
        let textField = UITextField()

        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true



        return textField
    }()

    private var confirmCodeButton : UIButton = {
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
        
  
        configureSubviews()
        configureTargets()
        
        view.backgroundColor = .white

 }
    
    
    private func configureSubviews(){
        
        
        
        view.addSubview(logoImageView)
        view.addSubview(mainLabel)
        view.addSubview(surNameLabel)
        view.addSubview(surNameTextField)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordLabel)
        view.addSubview(confirmPasswordTextField)
        configureConfirmButton()
    }
    
  
    
    private func configureTargets(){
        // textfield
        surNameTextField.addTarget(self, action: #selector(validateTextfields), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(validateTextfields), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(validateTextfields), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(validateTextfields), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(validateTextfields), for: .editingChanged)
        
     
        
    }
    //MARK Configuring Frames and Fonts
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        logoImageView.frame = CGRect(x: 0, y: view.height * 0.15, width: view.width, height: 100)
        
        
        mainLabel.frame = CGRect(x: view.width * 0.335, y:logoImageView.bottom + view.height * 0.06, width: view.width * 0.768, height: view.height * 0.04)
       
        let labelYpos = view.height * 0.032
      // configure sur name textfield frame
        surNameTextField.frame = CGRect(x: view.width * 0.09, y: logoImageView.bottom + view.height *  0.16, width: view.width * 0.83, height: view.height * 0.04)
     
        surNameLabel.frame  = CGRect(x: view.width * 0.09, y: surNameTextField.top - view.height * 0.032, width: view.width * 0.83, height: view.height * 0.03)
        surNameLabel.font = .systemFont(ofSize: view.height * 0.018)
        
     // configure name textfield frame
        nameTextField.frame = CGRect(x: view.width * 0.09, y: surNameTextField.bottom + view.height *  0.03, width: view.width * 0.83, height: view.height * 0.04)
     
        nameLabel.frame  = CGRect(x: view.width * 0.09, y: nameTextField.top - labelYpos, width: view.width * 0.83, height: view.height * 0.03)
        nameLabel.font = .systemFont(ofSize: view.height * 0.018)
        
        // configure email textfield frame
        emailTextField.frame = CGRect(x: view.width * 0.09, y: nameTextField.bottom + view.height *  0.03, width: view.width * 0.83, height: view.height * 0.04)

        emailLabel.frame  = CGRect(x: view.width * 0.09, y: emailTextField.top - labelYpos, width: view.width * 0.83, height: view.height * 0.03)
        emailLabel.font = .systemFont(ofSize: view.height * 0.018)
        
        // configure password textfield frame
        passwordTextField.frame = CGRect(x: view.width * 0.09, y: emailTextField.bottom + view.height *  0.03, width: view.width * 0.83, height: view.height * 0.04)
        passwordLabel.frame  = CGRect(x: view.width * 0.09, y: passwordTextField.top - labelYpos, width: view.width * 0.83, height: view.height * 0.03)
        passwordLabel.font = .systemFont(ofSize: view.height * 0.015)
        
        // configure confirmPassword textfield frame
        confirmPasswordTextField.frame = CGRect(x: view.width * 0.09, y: passwordTextField.bottom + view.height *  0.03, width: view.width * 0.83, height: view.height * 0.04)
        confirmPasswordLabel.frame  = CGRect(x: view.width * 0.09, y: confirmPasswordTextField.top - labelYpos, width: view.width * 0.83, height: view.height * 0.03)
        confirmPasswordLabel.font = .systemFont(ofSize: view.height * 0.018)
        
        
        confirmCodeButton.frame = CGRect(x: 20, y: view.bottom - view.height * 0.15, width: view.width - 40, height: 50)
 




       mainLabel.font = .boldSystemFont(ofSize: self.view.height * 0.03)
       // secondaryLabel.font = .systemFont(ofSize: self.view.height * 0.023)
      


    }

    private func configureConfirmButton(){
        view.addSubview(confirmCodeButton)
        confirmCodeButton.addTarget(self, action: #selector(finishRegistration), for: .touchUpInside)
    }


    
    
    // MARK - objc button's target functions
    @objc func finishRegistration(){

        AuthManager.shared.signUp(fullname: nameTextField.text! + " " + surNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, completion: {_ in
            print("signUp ended")
        })
        
        navigationController?.popToRootViewController(animated: true)
   
    }
    
    @objc func validateTextfields(sender: UITextField){
      
        if nameTextField.text!.count > 3 && containsOnlyLetters(input: nameTextField.text!) && surNameTextField.text!.count > 3 && containsOnlyLetters(input: surNameTextField.text!) && isValidEmail(emailTextField.text!) && isValidPassword(passwordTextField.text!) && passwordTextField.text! == confirmPasswordTextField.text!{
            
            confirmCodeButton.backgroundColor = UIColor.systemBlue
             confirmCodeButton.isEnabled = true
            
        }
        else{
          confirmCodeButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.4)
           confirmCodeButton.isEnabled = false
           
        }
        
        
    }

}
