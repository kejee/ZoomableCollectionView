//
//  TwoViewController.swift
//  CollectionViewPhotos
//
//  Created by HYapple on 2024/4/22.
//

import UIKit

class TwoViewController: UIViewController {

    var collectionView: ZoomableCollectionView!
    var layout = UICollectionViewFlowLayout()

    let margin = 10.0
    let cellNum = 20000
    
    var col: Int = 1
    
    // 生成随机颜色数组
    lazy var colors: [UIColor] = {
        var colors = [UIColor]()
        for _ in 0..<cellNum {
            colors.append(UIColor.random())
        }
        return colors
    }()
    
    
    var beganScale: CGFloat = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Continuous Zoom"
        
        col = 4
        
        setupView()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let delayInSeconds: Double = 0.05
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
            self.layout.itemSize = self.calcItemsize()
            self.collectionView.reloadData()
        }
    }
    
    func setupView() {

        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = margin
        layout.minimumLineSpacing = margin
        
        
        collectionView = ZoomableCollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentSize = view.bounds.size
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.zoomDelegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        view.addSubview(collectionView)
        
        
        layout.itemSize = calcItemsize()
    }
    
    
    func calcItemsize() -> CGSize {
        let cw = collectionView.contentSize.width
        print(cw)
        
        let space = layout.minimumInteritemSpacing
        var iw = cw
        var ih = iw
        
        if col == 1 {
            ih = iw * 9 / 16
        } else {
//            let col = CGFloat(layoutType.rawValue)
            iw = max((cw - space * CGFloat(col - 1))/CGFloat(col), 0)
            ih = iw * 16 / 9
        }
        return CGSize(width: iw, height: ih)
    }


}

extension TwoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
    
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return layout.itemSize
    }
    
    
}


// MARK: - ZoomableCollectionViewDelegate

extension TwoViewController: ZoomableCollectionViewDelegate {
    func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            beganScale = gestureRecognizer.scale

        case .changed:
            
            let changedScale = gestureRecognizer.scale
            
            let velocity = gestureRecognizer.velocity
            
            print("\(beganScale) - \(changedScale) = |\(abs(changedScale - beganScale))|\n\(velocity)")
            
            if abs(changedScale - beganScale) > 0.18 {
                if velocity > 0 {
                    col = max(col - 1, 1)
                } else {
                    col = col + 1
                }
                beganScale = changedScale
                
                self.collectionView.performBatchUpdates({
                    self.layout.minimumLineSpacing = CGFloat(max(margin - Double(col), 0.5))
                    self.layout.minimumInteritemSpacing = CGFloat(max(margin - Double(col), 0.5))
                    self.layout.itemSize = self.calcItemsize()
                }, completion: nil)
                
            } else {
//                self.collectionView.performBatchUpdates({
//                    self.layout.minimumLineSpacing = CGFloat(max(margin - Double(col), 0.5)) * changedScale
//                    self.layout.minimumInteritemSpacing = CGFloat(max(margin - Double(col), 0.5)) * changedScale
//                    self.layout.itemSize = CGSize(width: self.calcItemsize().width * changedScale, height: self.calcItemsize().height * changedScale)
//                    
//                }, completion: nil)
            }
            
            
        case .ended:
//            self.collectionView.performBatchUpdates({
//                self.layout.minimumLineSpacing = CGFloat(max(margin - Double(col), 0.5))
//                self.layout.minimumInteritemSpacing = CGFloat(max(margin - Double(col), 0.5))
//                self.layout.itemSize = self.calcItemsize()
//            }, completion: nil)
            break
        default:
            break
        }
    }
}
