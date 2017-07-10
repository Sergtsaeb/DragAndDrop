//
//  ViewController.swift
//  DragAndDrop
//
//  Created by Sergelenbaatar Tsogtbaatar on 7/8/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var postcard: UIImageView!
    @IBOutlet weak var colorSelection: UICollectionView!
    
    var colors = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colorSelection.dataSource = self
        self.colorSelection.delegate = self
    }
    
    func colorGenerator() {
        
        colors += [.black, .gray, .white, .yellow, .orange, .red, .magenta, .purple, .blue, .cyan, .green]
        
        for i in 0...9 {
            for j in 1...10 {
                let color = UIColor(hue: CGFloat(i)/10, saturation: CGFloat(j)/10, brightness: 1, alpha: 1)
                colors.append(color)
            }
            
        }
        
    }
    

}

