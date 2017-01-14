//
//  Cells.swift
//  FitMap
//
//  Created by fitmap on 1/13/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import Foundation
import LBTAComponents

class Cells: DatasourceCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let TextT: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.text = "Algo a modificar"
        let themeColor = UIColor(red:0.1, green: 0.41, blue: 0.22, alpha: 1.0)
        
        label.backgroundColor = themeColor
        return label
    }()
    
    
    
    let TextFecha: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let themeColor = UIColor(red:0.25, green: 0.15, blue: 0.31, alpha: 1.0)
        label.backgroundColor = themeColor
        return label
    }()
    
    let TextTiempo: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let themeColor = UIColor(red:0.13, green: 0.12, blue: 1.2, alpha: 2.0)
        label.backgroundColor = themeColor
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        let themeColor = UIColor(red:0.42, green: 0.11, blue: 0.3, alpha: 1.5)
        imageView.backgroundColor = themeColor
        return imageView
    }()
    

    
    override func setupViews(){
        super.setupViews()
        backgroundColor = .white
        addSubview(profileImageView)
        addSubview(TextT)
        addSubview(TextFecha)
        addSubview(TextTiempo)
        
        //profileImageView.image = Imagen // HIPOTETICA IMAGEN
        profileImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        
        
        TextT.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 25)
        
        
        TextFecha.anchor(TextT.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 4, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 25)
        
        
        TextTiempo.anchor(TextFecha.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 4, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 25 )
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

