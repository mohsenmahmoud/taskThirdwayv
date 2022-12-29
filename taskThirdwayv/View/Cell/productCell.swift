//
//  productCell.swift
//  taskThirdwayv
//
//  Created by mohsen on 13/12/2022.
//

import UIKit

class productCell: UICollectionViewCell {
    
    static let id = "productCell";

    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
 

    
    func setup(productList : productModel){
        width.constant = CGFloat((productList.image?.width ?? 200))
        height.constant = CGFloat((productList.image?.height ?? 300))
        price.text = "\(productList.price)"
        title.text = productList.productDescription
       //image.downloaded(from:(productList.image?.url))
        
        image.downloadImg(from: productList.image?.url ?? "")
        
     
        
    }

}
