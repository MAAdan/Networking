//
//  ViewController.swift
//  Networking
//
//  Created by Miguel Angel Adan Roman on 23/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

class OptionsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "toArticlesViewController", sender: nil)
        default:
            break
        }
    }
}

