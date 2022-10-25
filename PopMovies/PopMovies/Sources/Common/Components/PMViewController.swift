//
//  PMViewController.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import UIKit

class PMViewController: UIViewController {

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
        view.backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
    }
}
