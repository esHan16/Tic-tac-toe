//
//  ViewController.swift
//  Tic-tac-toe
//
//  Created by Eshan Verma on 27/02/24.
//

import UIKit

let numberOfCells: Int = 9

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ResetViewDelegate {
    var dataArray : [String] = ["","","","","","","","",""]
    var toggleFlag = true
    var gameEnd = false
    var cell : TilesCollectionViewCell? = nil
    var customResetView : UIView?
    @IBOutlet weak var boardCollectionView: UICollectionView!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var winnerLabel: UILabel!
    let customResetIPadImageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 173, height: 173))
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerLabel.isHidden = true
        winnerLabel.textColor = UIColor.white
        boardCollectionView.delegate = self
        boardCollectionView.dataSource = self
        boardCollectionView.register(UINib(nibName: "TilesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TilesCollectionViewCell")
        boardCollectionView.backgroundColor = UIColor(red: 193.0/255.0, green: 193.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        boardCollectionView.layer.cornerRadius = 20.0
        titleImage.image = UIImage(named: "TIC-TAC-TOE")
        customResetView = UIView(frame:CGRect(x: 0, y: 0, width: boardCollectionView.frame.height, height: boardCollectionView.frame.width))
        customResetView?.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 0.0/255.0, green: 210.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 58.0/255.0, green: 123.0/255.0, blue: 213.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TilesCollectionViewCell", for: indexPath) as? TilesCollectionViewCell
        cell?.tileImage.image = UIImage(named: dataArray[indexPath.row])
        let width: CGFloat = (collectionView.frame.size.width - 16.0 * 4)/3.0
        if UIDevice.current.userInterfaceIdiom == .pad {
            cell?.heightCons.constant = width - 0.5
            cell?.widthCons.constant = width - 0.5
        } else {
            cell?.heightCons.constant = width
            cell?.widthCons.constant = width
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.size.width - 16.0 * 4)/3.0
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: width - 0.5, height: width - 0.5)
        }
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 16.0,left: 16.0,bottom: 16.0,right: 16.0) // top, left, bottom, right
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(gameEnd || dataArray[indexPath.row] == "X" || dataArray[indexPath.row] == "O"){
            return
        }
        if(toggleFlag){
            dataArray[indexPath.row] = "X"
            winnerLabel.isHidden = false
            winnerLabel.text = "O's TURN"
            toggleFlag = false
        } else {
            dataArray[indexPath.row] = "O"
            winnerLabel.isHidden = false
            winnerLabel.text = "X's TURN"
            toggleFlag = true
        }
        if(((dataArray[0] == dataArray[4]) && (dataArray[4] == dataArray[8]) && (dataArray[0] == dataArray[8]) && (dataArray[0] == "X")) ||
           ((dataArray[2] == dataArray[4]) && (dataArray[4] == dataArray[6]) && (dataArray[2] == dataArray[6]) && (dataArray[2] == "X")) ||
           ((dataArray[0] == dataArray[1]) && (dataArray[1] == dataArray[2]) && (dataArray[0] == dataArray[2]) && (dataArray[0] == "X")) ||
           ((dataArray[3] == dataArray[4]) && (dataArray[4] == dataArray[5]) && (dataArray[3] == dataArray[5]) && (dataArray[3] == "X")) ||
           ((dataArray[6] == dataArray[7]) && (dataArray[7] == dataArray[8]) && (dataArray[6] == dataArray[8]) && (dataArray[6] == "X")) ||
           ((dataArray[0] == dataArray[3]) && (dataArray[3] == dataArray[6]) && (dataArray[0] == dataArray[6]) && (dataArray[0] == "X")) ||
           ((dataArray[1] == dataArray[4]) && (dataArray[4] == dataArray[7]) && (dataArray[1] == dataArray[7]) && (dataArray[1] == "X")) ||
           ((dataArray[2] == dataArray[5]) && (dataArray[5] == dataArray[8]) && (dataArray[2] == dataArray[8])) && (dataArray[2] == "X")){
            gameEnd = true
            winnerLabel.isHidden = false
            winnerLabel.text = "X - WINS"
            addResetView()
        } else if (((dataArray[0] == dataArray[4]) && (dataArray[4] == dataArray[8]) && (dataArray[0] == dataArray[8]) && (dataArray[0] == "O")) ||
                   ((dataArray[2] == dataArray[4]) && (dataArray[4] == dataArray[6]) && (dataArray[2] == dataArray[6]) && (dataArray[2] == "O")) ||
                   ((dataArray[0] == dataArray[1]) && (dataArray[1] == dataArray[2]) && (dataArray[0] == dataArray[2]) && (dataArray[0] == "O")) ||
                   ((dataArray[3] == dataArray[4]) && (dataArray[4] == dataArray[5]) && (dataArray[3] == dataArray[5]) && (dataArray[3] == "O")) ||
                   ((dataArray[6] == dataArray[7]) && (dataArray[7] == dataArray[8]) && (dataArray[6] == dataArray[8]) && (dataArray[6] == "O")) ||
                   ((dataArray[0] == dataArray[3]) && (dataArray[3] == dataArray[6]) && (dataArray[0] == dataArray[6]) && (dataArray[0] == "O")) ||
                   ((dataArray[1] == dataArray[4]) && (dataArray[4] == dataArray[7]) && (dataArray[1] == dataArray[7]) && (dataArray[1] == "O")) ||
                   ((dataArray[2] == dataArray[5]) && (dataArray[5] == dataArray[8]) && (dataArray[2] == dataArray[8])) && (dataArray[2] == "O")) {
            gameEnd = true
            winnerLabel.isHidden = false
            winnerLabel.text = "O - WINS"
            addResetView()
        } else {
            gameEnd = false
            var crossCount = 0
            var noughtCount = 0
            for count in 0...8 {
                if(dataArray[count] == "X"){
                    crossCount = crossCount + 1
                } else {
                    noughtCount = noughtCount + 1
                }
            }
            if(crossCount == 5 && noughtCount == 4){
                winnerLabel.isHidden = false
                gameEnd = true
                winnerLabel.text = "IT'S A DRAW"
                addResetView()
            }
        }
        boardCollectionView.reloadData()
    }
    
    func addResetView(){
        if UIDevice.current.userInterfaceIdiom == .pad {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                self.boardCollectionView.addSubview(customResetView!)
                customResetIPadImageView.image = UIImage(named: "refresh")
                customResetIPadImageView.center = self.view.center
                self.view.addSubview(customResetIPadImageView)
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapForIPad))
                customResetIPadImageView.isUserInteractionEnabled = true
                customResetIPadImageView.addGestureRecognizer(tapGestureRecognizer)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                self.boardCollectionView.addSubview(customResetView!)
                let customResetViewFrame = ResetView.buildViewWithFrame(boardCollectionView.frame)
                customResetViewFrame.delegate = self
                customResetViewFrame.isUserInteractionEnabled = true
                customResetView!.addSubview(customResetViewFrame)
            }
        }
    }
    
    @objc func handleTapForIPad() {
        customResetView!.removeFromSuperview()
        customResetIPadImageView.removeFromSuperview()
        resetGame()
    }
    
    @objc func handleTap() {
        resetButtonTapped()
    }
    
    func resetButtonTapped(){
        customResetView!.removeFromSuperview()
        resetGame()
    }
    
    func resetGame(){
        dataArray = ["","","","","","","","",""]
        winnerLabel.isHidden = true
        toggleFlag = true
        gameEnd = false
        boardCollectionView.reloadData()
    }
}

