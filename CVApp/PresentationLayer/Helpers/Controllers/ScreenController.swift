//
//  ScreenController.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 4/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ScreenController: UIViewController {
    
    // MARK: - Life cycle
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View life cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        initConfigure()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        disableSwipeToBackIfNeeded()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        enableSwipeToBackIfNeeded()
    }
    
    // MARK: - Init configure
    
    open func initConfigure() {
        setupLargeNavigationTitle()
    }
    
    // MARK: - Swipe to back
    
    open var swipeToBackEnabled: Bool {
        return true
    }
    
    private func disableSwipeToBackIfNeeded() {
        if !swipeToBackEnabled {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    private func enableSwipeToBackIfNeeded() {
        if !swipeToBackEnabled {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    
    // MARK: - Status bar style
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        let convertor = DeskStatusBarStyleConvertor()
//        return convertor.toUIStatusBarStyle(statusBarStyle)
//    }
//    
//    open var statusBarStyle: DeskStatusBarStyle {
//        return .dark
//    }
    
    // MARK: - Large navigation title
    
    open var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode {
        return .never
    }
    
    private func setupLargeNavigationTitle() {
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
        }
    }
}
