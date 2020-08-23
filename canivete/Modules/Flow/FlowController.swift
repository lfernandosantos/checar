//
//  FlowController.swift
//  canivete
//
//  Created by Luiz Fernando dos Santos on 16/08/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import UIKit

final class FlowController {
    
    static let shared: FlowController = FlowController()
    
    private var homeStoryBoard: UIStoryboard? = UIStoryboard(name: StoryBoardsName.home.rawValue, bundle: nil)
    private var homeNavigation: UINavigationController?
    
    private init() { }
    
    func openHome(view: UIViewController) {
        guard let homeNavigation = homeStoryBoard?
            .instantiateInitialViewController() as? UINavigationController else {
                return
        }
        self.homeNavigation = homeNavigation
        homeNavigation.modalPresentationStyle = .fullScreen
        view.present(homeNavigation, animated: true, completion: nil)
    }
}

private extension FlowController {
    enum StoryBoardsName: String {
        case home = "Home"
        case login = "Login"
    }
}
