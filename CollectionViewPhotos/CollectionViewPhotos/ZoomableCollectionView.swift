//
//  ZoomableCollectionView.swift
//  MoYunTeng
//
//  Created by HYapple on 2024/4/22.
//

import UIKit


@objc protocol ZoomableCollectionViewDelegate: AnyObject {
    @objc optional func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer)
}

class ZoomableCollectionView: UICollectionView {
    private var pinchGestureRecognizer_zoom: UIPinchGestureRecognizer!
    weak var zoomDelegate: ZoomableCollectionViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupPinchGestureRecognizer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPinchGestureRecognizer()
    }
    
    private func setupPinchGestureRecognizer() {
        pinchGestureRecognizer_zoom = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        self.addGestureRecognizer(pinchGestureRecognizer_zoom)
    }

    @objc private func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard gestureRecognizer.numberOfTouches == 2 else {
            return
        }
        zoomDelegate?.handlePinchGesture?(gestureRecognizer)
    }
    
    
}




//private var associatedObjectHandle: UInt8 = 0
//
//extension UICollectionView {
//    open override var pinchGestureRecognizer: UIPinchGestureRecognizer? {
//        get {
//            return objc_getAssociatedObject(self, &associatedObjectHandle) as? UIPinchGestureRecognizer
//        }
//        set {
//            objc_setAssociatedObject(self, &associatedObjectHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//
//    func addPinchGestureRecognizer(target: Any?, action: Selector) {
//        let pinchGesture = UIPinchGestureRecognizer(target: target, action: action)
//        self.addGestureRecognizer(pinchGesture)
//        pinchGestureRecognizer = pinchGesture
//    }
//}
//
