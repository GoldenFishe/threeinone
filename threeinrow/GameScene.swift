import SpriteKit

class GameScene: SKScene {
    
    private let blockColors = [UIColor.red, UIColor.green, UIColor.blue];
    private let blockTypes = [0, 1, 2];
    private var matrix = Maxtix(cols: 10, rows: 10);

    override func didMove(to view: SKView) {
        self.fillMatrix();
        self.collapse();
        self.moveBlock();
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
                cell.block?.addLabel(text: "\(row)/\(col)");
                matrix[row, col] = cell.block;
            }
        }
    }
    
    private func collapse() {
        let MIN_LEGNTH = 3;
        var range: [Block] = [];
        
        for row in 0..<matrix.rows {
            
            if (range.count >= MIN_LEGNTH) {
                for block in range {
                    block.destroy();
                }
            }
            
            var startRangeCol = 0;
            var endRangeCol = startRangeCol + 1;
            range = [];
            
            print(row);
            while startRangeCol < matrix.cols && endRangeCol < matrix.cols {
                let startRangeBlock = matrix[row, startRangeCol];
                let endRangeBlock = matrix[row, endRangeCol];
                
                print("start: \(startRangeCol) end: \(endRangeCol)");
                print(startRangeBlock?.type == endRangeBlock?.type);
                
                if startRangeBlock?.type == endRangeBlock?.type {
                    if (range.count == 0) {
                        range.append(startRangeBlock!);
                    }
                    range.append(endRangeBlock!);
                    endRangeCol += 1;
                } else {
                    print("range: \(range.count)");
                    if (range.count >= MIN_LEGNTH) {
                        for block in range {
                            block.destroy();
                        }
                    }
                    range = [];
                    startRangeCol = endRangeCol;
                    endRangeCol += 1;
                }
            }
        }
    }
    
    private func moveBlock() {
        for row in 0..<matrix.rows {
            for col in 0..<matrix.cols {
                print(matrix[row, col] == nil)
            }
        }
    }
    
    private func addBlocks() {
        
    }
}
