//
//  PlaylistViewModel.swift
//  MovieIMDB
//
//  Created by Prakhar Garg on 24/09/23.
//

import Foundation
import CoreData

class PlaylistViewModel {
    private let context = CoredataContainer.shared.persistentContainer.viewContext

    // Fetch existing playlists
    func fetchPlaylists() -> [Playlist] {
        let fetchRequest: NSFetchRequest<Playlist> = Playlist.fetchRequest()
        
        do {
            let playlists = try context.fetch(fetchRequest)
            return playlists
        } catch {
            print("Error fetching playlists: \(error.localizedDescription)")
            return []
        }
    }

    // Create a new playlist
    func createPlaylist(name: String) {
        let newPlaylist = Playlist(context: context)
        newPlaylist.name = name
        
        do {
            try context.save()
        } catch {
            print("Error creating playlist: \(error.localizedDescription)")
        }
    }
}
