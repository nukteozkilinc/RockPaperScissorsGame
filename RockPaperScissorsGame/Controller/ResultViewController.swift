import UIKit

class ResultViewController: ViewController {
    
    var state : GameState = .draw
    var myChoice : Game = .scissors
    var computerChoice : Game = .scissors
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var computerImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Game Result"
        
        switch state{
        case .draw :
            resultLabel.text = "Did you read my mind ?!"
        case .lose :
            resultLabel.text = " I won"
        case .win :
            resultLabel.text = "You were just lucky :("
        default :
            break 
        }
        changeMyImages(choice: myChoice)
        changePCImages(choice: computerChoice)
    }

    func changeMyImages(choice : Game){
        switch choice {
        case .rock:
        myImage.image = UIImage(named: "rock")
        case .paper:
        myImage.image = UIImage(named: "paper")
        case .scissors:
        myImage.image = UIImage(named: "scissors")
        default :
            break
        }
    }
    
    func changePCImages(choice : Game){
        switch choice {
        case .rock:
        computerImage.image = UIImage(named: "rock")
        case .paper:
        computerImage.image = UIImage(named: "paper")
        case .scissors:
        computerImage.image = UIImage(named: "scissors")
        default :
            break
        }
    }
}
