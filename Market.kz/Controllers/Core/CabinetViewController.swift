//
//  CabinetViewController.swift
//  Market.kz
//
//  Created by admin on 4/8/21.
//

import UIKit

class CabinetViewController: UIViewController {

    let logoImageView : UIImageView = {
        let img = UIImageView()
        
        img.image = UIImage(named: "logo")!
        img.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        return img
    }()
    
    let loginView = UIView()
    
    let emailLabel : UILabel = {
        let label = UILabel()
        label.text = "Почта"
        return label
    }()
    
    let emailTextfield : UITextField = {
        let textfield = UITextField()
        
        textfield.placeholder = "Введите вашу почту"
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    let passwordLabel : UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        return label
    }()
    
    let passwordTextfield : UITextField = {
        let textfield = UITextField()
        
        textfield.placeholder = "Введите ваш пароль"
        textfield.borderStyle = .roundedRect
    
        textfield.isSecureTextEntry = true
        
        return textfield
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
    
    let notRegisteredLabel : UILabel = {
        let label = UILabel()
        label.text = "Нету аккаунта?"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let registerButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Зарегестрироваться", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        return btn
    }()
    
    //Profile View
    
    let profileView = UIView()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Обьявления", "Профиль"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        sc.selectedSegmentTintColor = UIColor(red: 6, green: 161, blue: 152, alpha: 1)
        sc.tintColor = UIColor(red: 6, green: 161, blue: 152, alpha: 1)
        sc.backgroundColor = UIColor().defaultBackground
        return sc
    }()
    
