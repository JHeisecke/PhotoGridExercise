//
//  HeroCollectionViewCell.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var hero: HeroEntity? {
        didSet {
            self.heroName.text = hero?.name
            self.heroImage.loadFrom(URLAddress: hero?.image ?? "")
        }
    }

    static let reusableIdentifier = "HeroCellId"
    static let nibName = "HeroCollectionViewCell"
}
