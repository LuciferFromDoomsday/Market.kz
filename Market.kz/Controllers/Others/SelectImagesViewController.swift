//
//  SelectImagesViewController.swift
//  Market.kz
//
//  Created by admin on 5/5/21.
//

import UIKit
import Photos
import BSImagePicker

class SelectImagesViewController: UIViewController , Coordinating {
    var coordinator: Coordinator?
    
    private var images : [UIImage] = []
    
 
    let imagePicker = ImagePickerController()
    
    private var collectionView : UICollectionView = UICollectionView(frame : .zero , collectionViewLayout : UICollectionViewCompositionalLayout{ sectionIndex, _ -> NSCollectionLayoutSection in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(125)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)), subitem: item , count: 3)
        
     
       
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    })
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "addImage")
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        return imageView
    }()
    
    let confirmButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Продолжить", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.systemBlue
        btn.isHidden = true
        btn.layer.cornerRadius = 5
        return btn
    }()
    let addImageButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Добавить фотографию", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.systemBlue
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
        
        imageView.frame = CGRect(x: 0, y: (navigationController?.navigationBar.bottom)!, width: view.width, height: view.height * 0.3)
        
        addImageButton.frame = CGRect(x: view.width * 0.05, y: imageView.bottom + 10, width: view.width * 0.9, height: view.height * 0.05)
        
        collectionView.frame = CGRect(x: view.width * 0.05, y: imageView.bottom + 10, width: view.width * 0.9, height: view.height * 0.6)
        
        confirmButton.frame = CGRect(x: view.width * 0.05, y: view.height * 0.9, width: view.width * 0.9, height: view.height * 0.05)
        
    }
    
    private func setup(){
        view.addSubview(imageView)
        view.addSubview(addImageButton)
        addImageButton.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
        view.addSubview(collectionView)
        collectionView.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AddImageCollectionViewCell.self, forCellWithReuseIdentifier: AddImageCollectionViewCell.identifier)
        collectionView.register(AddImageButtonCollectionViewCell.self, forCellWithReuseIdentifier: AddImageButtonCollectionViewCell.identifier)
        
        collectionView.backgroundColor = .systemBackground
        
        view.addSubview(confirmButton)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
    }
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
    @objc func addImageButtonTapped(){
    
  
        
        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
        }, finish: { (assets) in
            
            var selectedImages = [UIImage]()
       assets.forEach({
        selectedImages.append(self.getAssetThumbnail(asset: $0))
            })
            
            self.images = selectedImages
      
            
            self.addImageButton.isHidden = true
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            
            self.confirmButton.isHidden = false
            
        })
       
    }
    
    @objc func confirmButtonTapped(){
        coordinator?.eventOccured(with: .confirmImagesSelected(images : images))
    }
   

}

extension SelectImagesViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row != 0{
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddImageCollectionViewCell.identifier, for: indexPath) as? AddImageCollectionViewCell else {
            return UICollectionViewCell()
        }
            cell.delegate = self
        cell.configure(with: images[indexPath.row - 1])
        
        return cell
        } else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddImageButtonCollectionViewCell.identifier, for: indexPath) as? AddImageButtonCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.delegate = self
            return cell
        }
    }
    
    
}

extension SelectImagesViewController : AddImageButtonCollectionViewCellDelegate{
    func addImageButtonPressed() {
        
        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
        }, finish: { (assets) in
            
            var selectedImages = [UIImage]()
       assets.forEach({
        selectedImages.append(self.getAssetThumbnail(asset: $0))
            })
            
            self.images = selectedImages
      
            
            self.addImageButton.isHidden = true
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            
            self.confirmButton.isHidden = false
            
        })
        self.collectionView.reloadData()
    }
    
    
}

extension SelectImagesViewController : AddImageCollectionViewCellDelegate{
    func deleteImageButtonTapped(_ cell: AddImageCollectionViewCell) {
        guard let index = self.collectionView.indexPath(for: cell) else {
            return
        }
        print(index.row)
        self.images.remove(at: index.row - 1)
        self.collectionView.reloadData()
        
    }
    
  
    
    
}
