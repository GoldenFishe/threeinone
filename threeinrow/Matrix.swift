struct Maxtix {
    
    public var rows: Int;
    public var cols: Int;
    private var grid: Array<Array<Block?>>;
    
    init(cols: Int, rows: Int) {
        self.cols = cols;
        self.rows = rows;
        grid = Array(repeating: Array(repeating: nil, count: cols), count: rows);
    }
    
    subscript(row: Int, col: Int) -> Block? {
        get {
            return grid[row][col];
        }
        set {
            grid[row][col] = newValue;
        }
    }
    
    func getRow(row: Int) -> Array<Block?> {
        return grid[row];
    }
}
