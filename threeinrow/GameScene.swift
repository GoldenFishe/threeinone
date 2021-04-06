import SpriteKit

class GameScene: SKScene {
    
    private let blockColors = [UIColor.red, UIColor.green, UIColor.blue];
    private let blockTypes = [0, 1, 2];
    private var matrix = Maxtix(cols: 10, rows: 10);

    override func didMove(to view: SKView) {
        self.fillMatrix();
        self.collapse();
    }
    
    private func fillMatrix() {
        let width = 30;
        let height = 30;
        for row in 0..<matrix.rows {
            for col in 0..<matrix.cols {
                let type = self.blockTypes.randomElement();
                let color = self.blockColors[type!];
                let rect =  CGRect(x: row * width, y: col * height, width: width, height: height);
                let cell = Cell(size: rect, position: CGPoint(x: row * width, y: col * height));
                self.addChild(cell);
                cell.addBlock(color: color, type: type!);
                matrix[row, col] = cell.block;
            }
        }
    }
    
    private func collapse() {
        let MIN_LEGNTH = 3;
        
        for row in 0..<matrix.rows {
            var startRangeCol = 0;
            var endRangeCol = startRangeCol + 1;
            var range: [Block] = [];
            
            while startRangeCol < matrix.cols && endRangeCol < matrix.cols {
                let startRangeBlock = matrix[row, startRangeCol];
                let endRangeBlock = matrix[row, endRangeCol];
                range.append(startRangeBlock!);
                
                if startRangeBlock?.type == endRangeBlock?.type {
                    print(startRangeBlock?.type == endRangeBlock?.type);
                    range.append(endRangeBlock!);
                    endRangeCol += 1;
                } else {
                    if (range.count >= MIN_LEGNTH) {
                        for block in range {
                            // block.removeFromParent();
                            block.alpha = 0.1
                        }
                    }
                    range = [];
                    startRangeCol += 1;
                    endRangeCol += 1;
                }
                print("start: \(startRangeCol)");
                print("end: \(endRangeCol)");
            }
//            print("row: \(row)");
        }
//        while currentRow < matrix.rows && currentCol < matrix.cols {
//            while currentRow < matrix.rows {
//
//            }
//            currentRow += 1;
//            currentCol += 1;
//        }
    }
}
