//
//  HomeTabBarViewModel.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/18.
//  Copyright © 2020 yasuo. All rights reserved.
//

@_exported import Foundation
@_exported import RxCocoa
@_exported import RxSwift
@_exported import Kingfisher
@_exported import Moya

class HomeTabBarViewModel: ViewModel, ViewModelType {
    override init(provider: NetApi) {
        super.init(provider: provider)
    }
    
    struct Input {
        
    }

    struct Output {
        let tabBarItems: Driver<[HomeTabBarItem]>
    }
    
    func transform(input: Input) -> Output {
        let tabBarItems = Driver<[HomeTabBarItem]>.just([.home,.circle,.shortVideo,.liveBroadcast,.mine])
        return Output(tabBarItems: tabBarItems)
    }
    
    func viewModel(for tabBarItem: HomeTabBarItem) -> ViewModel {
        switch tabBarItem {
        case .home:
            let viewModel = HomeViewModel(provider: provider)
            return viewModel
        case .circle:
            
            let viewModel = HomeViewModel(provider: provider)
            return viewModel
        case .shortVideo:
            let viewModel = HomeViewModel(provider: provider) 
            return viewModel
        case .liveBroadcast:
            let viewModel = HomeViewModel(provider: provider)
            return viewModel
        case .mine:
//            let user = User.currentUser()!
            let viewModel = HomeViewModel(provider: provider)
            return viewModel
        }
    }
}
