local Board = require "src.board"
local kalis = require "lib.kalis"
describe("Board Tests", function()
    local board
    local BOARD_HEIGHT = 15
    local BOARD_WIDTH = 10
    local CELL_SIZE = 40
    local START_OF_BOARD = 100

    before_each(function()
        board = Board:new(BOARD_WIDTH, BOARD_HEIGHT, CELL_SIZE, START_OF_BOARD)
    end)

    describe("new", function()
        it("Should create a list of the correct dimensions", function()
            assert.are.equal(#board, BOARD_HEIGHT - 1)
            assert.are.equal(#board[0], BOARD_WIDTH - 1)
        end)
        it("All cells should have neighbours", function()
            for _, row in kalis.ipairs(board) do
                for _, cell in kalis.ipairs(row) do
                    assert.are_not.equal(cell.neighbours[1], nil)
                end
            end
        end)
    end)
    describe("placeMines", function()
        pending("The correct number of mines should be placed")
        pending("No mines should be placed surrounding the clicked cell")
    end)
    describe("cells", function()
        pending("All cells should be iterated over")
    end)
    describe("getCell", function()
        pending("If x or y is out of range, no cell should be returned")
        pending("If x or y is unspecified, no cell should be returned")
        pending("Cell at the correct position should be returned")
    end)
    describe("getRandomCell", function()
        pending("Returned cell should be random")
    end)
    describe("mouseToCell", function()
        pending("If click is outside board area, no cell is returned")
        pending("If click is inside board area, the corresponding cell is returned")
    end)
    describe("mouseToBoard", function()
        pending("If click is outside board area, no coordinates are returned")
        pending("If click is inside board area, the corresponding coordinates are returned")
    end)
    describe("clear", function()
        pending("After clearing the board, all cells are checked")
    end)
    describe("isCleared", function()
        pending("If all cells are either checked or mines, the board is cleared")
        pending("If an unchecked non-mine cell exists, the board is not cleared")
    end)

end)
