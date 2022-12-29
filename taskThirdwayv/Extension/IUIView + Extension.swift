//
//  UIView+Extension.swift
//  GithubRepos
//
//  Created by eslam mohamed on 10/04/2022.
//

import UIKit

protocol IUIView{
    func addBorder(color: UIColor)
}

extension UIView:IUIView{
    
    func addBorder(color: UIColor){
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }

}
