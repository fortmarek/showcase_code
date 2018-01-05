//
//  LeaderboardViewControllerTests.swift
//  CardsTests
//
//  Created by Marek Fořt on 10/14/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import XCTest
@testable import Elisa
import UIKit

class LeaderboardViewControllerTests: XCTestCase {
    
    let leaderboardViewController = LeaderboardViewController()
    
    let friendsUserOne = LeaderboardUser(id: 0, name: "", points: 10, picture: "")
    let friendsUserTwo = LeaderboardUser(id: 1, name: "", points: 20, picture: "")
    let geoUserOne = LeaderboardUser(id: 2, name: "", points: 30, picture: "")
    let geoUserTwo = LeaderboardUser(id: 3, name: "", points: 40, picture: "")
    
    override func setUp() {
        super.setUp()
        leaderboardViewController.preloadView()
        
        leaderboardViewController.leaderboardViewModel.friends.value = [friendsUserOne, friendsUserTwo]
        let geoLeaderboard = GeoLeaderboard(title: "World", geoUsers: [geoUserOne, geoUserTwo])
        leaderboardViewController.leaderboardViewModel.geoLeaderboard.value = geoLeaderboard
        leaderboardViewController.leaderboardCollectionView?.reloadData()
    }
    
    
    
    
}
