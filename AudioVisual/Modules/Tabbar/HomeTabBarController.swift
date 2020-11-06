//
//  HomeTabBarController.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/19.
//  Copyright © 2020 yasuo. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController
import RxSwift
import Localize_Swift

enum HomeTabBarItem: Int{
    case home,circle,shortVideo,liveBroadcast,mine
    
    private func controller(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
        switch self {
        case .home:
            let vc = HomeViewController(viewModel: viewModel, navigator: navigator)
            return NavigationController(rootViewController: vc)
        case .circle:
            let vc = UIViewController()
            return NavigationController(rootViewController: vc)
        case .shortVideo:
            let vc = UIViewController()
            return NavigationController(rootViewController: vc)
        case .liveBroadcast:
            let vc = UIViewController()
            return NavigationController(rootViewController: vc)
        case .mine:
            let vc = UIViewController()
            return NavigationController(rootViewController: vc)
        }
    }
    
    var title: String {
        switch self {
        case .home: return R.string.localizable.homeTabbarHomeTitle.key.localized()
        case .circle: return R.string.localizable.homeTabbarCircleTitle.key.localized()
        case .shortVideo: return R.string.localizable.homeTabbarShortVideoTitle.key.localized()
        case .liveBroadcast: return R.string.localizable.homeTabbarLiveBroadcastTitle.key.localized()
        case .mine: return R.string.localizable.homeTabbarMineTitle.key.localized()
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home: return UIImage()
        case .circle: return UIImage()
        case .shortVideo: return UIImage()
        case .liveBroadcast: return UIImage()
        case .mine: return UIImage()
        }
    }
    
    var animation: RAMItemAnimation {
        var animation: RAMItemAnimation
        switch self {
        case .home: animation = RAMFlipLeftTransitionItemAnimations()
        case .circle: animation = RAMBounceAnimation()
        case .shortVideo: animation = RAMBounceAnimation()
        case .liveBroadcast: animation = RAMRightRotationAnimation()
        case .mine: animation = RAMBounceAnimation()
        }
        _ = themeService.rx
            .bind({ $0.secondary }, to: animation.rx.iconSelectedColor)
            .bind({ $0.secondary }, to: animation.rx.textSelectedColor)
        return animation
    }
    
    func getController(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
        let vc = controller(with: viewModel, navigator: navigator)
        let item = RAMAnimatedTabBarItem(title: title, image: image, tag: rawValue)
        item.animation = animation
        _ = themeService.rx
                   .bind({ $0.text }, to: item.rx.iconColor)
                   .bind({ $0.text }, to: item.rx.textColor)

       vc.tabBarItem = item
       return vc
    }
    
}


class HomeTabBarController: RAMAnimatedTabBarController, Navigatable {
    
    var viewModel: HomeTabBarViewModel?
    var navigator: Navigator!
    
    init(viewModel: ViewModel?, navigator: Navigator) {
        self.viewModel = viewModel as? HomeTabBarViewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindViewModel()
    }

    func makeUI() {
        hero.isEnabled = true
        tabBar.hero.id = "TabBarID"
        tabBar.isTranslucent = false
        
        NotificationCenter.default
            .rx.notification(NSNotification.Name(LCLLanguageChangeNotification))
            .subscribe { [weak self] (event) in
                self?.animatedItems.forEach({ (item) in
                    item.title = HomeTabBarItem(rawValue: item.tag)?.title
                })
                self?.setViewControllers(self?.viewControllers, animated: false)
                self?.setSelectIndex(from: 0, to: self?.selectedIndex ?? 0)
            }.disposed(by: rx.disposeBag)

        themeService.rx
            .bind({ $0.primaryDark }, to: tabBar.rx.barTintColor)
            .disposed(by: rx.disposeBag)

        themeService.typeStream.delay(DispatchTimeInterval.milliseconds(700), scheduler: MainScheduler.instance).subscribe(onNext: { (theme) in
            switch theme {
            case .light(let color), .dark(let color):
                self.changeSelectedColor(color.color, iconSelectedColor: color.color)
            }
        }).disposed(by: rx.disposeBag)
    }
    
    func bindViewModel(){
        guard let viewModel = viewModel else { return }
        let input = HomeTabBarViewModel.Input()
        let output = viewModel.transform(input: input)

        output.tabBarItems.drive(onNext: { [weak self] (tabBarItems) in
            if let strongSelf = self {
                let controllers = tabBarItems.map { $0.getController(with: viewModel.viewModel(for: $0), navigator: strongSelf.navigator) }
                strongSelf.setViewControllers(controllers, animated: false)
            }
        }).disposed(by: rx.disposeBag)
    }
}
