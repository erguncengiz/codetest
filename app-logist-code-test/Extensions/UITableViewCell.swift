//
//  UITableViewCell.swift
//  app-logist-code-test
//
//  Created by Ergün Yunus Cengiz on 8.12.2022.
//

import UIKit

extension UITableViewCell {
    
    static func identifier() -> String {
        String(describing: self)
    }
    
    static func reusable (for tableView: UITableView, indexPath: IndexPath) -> Self? {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier(), for: indexPath) as? Self
        return cell
    }
    
    static func registerWithNib(to tableView: UITableView?) {
        tableView?.register(UINib(nibName: identifier(), bundle: nil), forCellReuseIdentifier: identifier())
    }
    
    static func registerWithoutNib(to tableView: UITableView?) {
        tableView?.register(self, forCellReuseIdentifier: identifier())
    }
}
