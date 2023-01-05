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
    let errorView = PMErrorView()
    let emptyView = PMEmptyView()
    var defaults = UserDefaults.standard

    // MARK: - Properties
    private var pmNavigationController: PMNavigationController? {
        navigationController as? PMNavigationController
    }

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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presentingViewController?.beginAppearanceTransition(true, animated: false)
        presentingViewController?.endAppearanceTransition()
    }

    // MARK: - Aux
    func configureViews() {
        view.addSubview(errorView)
        view.addSubview(emptyView)
        errorView.edgesToSuperview()
        emptyView.edgesToSuperview()
        view.backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
    }

    func setCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonDidTap))
    }

    @objc func closeButtonDidTap() {
        pmNavigationController?.dismiss(animated: true)
    }
}
