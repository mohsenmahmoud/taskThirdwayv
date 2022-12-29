//
//  CoreData.swift
//  taskThirdwayv
//
//  Created by mohsen on 15/12/2022.
//

import Foundation
import CoreData
import UIKit
class CoreDataCV{
    
  static let data = CoreDataCV()
    //store data in core data
   func storProduct(product : productModel){
        guard let applcation = UIApplication.shared.delegate as? AppDelegate else{return}
       
       let manageContext = applcation.persistentContainer.viewContext
       
       let productEntity = NSEntityDescription.entity(forEntityName: "Products", in: manageContext)!
       
       let productObject = NSManagedObject(entity: productEntity, insertInto: manageContext)
       
       productObject.setValue(product.id, forKey: "id")
       productObject.setValue(product.price, forKey: "price")
       productObject.setValue(product.productDescription, forKey: "productDescription")
       
       
       do{
           try manageContext.save()
           print("=======done===========")
       }catch{
          print("=======error===========")
       }
    }
    
    
    
    //fecth data from coer data
    func getDataFromCoreData() -> [productModel]{
        var dataItem : [productModel] = []

        guard let applcation = UIApplication.shared.delegate as? AppDelegate else{return []}

       let  context = applcation.persistentContainer.viewContext

        let fecthRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Products")

        do{
            let result = try context.fetch(fecthRequest) as! [NSManagedObject]
            
            for managedProduct in result{
                let id = managedProduct.value(forKey: "id")
                let productDescription = managedProduct.value(forKey: "productDescription")
                let price = managedProduct.value(forKey: "price")

                let pro = productModel(id: id as! Int, productDescription: productDescription as! String, image: nil , price: price as! Int)
                
                dataItem.append(pro)
                
                print("xxxxxxxxxxxxx\(pro.productDescription)")
            }

        }catch{
            print("=======error===========")

        }
        return dataItem
    }
    
    
    
    
}


