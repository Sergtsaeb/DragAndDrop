//
//  ViewController.swift
//  DragAndDrop
//
//  Created by Sergelenbaatar Tsogtbaatar on 7/8/17.
//  Copyright © 2017 Sergtsaeb. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDragDelegate, UIDropInteractionDelegate {
    
    @IBOutlet weak var postcard: UIImageView!
    @IBOutlet weak var colorSelection: UICollectionView!
    
    var colors = [UIColor]()
    var image: UIImage?
    
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
        self.colorSelection.dragDelegate = self
       
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
    
    @available(iOS 11.0, *)
    func dropInteraction() {
        postcard.isUserInteractionEnabled = true
        let dropInteraction = UIDropInteraction(delegate: self)
        postcard.addInteraction(dropInteraction)
        
    }
    
    func renderPostcard() {
        
        //define placing in view
        let drawRect = CGRect(x: 0, y: 0, width: 3000, height: 2400)
        let topTextRect = CGRect(x: 250, y: 200, width: 2500, height: 800)
        let bottomTextRect = CGRect(x: 250, y: 1800, width: 2500, height: 600)
        
        //font instances
        let topFont = UIFont(name: topFontName, size: 350) ?? UIFont.systemFont(ofSize: 250)
        let bottomFont = UIFont(name: bottomFontName, size: 150) ?? UIFont.systemFont(ofSize: 100)
        
        //centered paragraph style
        let centered = NSMutableParagraphStyle()
        centered.alignment = .center
        
        let topTextAttributes: [NSAttributedStringKey: Any] =
            [NSForegroundColorAttributeName as NSString: topColor, NSFontAttributeName as NSString: topFont, NSParagraphStyleAttributeName as NSString: centered]
        let bottomTextAttributes: [NSAttributedStringKey: Any] =
            [NSForegroundColorAttributeName as NSString: bottomColor, NSFontAttributeName as NSString: bottomFont, NSParagraphStyleAttributeName as NSString: centered]
        
        //rendering image the correct size
        let renderer = UIGraphicsImageRenderer(size: drawRect.size)
        postcard.image = renderer.image(actions: { (ctx) in
            UIColor.gray.set()
            ctx.fill(drawRect)
            
            image?.draw(at: CGPoint(x: 0, y: 0))
            
            topText.draw(in: topTextRect, withAttributes: topTextAttributes as [String : Any])
            bottomText.draw(in: bottomTextRect, withAttributes: bottomTextAttributes as [String : Any])
        })
    }
    
    func dropInteraction(_ interaction: UIDropInteraction,
                         sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction,
                         performDrop session: UIDropSession) {
        let location = session.location(in: postcard)
        if session.hasItemsConforming(toTypeIdentifiers:
            [kUTTypePlainText as String]) {
            // handle strings
        } else if session.hasItemsConforming(toTypeIdentifiers:
            [kUTTypeImage as String]) {
            // handle images
        } else {
            // handle colors
        } }
    
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
    
    @available(iOS 11.0, *)
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let color = colors[indexPath.item]
        let provider = NSItemProvider(object: color)
        let item = UIDragItem(itemProvider: provider)
        
        return [item]
    }
    
    

}

