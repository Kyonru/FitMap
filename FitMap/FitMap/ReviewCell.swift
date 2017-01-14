//
//  ReviewCell.swift
//  FitMap
//
//  Created by fitmap on 1/13/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.

//
import Foundation
import LBTAComponents

class ReviewCell: DatasourceCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var TextT: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let themeColor = UIColor(red:0.1, green: 0.41, blue: 0.22, alpha: 1.0)
        label.backgroundColor = themeColor
        label.backgroundColor = .blue
        //label.text = "Algo a modificar"
        return label
    }()
    
    var TextFecha: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let themeColor = UIColor(red:0.25, green: 0.15, blue: 0.31, alpha: 1.0)
        label.backgroundColor = .blue
        return label
    }()
    
    var Comment: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red:0.2, green: 0.3, blue: 0.5, alpha: 1)
        label.backgroundColor = .blue
        return label
    }()
    
    var TextTiempo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .blue
        return label
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
    }()

    
    
    override func setupViews(){
        super.setupViews()
        backgroundColor = .white
        
        addSubview(profileImageView)
        addSubview(TextT)
        addSubview(TextFecha)
        addSubview(TextTiempo)
        addSubview(Comment)
        
        //profileImageView.image = Imagen // HIPOTETICA IMAGEN
        profileImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 12, rightConstant: 0, widthConstant: 40, heightConstant: 45)
        
        
        TextT.anchor(self.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 45, heightConstant: 25)
        
        
        TextFecha.anchor(TextT.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, topConstant: 4, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 45, heightConstant: 25)
        
        
        TextTiempo.anchor(self.topAnchor, left: TextT.rightAnchor, bottom:nil, right: self.rightAnchor, topConstant: 12, leftConstant: 4, bottomConstant: 0, rightConstant: 12, widthConstant: 10, heightConstant: 10 )
        
        Comment.anchor(TextFecha.bottomAnchor, left: profileImageView.rightAnchor, bottom: self.bottomAnchor, right: TextTiempo.rightAnchor, topConstant: 4, leftConstant: 4, bottomConstant: 12, rightConstant: 12, widthConstant: 10, heightConstant: 10 )
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

