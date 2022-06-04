//
//  ViewController.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import UIKit

class HeroesLayoutViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: HeroesLayoutViewModelProtocol?
    var heroes: Heroes?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupObservables()
    }

}

extension HeroesLayoutViewController {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: HeroCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: HeroCollectionViewCell.reusableIdentifier)
    }

    func setupObservables() {
        viewModel?.heroes.observeNext { [weak self] heroes in
            guard let self = self else { return }
            self.heroes = heroes
        }.dispose(in: bag)

        viewModel?.error.observeNext { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.simpleAlert(
                message: error.message,
                completion: { _ in }
            )
        }.dispose(in: bag)
    }
}

extension HeroesLayoutViewController: UICollectionViewDelegate {

}

extension HeroesLayoutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let heroes = self.heroes else { return 0 }
        return heroes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroCollectionViewCell.reusableIdentifier, for: indexPath) as? HeroCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
