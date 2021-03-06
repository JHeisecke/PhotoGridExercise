//
//  ViewController.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import UIKit

class HeroesLayoutViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var speedButton: UIButton!
    @IBOutlet weak var powerButton: UIButton!

    var viewModel: HeroesLayoutViewModelProtocol?
    var heroes: Heroes?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Heroes"
        instance()
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
            guard let heroes = heroes else { return }
            self.heroes = heroes
            self.collectionView.reloadData()
        }.dispose(in: bag)

        viewModel?.error.observeNext { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.simpleAlert(
                message: error.message,
                completion: { _ in }
            )
        }.dispose(in: bag)

        nameButton.reactive.tap.observeNext { [weak self] _ in
            guard let self = self else { return }
            self.heroes?.sort(by: { hero1, hero2 in
                hero1.name < hero2.name
            })
            self.collectionView.reloadData()
        }.dispose(in: bag)

        speedButton.reactive.tap.observeNext { [weak self] _ in
            guard let self = self else { return }
            self.heroes?.sort(by: { hero1, hero2 in
                hero1.speed > hero2.speed
            })
            self.collectionView.reloadData()
        }.dispose(in: bag)

        powerButton.reactive.tap.observeNext { [weak self] _ in
            guard let self = self else { return }
            self.heroes?.sort(by: { hero1, hero2 in
                hero1.power > hero2.power
            })
            self.collectionView.reloadData()
        }.dispose(in: bag)
    }
}

// MARK: - UICollectionViewDelegate
extension HeroesLayoutViewController: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDataSource
extension HeroesLayoutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let heroes = self.heroes else { return 0 }
        return heroes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroCollectionViewCell.reusableIdentifier, for: indexPath) as? HeroCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let hero = heroes?[indexPath.row] else { return cell }
        cell.hero = hero
        cell.deleteButtonPressed = { [weak self] in
            self?.heroes?.remove(at: indexPath.row)
            self?.collectionView.reloadData()
        }
        return cell
    }
}

// MARK: - Instance
extension HeroesLayoutViewController {
    func instance() {
        viewModel = HeroesLayoutViewModel(getHeroesUseCase: GetHeroesUseCase(repository: HeroesRepository(api: ApiClient())))
    }
}

extension HeroesLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width/2)-10,
            height: (view.frame.size.height/2.5)
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 5)
    }
}
