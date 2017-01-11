//
//  MeCollectionViewController.swift
//  FitMap
//
//  Created by fitmap on 1/11/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import UIKit
import LBTAComponents

private let reuseIdentifier = "Cell"


class Cells: DatasourceCell {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    override var datasourceItem: Any?{
        didSet{
            //TextT.text = datasourceItem as? String
        }
    }
    
    
    var TextT: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
       // label.text = "Algo a modificar"
        return label
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    func agregarImagen(Imagen: UIImage){
        profileImageView.image = Imagen
        profileImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        
    }
    
    override func setupViews(){
        super.setupViews()
        backgroundColor = .white
        addSubview(TextT)
        addSubview(profileImageView)
        profileImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        TextT.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        /*
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        profileImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;*/
        
       /*
        TextT.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        TextT.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        TextT.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        TextT.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;*/
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MeDataSourse: Datasource{
    let history = ["Todavia", "Por", "Identificar", "Atun"]
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [Cells.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return history[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return history.count
    }



}

class MeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let reuseIdentifier = "MapCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    var APILBTA: DatasourceController?
    var historyData = MeDataSourse()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(Cells.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.backgroundColor = .gray
        // Do any additional setup after loading the view.
        
        
        APILBTA?.datasource = historyData
      
        
        collectionView?.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return historyData.numberOfItems(1)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        
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
        
        TextT.text = historyData.item(indexPath) as! String?
       
        
        let profileImageView: UIImageView = {
            let imageView = UIImageView()
            let themeColor = UIColor(red:0.42, green: 0.11, blue: 0.3, alpha: 1.5)
            imageView.backgroundColor = themeColor
            return imageView
        }()
        
        
        cell.addSubview(profileImageView)
        cell.addSubview(TextT)
        cell.addSubview(TextFecha)
        cell.addSubview(TextTiempo)
        
        //profileImageView.image = Imagen // HIPOTETICA IMAGEN
        profileImageView.anchor(cell.topAnchor, left: cell.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        
        
        TextT.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: cell.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 25)
        
        
        TextFecha.anchor(TextT.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: cell.rightAnchor, topConstant: 10, leftConstant: 4, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 25)
        
        
        TextTiempo.anchor(TextFecha.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: cell.rightAnchor, topConstant: 10, leftConstant: 4, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 25 )
        
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
