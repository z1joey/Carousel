//
//  CarouselCell.swift
//  Carousel
//
//  Created by Joey Zhang on 2022/11/16.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    func setCell(byView view: UIView) {
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
