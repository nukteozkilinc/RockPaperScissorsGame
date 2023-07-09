import UIKit

class GameViewController: ViewController {
    
    var myScore : Int = 0
    var pcScore : Int = 0
    var gameState : GameState = .draw
    var myChoice : Game = .scissors
    var computerChoice : Game = .scissors
    var imageArray : [UIImage] = []
    
    
    @IBOutlet weak var myScoreLabel: UILabel!
    @IBOutlet weak var pcScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Rock Paper Scissors"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(pressedReset))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myScoreLabel.text = "My Score : \(myScore)"
        pcScoreLabel.text = "Computer Score : \(pcScore)"
    }
    
    
    func getRandomChoice() -> Game{
        let choice : [Game] = [.paper,.rock,.scissors]
        let randomIndex = Int.random(in: 0..<choice.count)
        let randomValue = choice[randomIndex]
        print(randomValue.rawValue)
        return Game(rawValue: randomValue.rawValue)!
    }
    
    @IBAction func pressedChoice(_ sender: UIButton){
       
        switch sender.restorationIdentifier {
        case "0":
            gameState(myChoice: .rock)
            myChoice = .rock
            showActivityIndicatory()
        case "1":
            gameState(myChoice: .paper)
            myChoice = .paper
            showActivityIndicatory()
        case "2":
            gameState(myChoice: .scissors)
            myChoice = .scissors
            showActivityIndicatory()
        default :
            break
        }
    }
    
    func gameState(myChoice : Game) {
        let pcChoice : Game = getRandomChoice()
        computerChoice = pcChoice
        
        print("PC : \(pcChoice)")
        print("My : \(myChoice)")

        if (myChoice == .rock && pcChoice == .scissors) ||
            (myChoice == .paper && pcChoice == .rock) ||
            (myChoice == .scissors && pcChoice == .paper) {
            gameState = .win
            myScore += 1
            print(myScore)
         }else if myChoice == pcChoice{
            gameState = .draw
         }else{
             gameState = .lose
             pcScore += 1
         }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ResultViewController
        destinationVC.state = gameState
        destinationVC.myChoice = myChoice
        destinationVC.computerChoice = computerChoice
    }
    
    @objc func pressedReset() {
        let alert = UIAlertController(title: "Are you sure?", message: "You are gonna reset the game.", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                switch action.style{
                                case .default:
                                    self.myScore = 0
                                    self.pcScore = 0
                                    self.myScoreLabel.text = "My Score : \(self.myScore)"
                                    self.pcScoreLabel.text = "Computer Score : \(self.pcScore)"
                                case .cancel:
                                    print("cancel")
                                case .destructive:
                                    print("destructive")
                                @unknown default:
                                    print("error")
                                }
                            }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                                switch action.style{
                                case .default:
                                    print("default")
                                case .cancel:
                                    print("cancel")
                                case .destructive:
                                    print("destructive")
                                @unknown default:
                                    print("error")
                                }
                            }))
                            self.present(alert, animated: true, completion: nil)
       
    }

    func showActivityIndicatory() {
        
        let container: UIView = UIView()
        container.frame = CGRect(x: 0, y: 300, width: 80, height: 80)
        container.backgroundColor = .clear
        
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .systemPink
        activityView.center = self.view.center
        
        container.addSubview(activityView)
        self.view.addSubview(container)
        
        activityView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8 ) {
            self.performSegue(withIdentifier: "GoToResult", sender: self)
            activityView.stopAnimating()
            }
        
        imageArray = createImgArray()
        
        
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 160, y: 600, width: 80, height: 80)
        view.addSubview(imageView)
        animate(imageView: imageView, images: imageArray)
   }
    
    func createImgArray() -> [UIImage] {
        imageArray = []
        
        imageArray.append(UIImage(named: "rock")!)
        imageArray.append(UIImage(named: "paper")!)
        imageArray.append(UIImage(named: "scissors")!)
        
        return imageArray
    }
    
    func animate(imageView : UIImageView, images : [UIImage]) {
        imageView.animationImages = images
        imageView.animationDuration = 1.0
        imageView.animationRepeatCount = 1
        imageView.startAnimating()
    }
}
