//
//  Photo.swift
//
//  Created by Mustafa on 11/15/18
//  Copyright (c) Mustafa. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Photo {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let albumId = "albumId"
    static let title = "title"
    static let id = "id"
    static let url = "url"
    static let thumbnailUrl = "thumbnailUrl"
  }

  // MARK: Properties
  public var albumId: Int?
  public var title: String?
  public var id: Int?
  public var url: String?
  public var thumbnailUrl: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    albumId = json[SerializationKeys.albumId].int
    title = json[SerializationKeys.title].string
    id = json[SerializationKeys.id].int
    url = json[SerializationKeys.url].string
    thumbnailUrl = json[SerializationKeys.thumbnailUrl].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = albumId { dictionary[SerializationKeys.albumId] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = thumbnailUrl { dictionary[SerializationKeys.thumbnailUrl] = value }
    return dictionary
  }

}
