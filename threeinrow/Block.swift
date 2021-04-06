import SpriteKit

class Block: SKSpriteNode {
    
    static public let size = CGSize(width: 20, height: 20);
    public var type: Int?;
    
    init(color: UIColor, position: CGPoint, type: Int) {
        super.init(texture: nil, color: color, size: Block.size);
        self.position = position;
        self.type = type;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
