//
//  Song.swift
//  PlaylistNSUserDefaults
//
//  Created by Karl Pfister on 5/19/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class Song: NSManagedObject {

    convenience init?(songName: String, artistName: String, playlist: Playlist, context: NSManagedObjectContext =
        Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entityForName("Song", inManagedObjectContext: context) else {
            return nil
        }
    self.init(entity: entity, insertIntoManagedObjectContext: context)
    
    self.songName = songName
    self.artistName = artistName
    self.playlist = playlist
    }

}
