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
        
        let TextT = UILabel()
        let TextFecha = UILabel ()
        let TextTiempo = UILabel ()
        let profileImageView = UIImageView()
        
        
        TextT.text = historyData.item(indexPath) as! String?
        
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