    private var collectionView : UICollectionView = UICollectionView(frame : .zero , collectionViewLayout : UICollectionViewCompositionalLayout{ sectionIndex, _ -> NSCollectionLayoutSection in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(195)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200)), subitem: item , count: 2)
        
     
       
        
        let section = NSCollectionLayoutSection(group: group)

        
        return section
    })
  
    @objc func handleSegmentChange(){
        
    }
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor().defaultBackground
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private var adsList = [AdsResponse]()
    
    private var user : UserViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Кабинет"
        navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 221/255, blue: 97/255, alpha: 1)
        
        view.backgroundColor = .systemBackground
        
       setupViews()
        setupTargets()
        configureCollectionView()
    }
    
    private func setupViews(){
// login
        view.addSubview(logoImageView)
        view.addSubview(loginView)
        loginView.addSubview(emailLabel)
        loginView.addSubview(emailTextfield)
        loginView.addSubview(passwordLabel)
        loginView.addSubview(passwordTextfield)
        loginView.addSubview(confirmButton)
        loginView.addSubview(notRegisteredLabel)
        loginView.addSubview(registerButton)
        
// profile
        
        profileView.isHidden = true
        view.addSubview(profileView)
        profileView.addSubview(segmentedControl)
        profileView.addSubview(nameLabel)
        profileView.addSubview(collectionView)
    }
    
    func fetchAds(userId : String){
        let group = DispatchGroup()
        
         group.enter()
        
        
       
        var ads : [AdsResponse]? = [AdsResponse]()
        
       
        
        APICaller.shared.getAllAdsByUser(userId : userId,completion: { result in
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
            guard let Allads = ads
            else {

                fatalError("Models are nill")
            }
           
            self.adsList = Allads
            self.collectionView.reloadData()
        }
        
    }
    private func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        collectionView.backgroundColor = .white
        collectionView.register( ItemCollectionViewCell.self , forCellWithReuseIdentifier:  ItemCollectionViewCell.identifier)
       
        collectionView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        view.addSubview(collectionView)
        
    }
    private func setupTargets(){
        confirmButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        emailTextfield.addTarget(self, action: #selector(validateTextfields), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(validateTextfields), for: .editingChanged)
    }
    @objc func registerButtonTapped(){
        navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
    @objc func loginButtonTapped(){
        AuthManager.shared.signIn(email: emailTextfield.text!, password: passwordTextfield.text!, completion: {result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let model):
                    self.user = UserViewModel(fullname: model.fullname, email: model.email)
                
                    loginView.isHidden = true
                    logoImageView.isHidden = true
                    profileView.isHidden = false
                    
                    collectionView.isHidden = false
                    fetchAds(userId: String(model.id))
                    
                    navigationItem.rightBarButtonItem = UIBarButtonItem(title : "Logout", style: .done, target: self, action: #selector(logoutButtunTapped))
                    navigationItem.rightBarButtonItem?.tintColor = UIColor.red
                    
                    nameLabel.text = "Welcome , \(user?.fullname ?? "No name")"
                    
                case .failure(let error):
                    let alert = UIAlertController(title: "Оппа..", message: "Ошибка при авторизации , повторите попытку", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    print(error.localizedDescription)
                
                }
            }
        })
    }
    
    @objc func logoutButtunTapped(){
        loginView.isHidden = false
        logoImageView.isHidden = false
        profileView.isHidden = true
        collectionView.isHidden = true
        self.navigationItem.rightBarButtonItems?.removeFirst()
    }
    
    @objc func validateTextfields(sender: UITextField){
      
        if  isValidEmail(emailTextfield.text!) && isValidPassword(passwordTextfield.text!) {
            
            self.confirmButton.isEnabled = true
            self.confirmButton.backgroundColor = UIColor.systemBlue
            
        }
        else{
            self.confirmButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.4)
            self.confirmButton.isEnabled = false
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // login
        logoImageView.frame = CGRect(x: 0, y: 80, width: view.width, height: view.height * 0.1)
        loginView.frame = CGRect(x: 0, y: logoImageView.bottom + 10, width: view.width, height: view.height * 0.9)
        emailLabel.frame =  CGRect(x: view.width * 0.1, y: 0 , width: view.width , height: view.height * 0.03)
        emailTextfield.frame = CGRect(x: view.width * 0.1, y: emailLabel.bottom + 10, width: view.width * 0.8, height: view.height * 0.05)
        passwordLabel.frame =  CGRect(x: view.width * 0.1, y: emailTextfield.bottom + 10, width: view.width , height: view.height * 0.03)
        passwordTextfield.frame = CGRect(x: view.width * 0.1, y: passwordLabel.bottom + 10, width: view.width * 0.8, height: view.height * 0.05)
        
        confirmButton.frame = CGRect(x: view.width * 0.1, y: passwordTextfield.bottom + 20, width: view.width * 0.8, height: view.height * 0.05)
        notRegisteredLabel.frame = CGRect(x: view.width * 0.1, y: confirmButton.bottom + 5, width: view.width * 0.3, height: view.height * 0.025)
        registerButton.frame = CGRect(x: notRegisteredLabel.right + view.width * 0.1, y: confirmButton.bottom + 5, width: view.width * 0.4, height: view.height * 0.025)
        
        //profile
        
        profileView.frame = CGRect(x: 0, y: (navigationController?.navigationBar.bottom)! + 2, width: view.width, height: view.height)
        segmentedControl.frame = CGRect(x: 0, y: 5, width: view.width, height: view.height * 0.05)
        nameLabel.frame = CGRect(x: 10, y: segmentedControl.bottom + 20, width: view.width, height: view.height * 0.1)
        
        collectionView.frame = CGRect(x: 0, y: profileView.height * 0.3, width: view.width, height: view.height * 0.8)
        
    }
    

}

extension CabinetViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier :   ItemCollectionViewCell.identifier, for: indexPath) as?   ItemCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        cell.configure(with: adsList[indexPath.row])
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let group = DispatchGroup()
        
         group.enter()
        
        var imagesAds : [UIImage] = []
        
        var responses : [ImageResponse] = []
        
        APICaller.shared.getAdsImages(adsId: String(adsList[indexPath.row].id), completion: {
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
            self.navigationController?.pushViewController(UsersAdsDetailsViewController(item: AdsWithId(name: self.adsList[indexPath.row].name , price: String(self.adsList[indexPath.row].price), images: imagesAds, city: self.adsList[indexPath.row].city, address: self.adsList[indexPath.row].adress, wasInUse: self.adsList[indexPath.row].isNew, description: self.adsList[indexPath.row].description, category: AdsTypeResponse(id: nil, imageUrl: nil, name: nil) , id : String(self.adsList[indexPath.row].id) )), animated: true)
            
        }
    }
    
    
}
