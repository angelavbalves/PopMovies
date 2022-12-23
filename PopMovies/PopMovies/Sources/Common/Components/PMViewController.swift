//
//  PMViewController.swift
//  PopMovies
//
//  Created by Angela Alves on 20/10/22.
//

import Foundation
import UIKit

class PMViewController: UIViewController {

    // MARK: - View
    let loadingView = PMLoadingView()
    let errorView = PMErrorView()
    let emptyView = PMEmptyView()
    var defaults = UserDefaults.standard
    var isDark = false

    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaults.set(isDark, forKey: "isDarkMode")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presentingViewController?.beginAppearanceTransition(true, animated: false)
        presentingViewController?.endAppearanceTransition()
    }

    // MARK: - Aux
    func configureViews() {
        view.addSubview(loadingView)
        view.addSubview(errorView)
        view.addSubview(emptyView)
        loadingView.edgesToSuperview()
        errorView.edgesToSuperview()
        emptyView.edgesToSuperview()
        view.backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
    }
}
