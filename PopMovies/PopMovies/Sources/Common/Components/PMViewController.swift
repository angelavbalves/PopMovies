//
//  PMViewController.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import UIKit

class PMViewController: UIViewController {

    let loadingView = PMLoadingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureViews() {
        view.addSubview(loadingView)
        loadingView.edgesToSuperview()
        view.backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
    }
}
