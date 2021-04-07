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
    
    public func destroy() {
        let scaleUp = SKAction.scale(to: 1.1, duration: 1);
        let scaleDown = SKAction.scale(to: 0, duration: 0.5);
        let remove = SKAction.removeFromParent();
        let actions = SKAction.sequence([scaleUp, scaleDown, remove]);
        self.run(actions);
    }
    
    public func addLabel(text: String) {
        let label = SKLabelNode(text: text);
        label.fontSize = 19;
        label.fontColor = UIColor.yellow;
        self.addChild(label);
    }
}
