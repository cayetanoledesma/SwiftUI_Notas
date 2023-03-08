//
//  NoteModel.swift
//  NotasMVVM
//
//  Created by estech on 6/3/23.
//

import Foundation

struct NoteModel: Codable {
    let id:  String //Inicio de la nota
    let description: String //Contenido de la nopta
    var isFavorite: Bool
    init(id: String = UUID().uuidString, isFavorite:Bool = false, description: String){
        self.id = id
        
        self.isFavorite = isFavorite
        self.description = description
    }
}
