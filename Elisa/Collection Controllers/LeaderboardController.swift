//
//  LeaderboardController.swift
//  Cards
//
//  Created by Marek Fořt on 10/10/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

class LeaderboardController: UICollectionViewFlowLayout, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var delegateView: UIView?
    weak var presentDelegate: PresentDelegate?
    var cellWidth: CGFloat = 0
    weak var superNavigationController: UINavigationController?
    var friends: [LeaderboardUser] = []
    var geoUsers: [LeaderboardUser] = []
    var geoTitle: String = ""
    private var friendsDidConfetti: Bool = false
    private var geoUsersDidConfetti: Bool = false
    var inviteFriendsButton = UIButton()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let users = geoUsers
        let leaderboardCell: LeaderboardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "leaderboardCell", for: indexPath) as! LeaderboardCollectionViewCell
        let leaderboardUser = users[indexPath.row]
        leaderboardCell.nameLabel.text = leaderboardUser.name
        leaderboardCell.pointsLabel.text = L10n.User.points(leaderboardUser.points)
        leaderboardCell.rankLabel.text = String(indexPath.row + 1)
        let proxyLabel = UILabel()
        proxyLabel.text = leaderboardCell.rankLabel.text
        proxyLabel.font = leaderboardCell.rankLabel.font
        proxyLabel.sizeToFit()
        leaderboardCell.rankLabelWidthAnchor?.constant = max(proxyLabel.frame.width + 12, 32)
        
        //TODO: Base on rank, not indexPath.row
        let defaultImage = indexPath.row == 0 ? UIImage(asset: Asset.profileDefaultWhite) : UIImage(asset: Asset.profileDefault)
        leaderboardCell.userImageView.bind(with: users[indexPath.row].imageModel, animated: false, defaultImage: defaultImage)
        
        
        switch indexPath.row {
        case 0:
            setFirstCell(leaderboardCell, with: indexPath, collectionView: collectionView)
        case 1...2:
            leaderboardCell.setMedalPlace()
        default:
            leaderboardCell.setNormalPlace()
        }
        
        
        return leaderboardCell
    }
    
    private func setFirstCell(_ leaderboardCell: LeaderboardCollectionViewCell, with indexPath: IndexPath, collectionView: UICollectionView) {
        leaderboardCell.setFirstPlace(didConfetti: geoUsersDidConfetti)
        if geoUsersDidConfetti == false {
            DispatchQueue.main.async(after: 4, execute: {[weak self] in
                self?.geoUsersDidConfetti = true
            })
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return geoUsers.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //If is iPad, never confetti (performance isues)
        friendsDidConfetti = AppDelegate.isiPad
        geoUsersDidConfetti = AppDelegate.isiPad
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView: UICollectionReusableView = UICollectionReusableView()
        
        if kind == UICollectionElementKindSectionHeader {
            let leaderboardHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "leaderboardHeader", for: indexPath) as! LeaderboardHeader
            leaderboardHeader.headerTitleLabel.text = geoTitle
            reusableView = leaderboardHeader
        }
        
        
        return reusableView
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 300, height: 55)
    }
    
    @objc private func shareApp() {
        guard let presentDelegate = self.presentDelegate as? UIViewController else {return}
        presentDelegate.share(title: L10n.General.shareApp, sourceView: inviteFriendsButton, completion: nil)
    }
}

class InviteFriendsFooter: UICollectionReusableView {
    
    let inviteFriendsButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        inviteFriendsButton.setTitle(L10n.Leaderboard.inviteFriends, for: .normal)
        inviteFriendsButton.setTitleColor(.cornflower, for: .normal)
        inviteFriendsButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        inviteFriendsButton.layer.borderColor = UIColor.cornflower.cgColor
        inviteFriendsButton.layer.borderWidth = 2
        inviteFriendsButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(inviteFriendsButton)
        inviteFriendsButton.centerInView(self)
        inviteFriendsButton.sizeToFit()
        inviteFriendsButton.heightAnchor.constraint(equalToConstant: inviteFriendsButton.frame.height + 6).isActive = true
        inviteFriendsButton.layer.cornerRadius = (inviteFriendsButton.frame.height + 6) / 2
        inviteFriendsButton.widthAnchor.constraint(equalToConstant: inviteFriendsButton.frame.width + 60).isActive = true
        

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LeaderboardHeader: UICollectionReusableView {
    
    let headerTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        headerTitleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        headerTitleLabel.textColor = .defaultTextColor
        headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerTitleLabel)
        headerTitleLabel.centerInView(self)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LeaderboardController: UICollectionViewDelegate {
    
}

extension LeaderboardController: UICollectionViewDataSourcePrefetching, ImagePrefetchable {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        prefetchPreviewsAt(indexPaths)
    }
    
    func prefetchPreviewsAt(_ indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let users = indexPath.section == 0 ? friends : geoUsers
            let imageModel = users[indexPath.row].imageModel
            imageModel.setPreviewImage(path: imageModel.picture)
        }
    }
}



