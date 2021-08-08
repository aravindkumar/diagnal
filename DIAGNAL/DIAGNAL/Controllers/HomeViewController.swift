//
//  ViewController.swift
//  DIAGNAL
//
//  Created by Aravind Kumar on 07/08/21.
//

import UIKit

class HomeViewController: UIViewController {
    //No Need to show Back Option But UI has 
    var page = 1
    let kGalleryIdenitifier = "GalleryUICollectionViewCell"
    private var contentViewModel : ContentViewModel!
    
    @IBOutlet weak var ctView: UICollectionView!
    @IBOutlet weak var navHeightConst: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        let window = UIApplication.shared.keyWindow
        if  let topPadding = window?.safeAreaInsets.top {
            // Do any additional setup after loading the view.
            self.navHeightConst.constant = self.navHeightConst.constant + topPadding
        }
        self.registerNib()
        ctView.delegate = self
        ctView.dataSource = self
        ctView.reloadData()
        self.callToViewModelForUIUpdate()
    }
    //Register Custom NIB
    func registerNib() {
        let nibScreen = UINib(nibName: kGalleryIdenitifier, bundle: nil)
        self.ctView.register(nibScreen, forCellWithReuseIdentifier: kGalleryIdenitifier)
    }
    //Update Model to Gete Data
    func callToViewModelForUIUpdate(){
        self.contentViewModel =  ContentViewModel()
        self.contentViewModel.onUpdateCall = {
            self.page = self.page + 1
            self.updateDataSource()
        }
        self.contentViewModel.callFuncToGetData(page: String(page))
    }
    //Update UI After Received Data on mai thread
    func updateDataSource(){
        DispatchQueue.main.async {
            self.ctView.reloadData()
        }
    }
}
//MARK -- Collection View Delegate and Data Source
///We make extension of  ViewController
extension HomeViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.contentViewModel.contentInfo.count)
        return self.contentViewModel.contentInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : GalleryUICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kGalleryIdenitifier, for: indexPath as IndexPath) as! GalleryUICollectionViewCell
        cell.galleryImageView.backgroundColor = UIColor.red
        //Get tha Next page of Data also there aree mainy ways to fetch Data with lazzacy loader
        if indexPath.row == self.contentViewModel.contentInfo.count - 5 && page != 4 {
            self.contentViewModel.callFuncToGetData(page: String(page))
        }
        //Update the UI of Cell with Content
        cell.configureCellWith(content: self.contentViewModel.contentInfo[indexPath.row])
        return cell
    }
    
}
//UICollectionViewDelegate Delagte
extension HomeViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
//UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //(15+15+15+15)/4 left 2 space and right = 20
        let size = self.view.frame.size.width/3 - 20
        return CGSize(width:size  , height:size*16/9+40)
    }
}
