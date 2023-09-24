//
//  PlaylistSheetView.swift
//  MovieIMDB
//
//  Created by Prakhar Garg on 24/09/23.
//

import UIKit

class PlaylistSheetView: UIView {
    private let viewModel = PlaylistViewModel()
    private var playlists: [Playlist] = []

    private let tableView = UITableView()
    private let playlistNameTextField = UITextField()
    private let createPlaylistButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        fetchExistingPlaylists()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Configure UI elements (e.g., table view, text field, and button)
        // Implement layout constraints
        // Implement actions for creating playlists
    }

    func fetchExistingPlaylists() {
        playlists = viewModel.fetchPlaylists()
        tableView.reloadData()
    }

    func createNewPlaylist() {
        if let playlistName = playlistNameTextField.text, !playlistName.isEmpty {
            viewModel.createPlaylist(name: playlistName)
            fetchExistingPlaylists()
            playlistNameTextField.text = ""
        }
    }

    // Implement UITableViewDelegate and UITableViewDataSource methods for displaying playlists
}


