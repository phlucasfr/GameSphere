//
//  Constants.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 06/06/23.
//

import Firebase
import FirebaseStorage

//Storage
let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

//Database
let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("Users")
