//
//  PopMoviesViewController.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import UIKit

class PopMoviesViewController: PMViewController {

    let viewModel = PopMoviesViewModel()
    private lazy var collectionView = PopMoviesView()

    override func loadView() {
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getPopMovies()
   }

    func getPopMovies() {
        viewModel.getMovies { [ weak self] state in
            switch state {
                case .success(let movies):
                    self?.collectionView.receive(movies)
                case .error:
                    // mostrar errorview
                    print("Error to get movies")
            }
        }
    }
    
}

