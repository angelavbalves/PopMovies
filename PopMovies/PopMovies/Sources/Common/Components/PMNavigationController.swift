//
//  PMNavigationController.swift
//  PopMovies
//
//  Created by Angela Alves on 25/10/22.
//

import Foundation
import UIKit

class PMNavigationController: UINavigationController {

    // MARK: - Init
    init(rootViewController: PMViewController) {
        super.init(rootViewController: rootViewController)
        configureAppearance()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }

    // MARK: - Actions
    var didFinish: (() -> Void)?

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        didFinish?()
    }

    // MARK: - Aux
    func configureAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue

        navigationBar.tintColor = Theme.currentTheme.color.itemsNav.rawValue

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
