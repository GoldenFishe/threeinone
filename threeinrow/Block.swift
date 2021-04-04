import SpriteKit

class Block: SKSpriteNode {
    
    static public let size = CGSize(width: 10, height: 10);
    
    init(color: UIColor, position: CGPoint) {
        super.init(texture: nil, color: color, size: Block.size);
        self.position = position;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
