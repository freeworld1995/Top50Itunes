//
//  DataSource.swift
//  TopItunes
//
//  Created by Jimmy Hoang on 1/27/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class DataSource: NSObject {
    
    var songs = [Song]()
    
    func getData(completion: @escaping () -> Void) {
        let url = URL(string: "https://itunes.apple.com/us/rss/topsongs/limit=50/genre=1/explicit=true/json")
        
        let dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            let jsonData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String, Any>
            let feed = jsonData["feed"] as! Dictionary<String, Any>
            let entry = feed["entry"] as! [Dictionary<String, Any>]
            
            for i in 0...49 {
                let imName = entry[i]["im:name"] as! Dictionary<String, Any>
                let name = imName["label"] as! String
                
                let imArtist = entry[i]["im:artist"] as! Dictionary<String, Any>
                let artist = imArtist["label"] as! String
                
                let imPrice = entry[i]["im:price"] as! Dictionary<String, Any>
                let price  = imPrice["label"] as! String
                
                let imImage = entry[i]["im:image"] as! [Dictionary<String, Any>]
                let imageUrl = imImage[0]["label"] as! String
                
                let song = Song(name: name, artist: artist, imageUrl: imageUrl, price: price)
                self.songs.append(song)
//                print(self.songs.count)

            }
        }
        dataTask.resume()
        
        DispatchQueue.main.async {
            completion()
        }
    }
    
}

extension DataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let name = songs[indexPath.row].name, let price = songs[indexPath.row].price else { return nil }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongCell
        let song = songs[indexPath.row]
        
        cell.title.text = "\(song.name!)"
        cell.artist.text = "\(song.artist!)"
        cell.price.setTitle("\(song.price!)", for: .normal)

        cell.songImage.sd_setImage(with: URL(string: song.imageUrl!))
        
        return cell
    }
}
