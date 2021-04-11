import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private let blockColors = [UIColor.red, UIColor.green, UIColor.blue];
    private let blockTypes = [0, 1, 2];
    private var matrix = Maxtix(cols: 10, rows: 10);

    override func didMove(to view: SKView) {
        self.setupWorld();
        self.addInitialBlocks();
        self.findSequence();
    }
    
    private func setupWorld() {
        self.view?.showsPhysics = true;
        self.backgroundColor = .black;
        self.physicsWorld.contactDelegate = self;
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame);
    }
    
    private func addInitialBlocks() {
        for row in 0..<matrix.rows {
            for col in 0..<matrix.cols {
                let type = self.blockTypes.randomElement();
                let color = self.blockColors[type!];
                let blockPosition = CGPoint(x: row * Int(Block.size.width) + Int(Block.size.width) / 2, y: col * Int(Block.size.height) + Int(Block.size.height) / 2);
                let matrixCoordinates = MatrixCoordinates(row: row, col: col);
                let block = Block(color: color, position: blockPosition, type: type!, matrixCoordinates: matrixCoordinates);
                block.addLabel(text: "\(row)/\(col)");
                matrix[row, col] = block;
                self.addChild(block);
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
                        self.moveAdjacentBlocks();
                        self.fillEmptyCells();
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


    private func moveAdjacentBlocks() {
        for row in 0..<matrix.rows {
            for col in 0..<matrix.cols {
                let currentBlock = matrix[row, col];
                if (currentBlock == nil) {

                }
            }
        }
    }

    private func fillEmptyCells() {

    }
    
    //    private func collapse() {
    //        let MIN_LEGNTH = 3;
    //        var range: [Block] = [];
    //
    //        for row in 0..<matrix.rows {
    //
    //            if (range.count >= MIN_LEGNTH) {
    //                for block in range {
    //                    block.destroy();
    //                }
    //            }
    //
    //            var startRangeCol = 0;
    //            var endRangeCol = startRangeCol + 1;
    //            range = [];
    //
    //            while startRangeCol < matrix.cols && endRangeCol < matrix.cols {
    //                let startRangeBlock = matrix[row, startRangeCol];
    //                let endRangeBlock = matrix[row, endRangeCol];
    //
    //                if startRangeBlock?.type == endRangeBlock?.type {
    //                    if (range.count == 0) {
    //                        range.append(startRangeBlock!);
    //                    }
    //                    range.append(endRangeBlock!);
    //                    endRangeCol += 1;
    //                } else {
    //                    if (range.count >= MIN_LEGNTH) {
    //                        for block in range {
    //                            block.destroy();
    //                        }
    //                    }
    //                    range = [];
    //                    startRangeCol = endRangeCol;
    //                    endRangeCol += 1;
    //                }
    //            }
    //        }
    //    }
    //
}
