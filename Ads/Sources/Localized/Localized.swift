//
//  Localized.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Foundation

enum Localized {
    enum Ads {
        enum Details {
            enum Description {
                static let title = NSLocalizedString("ads.details.description.title", bundle: .module, comment: "")
            }

            enum Posted {
                static func value(_ param: String) -> String {
                    let format = NSLocalizedString("ads.details.posted.value", bundle: .module, comment: "")
                    return String(format: format, param)
                }
            }
        }

        enum List {
            enum Item {
                static let urgent = NSLocalizedString("ads.list.item.urgent", bundle: .module, comment: "")
            }

            static let title = NSLocalizedString("ads.list.title", bundle: .module, comment: "")
        }
    }
}
