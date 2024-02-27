//
//  TilesCollectionViewCell.swift
//  Tic-Tac-Toe
//
//  Created by Eshan Verma on 26/02/24.
//

import UIKit

class TilesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var widthCons: NSLayoutConstraint!
    @IBOutlet weak var heightCons: NSLayoutConstraint!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.clipsToBounds = true
        tileImage.clipsToBounds = true
        backView.backgroundColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 0.6)
        backView.layer.cornerRadius = 12.0
    }

}
