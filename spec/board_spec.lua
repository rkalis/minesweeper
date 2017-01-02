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
        local mines_to_place = 20
        local cell
        before_each(function()
            cell = board:getRandomCell()
        end)
        it("The correct number of mines should be placed", function()
            -- Given
            local placed_mines = 0

            -- When
            board:placeMines(cell, mines_to_place)

            -- Then
            for cell in board:cells() do
                if cell.mine then
                    placed_mines = placed_mines + 1
                end
            end
            assert.are.equal(placed_mines, mines_to_place)

        end)
        it("No mines should be placed surrounding the clicked cell", function()
            -- When
            board:placeMines(cell, mines_to_place)

            -- Then
            assert.is_falsy(cell.mine)
            for _, neighbour in ipairs(cell.neighbours) do
                assert.is_falsy(neighbour.mine)
            end
        end)
    end)
    describe("cells", function()
        it("All cells should be iterated over", function()
            -- Given
            local tinsert = table.insert
            local iterated_cells = {}
            local cells_in_board = {}
            for _, row in kalis.ipairs(board) do
                for _, cell in kalis.ipairs(row) do
                    tinsert(cells_in_board, cell)
                end
            end

            -- When
            for cell in board:cells() do
                tinsert(iterated_cells, cell)
            end

            -- Then
            for _, cell in ipairs(cells_in_board) do
                assert.is_true(kalis.contains(iterated_cells, cell))
            end
            for _, cell in ipairs(iterated_cells) do
                assert.is_true(kalis.contains(cells_in_board, cell))
            end
        end)
    end)
    describe("getCell", function()
        it("If x or y is out of range, no cell should be returned", function()
            -- Given
            local out_of_range_x = BOARD_WIDTH + 1
            local out_of_range_y = BOARD_HEIGHT + 1
            local in_range_x = 1
            local in_range_y = 1

            -- When
            local cell_invalid_x = board:getCell(out_of_range_x, in_range_y)
            local cell_invalid_y = board:getCell(in_range_x, out_of_range_y)
            local cell_invalid_xy = board:getCell(out_of_range_x, out_of_range_y)

            -- Then
            assert.is_falsy(cell_invalid_x)
            assert.is_falsy(cell_invalid_y)
            assert.is_falsy(cell_invalid_xy)
        end)
        it("If x or y is unspecified, no cell should be returned", function()
            -- Given
            local x = 1
            local y = 1

            -- When
            local cell_unspecified_x = board:getCell(nil, y)
            local cell_unspecified_y = board:getCell(x, nil)
            local cell_unspecified_xy = board:getCell(nil, nil)

            -- Then
            assert.is_falsy(cell_unspecified_x)
            assert.is_falsy(cell_unspecified_y)
            assert.is_falsy(cell_unspecified_xy)
        end)
        it("Cell at the correct position should be returned", function()
            -- Given
            local x = 1
            local y = 2

            -- When
            local cell = board:getCell(x, y)

            -- Then
            assert.are.equal(cell, board[y][x])
        end)
    end)
    describe("mouseToCell", function()
        it("If click is outside board area, no cell is returned", function()
            -- Given
            local click_x = board.width / 2
            local click_y = board.start_of_board / 2

            -- When
            local cell = board:mouseToCell(click_x, click_y)

            -- Then
            assert.is_falsy(cell)
        end)
        it("If click is inside board area, the corresponding cell is returned", function()
            -- Given
            local cell = board:getRandomCell()
            local click_x = cell.x + cell.size * 0.5
            local click_y = cell.y + cell.size * 0.5

            -- When
            local clicked_cell = board:mouseToCell(click_x, click_y)

            -- Then
            assert.are.equal(clicked_cell, cell)
        end)
    end)
    describe("mouseToBoard", function()
        it("If click is outside board area, no coordinates are returned", function()
            -- Given
            local click_x = board.width / 2
            local click_y = board.start_of_board / 2

            -- When
            local board_x, board_y = board:mouseToBoard(click_x, click_y)

            -- Then
            assert.is_falsy(board_x)
            assert.is_falsy(board_y)
        end)
        it("If click is inside board area, the corresponding coordinates are returned", function()
            -- Given
            local cell = board:getRandomCell()
            local click_x = cell.x + cell.size * 0.5
            local click_y = cell.y + cell.size * 0.5

            -- When
            local board_x, board_y = board:mouseToBoard(click_x, click_y)

            -- Then
            assert.are.equal(board_x, cell.x / cell.size)
            assert.are.equal(board_y, (cell.y - board.start_of_board) / cell.size)
        end)
    end)
    describe("clear", function()
        it("After clearing the board, all cells are checked", function()
            -- When
            board:clear()

            -- Then
            for cell in board:cells() do
                assert.is_true(cell.checked)
            end
        end)
    end)
    describe("isCleared", function()
        it("If all cells are either checked or mines, the board is cleared", function()
            -- When
            board:clear()

            -- Then
            assert.is_true(board:isCleared())
        end)
        it("If an unchecked non-mine cell exists, the board is not cleared", function()
            -- When
            board:clear()
            board:getRandomCell().checked = false

            -- Then
            assert.is_false(board:isCleared())
        end)
    end)

end)
