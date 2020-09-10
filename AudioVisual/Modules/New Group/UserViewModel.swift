//
//  UserViewModel.swift
//  AudioVisual
//
//  Created by winpower on 2020/8/18.
//  Copyright © 2020 yasuo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class UserViewModel: ViewModel {
    let user: BehaviorRelay<User>
    
    
    init(user: User, provider: NetApi) {
        self.user = BehaviorRelay(value: user)
        super.init(provider: provider)
    }
}
