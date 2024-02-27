//
//  ResetView.swift
//  Tic-Tac-Toe
//
//  Created by Eshan Verma on 27/02/24.
//

import UIKit

protocol ResetViewDelegate {
    func resetButtonTapped()
}

class ResetView: UIView {
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topImgBtn: UIButton!
    @IBOutlet weak var btnBackView: UIView!
    @IBOutlet weak var buttonBackImage: UIImageView!
    var delegate: ResetViewDelegate?
    
    static func buildViewWithFrame(_ frame: CGRect) -> ResetView {
        let customView = Bundle.main.loadNibNamed("ResetView", owner: self, options: nil)?.first as! ResetView
        customView.frame = CGRect(x: 0, y: 0, width: frame.height, height: frame.width)
        customView.backgroundColor = UIColor(red: 193.0/255.0, green: 193.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        customView.topImgBtn.backgroundColor = UIColor.clear
        customView.topImage.image = UIImage(named: "RestartGame")
        customView.buttonBackImage.image = UIImage(named: "refresh")
        customView.btnBackView.backgroundColor = UIColor.clear
        return customView
    }
    
    @IBAction func topImgBtnPressed() {
        delegate?.resetButtonTapped()
    }
}
