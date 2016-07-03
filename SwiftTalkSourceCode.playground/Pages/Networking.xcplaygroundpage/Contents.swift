//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

struct Epsiode {}

struct Media {}

struct Resource<A> {
    let url: URL
    let parse: (Data) -> A?
}

let url = URL(string: "")!

let episodeesResource = Resource<Data>(url: url) {
    data in
    return data
}

final class WebService {
    let session = URLSession.shared()
    
    func loadEpisodes(completion: ([Epsiode]?) -> ()) {
        
    }
    
    func loadMedia(episode: Epsiode, completion: (Media?) -> ()) {
        
    }
}


