import SpriteKit

class GameScene: SKScene {
    
    private let blockColors = [UIColor.red, UIColor.green, UIColor.blue];
    private let blockTypes = [0, 1, 2];
    private var matrix = Maxtix(cols: 10, rows: 10);

    override func didMove(to view: SKView) {
        self.setupWorld();
        self.addInitialBlocks();
        self.findSequence();
    }
    
    private func setupWorld() {
        self.backgroundColor = .black;
    }
    
    private func addInitialBlocks() {
        for row in 0..<matrix.rows {
            for col in 0..<matrix.cols {
                self.addBlock(row: row, col: col);
            }
        }
    }
    
    private func findSequence() {
        let MIN_LEGNTH = 3;
        var range: [Block] = [];

        searhCycle: for row in 0..<matrix.rows {

            var startRangeCol = 0;
            var endRangeCol = startRangeCol + 1;

            while startRangeCol < matrix.cols && endRangeCol < matrix.cols {
                let startRangeBlock = matrix[row, startRangeCol];
                let endRangeBlock = matrix[row, endRangeCol];

                if startRangeBlock?.type == endRangeBlock?.type {
                    if (range.count == 0) {
                        range.append(startRangeBlock!);
                    }
                    range.append(endRangeBlock!);
                    endRangeCol += 1;
                } else {
                    if (range.count >= MIN_LEGNTH) {
                        self.destroyBlocks(blocks: range);
                        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveAdjacentBlocks), userInfo: range, repeats: false);
                        break searhCycle;
                    }
                    range = [];
                    startRangeCol = endRangeCol;
                    endRangeCol += 1;
                }
            }
        }
    }

    private func destroyBlocks(blocks: [Block]) {
        for block in blocks {
            block.destroy();
            let blockMatrixCoordinates = block.matrixCoordinates!;
            matrix[blockMatrixCoordinates.row, blockMatrixCoordinates.col] = nil;
        }
    }

    @objc private func moveAdjacentBlocks(timer: Timer) {
        let range = timer.userInfo as! [Block];
        let lastBlockInRange = range.last!;
        let matrixRow = matrix.getRow(row: lastBlockInRange.matrixCoordinates!.row);
        var blocksForMove: [Block] = [];
        for block in matrixRow {
            if block != nil && (block?.matrixCoordinates!.col)! > lastBlockInRange.matrixCoordinates!.col {
                blocksForMove.append(block!);
            }
        }
        for block in blocksForMove {
            matrix[block.matrixCoordinates!.row, block.matrixCoordinates!.col] = nil;
            let size = Int(self.frame.width) / matrix.rows;
            let row = block.matrixCoordinates!.row;
            let col = block.matrixCoordinates!.col - range.count;
            let blockPosition = CGPoint(x: row * size + size / 2, y: col * size + size / 2);
            block.moveTo(to: blockPosition);
            matrix[row, col] = block;
        }
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fillEmptyCells), userInfo: nil, repeats: false);
    }


    @objc private func fillEmptyCells() {
        for row in 0..<matrix.rows {
            for col in 0..<matrix.cols {
                let currentBlock = matrix[row, col];
                if (currentBlock == nil) {
                    self.addBlock(row: row, col: col);
                }
            }
        }
        self.findSequence();
    }
    
    private func addBlock(row: Int, col: Int) {
        let size = Int(self.frame.width) / matrix.rows;
        let blockSize = CGSize(width: size, height: size);
        let type = self.blockTypes.randomElement();
        let color = self.blockColors[type!];
        let blockInitialPosition = CGPoint(x: row * size + size / 2, y: 700);
        let blockPosition = CGPoint(x: row * size + size / 2, y: col * size + size / 2);
        let matrixCoordinates = MatrixCoordinates(row: row, col: col);
        let block = Block(color: color, size: blockSize, position: blockInitialPosition, type: type!, matrixCoordinates: matrixCoordinates);
        block.addLabel(text: "\(row)/\(col)");
        block.moveTo(to: blockPosition);
        matrix[row, col] = block;
        self.addChild(block);
    }
}
