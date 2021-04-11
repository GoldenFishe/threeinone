import SpriteKit

struct MatrixCoordinates {
    var row: Int;
    var col: Int;
}

class Block: SKSpriteNode {
    
    static public let size = CGSize(width: 30, height: 30);
    public var type: Int?;
    public var matrixCoordinates: MatrixCoordinates?;
    
    init(color: UIColor, position: CGPoint, type: Int, matrixCoordinates: MatrixCoordinates) {
        super.init(texture: nil, color: color, size: Block.size);
        self.position = position;
        self.matrixCoordinates = matrixCoordinates;
        self.type = type;
        self.physicsBody = SKPhysicsBody(rectangleOf: Block.size);
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
