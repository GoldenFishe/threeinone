import SpriteKit

class Cell: SKShapeNode {
    
    var size: CGRect?;
    var pos: CGPoint?;
    
    init(size: CGRect, position: CGPoint) {
        super.init();
        self.pos = position;
        self.strokeColor = UIColor.white;
        self.size = size;
        self.path = CGPath(rect: size, transform: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
