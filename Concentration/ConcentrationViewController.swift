import UIKit

class ConcentrationViewController: VCLLoggingViewController {
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCcountLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    private var emojiChoices = "👻😼👻👹🐿🐶🐷🦉"
    private var emoji = Dictionary<Card, String>()
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var theme:  String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    override var vclLoggingName: String {
        return "Game"
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCcountLabel()
        }
    }
    
    private func updateFlipCcountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.black
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                } else {
                    button.setTitle("", for: .normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9356139898, green: 0.539589107, blue: 0.01415602397, alpha: 0) : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                }
            }
        }
    }
    
    private func emoji(for card: Card) -> String? {
        if emoji[card] == nil, emojiChoices.count > 0  {
            let randomStringInex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringInex))
        }
        return emoji[card] ?? "?"
    }
}

