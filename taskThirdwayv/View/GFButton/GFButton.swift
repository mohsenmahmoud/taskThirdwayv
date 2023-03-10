//
//  GFButton.swift
//  taskThirdwayv
//
//  Created by mohsen on 13/12/2022.
//


import UIKit

class GFButton: UIButton {
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        //
        confiuger()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundColor : UIColor , title : String){

        super.init(frame: .zero)

        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)

        confiuger()
    }

    private func confiuger(){
        layer.cornerRadius      = 10
        titleLabel?.textColor   = .white
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    func set(backgroundColor : UIColor , title : String){
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }

}
