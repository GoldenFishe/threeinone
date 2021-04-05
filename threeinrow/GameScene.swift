import SpriteKit

class GameScene: SKScene {
    
    private let types = [UIColor.red, UIColor.green, UIColor.blue];
    private let matrix = Maxtix(cols: 10, rows: 10);

    override func didMove(to view: SKView) {
        self.fillMatrix();
    }
    
    private func fillMatrix() {
        let width = 30;
        let height = 30;
        for row in 0...matrix.rows {
            for col in 0...matrix.cols {
                let type = self.types.randomElement();
                let rect =  CGRect(x: row * width, y: col * height, width: width, height: height);
                let cell = Cell(size: rect, position: CGPoint(x: row * width, y: col * height));
                cell.addBlock(color: type!, type: type!);
                self.addChild(cell);
            }
        }
    }
    
//    private func collapse() {
//        var startPoint = 0;
//        var endPoint = startPoint + 1;
//        let currentBlock = self.matrix[0,0];
//    }
}
