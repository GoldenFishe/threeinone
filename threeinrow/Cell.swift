import SpriteKit

class Cell: SKShapeNode {
    
    var block: Block?;
    var size: CGRect?;
    var pos: CGPoint?;
    
    init(size: CGRect, position: CGPoint) {
        super.init();
        self.pos = position;
        self.strokeColor = UIColor.white;
        self.size = size;
        self.path = CGPath(rect: size, transform: nil);
        self.block = nil;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func hasBlock() -> Bool {
        return self.block != nil;
    }
    
    public func addBlock(color: UIColor, type: Int) {
        let position = CGPoint(x: self.size!.width/2 + self.pos!.x, y: self.size!.height/2 + self.pos!.y)
        self.block = Block(color: color, position: position, type: type);
        self.scene?.addChild(self.block!);
    }
}
