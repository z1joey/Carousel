//
//  CarouselView.swift
//  Carousel
//
//  Created by Joey Zhang on 2022/11/16.
//

import UIKit

private let cellID = "CarouselCell"

class CarouselView: UIView {
    @IBOutlet private var pageControl: UIPageControl!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        }
    }

    private var timer: CarouselTimer?
    private var items: [UIView] = []

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    deinit {
        timer?.stop()
        timer = nil
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }

    /// Set items for carousel view content
    /// - Parameter items: e.g. UIView, UIImageView
    func setItems(_ items: [UIView]) {
        self.items = items
        self.pageControl.numberOfPages = items.count
        self.collectionView.reloadData()
    }

    /// start paging automatically
    /// - Parameter interval: timer duration, it is 2.0 by default
    func startAnimating(_ interval: TimeInterval = 2.0) {
        timer?.start(interval: interval)
        timer?.onTick(action: { [unowned self] _ in
            goToNextItem()
        })
    }
}

private extension CarouselView {
    func commonInit() {
        Bundle.main.loadNibNamed("CarouselView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        timer = CarouselTimer()
    }

    func goToNextItem() {
        if let cell = collectionView.visibleCells.first,
           let index = collectionView.indexPath(for: cell) {
            let item = items.indices.contains(index.item + 1) ? index.item + 1 : 0
            collectionView.scrollToItem(at: IndexPath(item: item, section: index.section), at: .centeredHorizontally, animated: true)
        }
    }
}

extension CarouselView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        let view = items[indexPath.item]

        if let cell = cell as? CarouselCell {
            cell.setCell(byView: view)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
}

extension CarouselView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToNextItem()
    }
}

extension CarouselView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
