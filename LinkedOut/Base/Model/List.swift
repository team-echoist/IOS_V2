//
//  List.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import Foundation

struct List<Element> {
  var items: [Element]
  var nextURL: URL?

  init(items: [Element], nextURL: URL? = nil) {
    self.items = items
    self.nextURL = nextURL
  }
}
