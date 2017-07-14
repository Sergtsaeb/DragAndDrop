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
    var image = UIImage()
    
    var topText = "Visit the Northern Lights"
    var topFontName = "Helvetica Neue"
    var topColor = UIColor.white
    
    var bottomText = "Home of Sherlock Holmes, Paddington Bear, and James Bond"
    var bottomFontName = "Helvetica Neue"
    var bottomColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorGenerator()
        renderPostcard()
        
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
    
    func renderPostcard() {
        
        //placing in view
        let drawRect = CGRect(x: 0, y: 0, width: 3000, height: 2400)
        let topTextRect = CGRect(x: 250, y: 200, width: 2500, height: 800)
        let bottomTextRect = CGRect(x: 250, y: 1800, width: 2500, height: 600)
        
        //font instances
        let topFont = UIFont(name: topFontName, size: 350) ?? UIFont.systemFont(ofSize: 250)
        let bottomFont = UIFont(name: bottomFontName, size: 150) ?? UIFont.systemFont(ofSize: 100)
        
        //centered paragraph style
        let centered = NSMutableParagraphStyle()
        centered.alignment = .center
        
        let topTextAttributes: [NSAttributedStringKey: Any] = [.foregroundColor: topColor, .font: topFont, .paragraphStyle: centered]
        let bottomTextAttributes: [NSAttributedStringKey: Any] = [.foregroundColor: bottomColor, .font: bottomFont, .paragraphStyle: centered]
        
        let renderer = UIGraphicsImageRenderer(size: drawRect.size)
        postcard.image = renderer.image(actions: { (ctx) in
            UIColor.gray.set()
            ctx.fill(drawRect)
            
            image.draw(at: CGPoint(x: 0, y: 0))
            
            topText.draw(in: topTextRect, withAttributes: topTextAttributes)
            bottomText.draw(in: bottomTextRect, withAttributes: bottomTextAttributes)
        })
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = colorSelection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        
        return cell
    }
    

}

