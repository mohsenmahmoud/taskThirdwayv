//
//  ViewController.swift
//  taskThirdwayv
//
//  Created by mohsen on 12/12/2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var productItem:[productModel] = []
 
    
    @IBOutlet weak var collectionView: UICollectionView!
    let homeAPI = "http://localhost:3000/product"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NetworkMonitor.shared.isConnected{
            print("internet is conected")
            fetchData()
        }else{
            DispatchQueue.main.async {
                let alertVC = AlertVC(title: "internet not conected", message: "please check your network connection and try again", buttonTitle: "ok")
                alertVC.modalPresentationStyle = .overFullScreen
                alertVC.modalTransitionStyle = .crossDissolve
                alertVC.completionHandler = {
                    self.reloadDataFromCoreData()
                }
                self.present(alertVC, animated: true)
                
            }
           
            print("internet not conected")
            
        }
        
    }
    
    //reload data from local core Data
    
    func reloadDataFromCoreData(){
        productItem = CoreDataCV.data.getDataFromCoreData()
        collectionView.reloadData()
    }
    
 
    //fetch data from api
    func fetchData() {
        showLoadingView()
        NetworkManager.fetchDataRequest(urlString: homeAPI,  type: [productModel].self) { [self] result in
            
            self.dismissLoadingView()
            switch result{
            case .success(let data):
                print(data)
                DispatchQueue.main.async {
                    for i in data{
                        self.productItem.append(i)
                        collectionView.reloadData()
                        CoreDataCV.data.storProduct(product: i)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

    

extension ViewController :UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCell.id, for: indexPath) as! productCell
        cell.layer.borderWidth = 1
 
        cell.setup(productList: productItem[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let size = (collectionView.frame.size.width-10)/2
      
   return CGSize(width: size, height:size)
  
         
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == collectionView{
            if(scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height){
               // setpaginsionProductPage(productPerPage: productPerPage)
                fetchData()
                
            }
        }
    }
    
    
    
    
    
}











 
 

 

