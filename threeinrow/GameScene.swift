import SpriteKit

class GameScene: SKScene {
    
    private var cells: [Cell] = [];
    
    override func didMove(to view: SKView) {
        self.addGrid();
        self.fillCells();
    }
    
    private func addGrid() {
        let width = 20;
        let height = 20;
        for x in -5...5 {
            for y in -5...5 {
                let rect =  CGRect(x: x * width, y: y * height, width: width, height: height);
                let cell = Cell(size: rect, position: CGPoint(x: x * width, y: y * height));
                self.cells.append(cell);
                self.addChild(cell.node!);
            }
        }
    }
    
    private func fillCells() {
        for cell in self.cells {
            cell.addBlock();
        }
    }
}
