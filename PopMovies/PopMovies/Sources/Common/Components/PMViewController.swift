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
    var defaults = UserDefaults.standard
    var isDark = false
    var appTheme: AppTheme {
        get {
            return defaults.appTheme
        }
        set {
            defaults.appTheme = newValue
            configureMode(for: newValue)
        }
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let name = NSNotification.Name(rawValue: "darkModeHasChanged")
        NotificationCenter.default.post(name: name, object: nil)
        UserDefaults.standard.set(isDark, forKey: "isDarkMode")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presentingViewController?.beginAppearanceTransition(true, animated: false)
        presentingViewController?.endAppearanceTransition()
    }

    // MARK: - Aux
    func configureViews() {
        view.addSubview(loadingView)
        loadingView.edgesToSuperview()
        view.backgroundColor = Theme.currentTheme.color.backgroundColor.rawValue
    }

    func configureMode(for theme: AppTheme) {
        view.window?.overrideUserInterfaceStyle = theme.userInterfaceStyle
    }
}
