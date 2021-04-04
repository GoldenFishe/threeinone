import SpriteKit

class Cell {
    
    var node: SKShapeNode?;
    var block: Block?;
    var position: CGPoint;
    var size: CGRect;
    
    init(size: CGRect, position: CGPoint) {
        self.node = SKShapeNode(rect: size);
        self.position = position;
        self.node?.strokeColor = UIColor.green;
        self.size = size;
    }
    
    public func hasBlock() -> Bool {
        return self.block != nil;
    }
    
    public func addBlock() {
        let position = CGPoint(x: self.size.width/2 + self.position.x, y: self.size.height/2 + self.position.y)
        self.block = Block(color: UIColor.red, position: position);
        self.node?.scene?.addChild(self.block!);
    }
}
