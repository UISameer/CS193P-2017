import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🪀🏒🏸⛳️🤿🏹🥊🛼",
        "Animals": "🐶🐭🐼🦁🐸🙊🐷🐽🐨🐣🐥🦆",
        "Faces": "😀🥲😍🥰😘😌😇🤣🤓🥳🥸🤨"
    ]
    
    override class func awakeFromNib() {
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    // MARK: - Navigation
    
    @IBAction func performSegue(_ sender: Any) {
        if let cvc = splitDetailCVC {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcenntrationVC {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        else {
            performSegue(withIdentifier: "choose theme", sender: sender)
        }
    }
    
    private var lastSeguedToConcenntrationVC: ConcentrationViewController?
    
    private var splitDetailCVC: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "choose theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcenntrationVC = cvc
                }
            }
        }
    }
}
