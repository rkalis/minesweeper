local Cell = require "src.cell"
describe("Cell Tests", function()
    local cell
    local other
    local CELL_SIZE = 40
    local CELL_X = 50
    local CELL_Y = 100

    before_each(function()
        cell = Cell:new(CELL_X, CELL_Y, CELL_SIZE)
        other = Cell:new(2 * CELL_X, 2 * CELL_Y, CELL_SIZE)
    end)

    describe("checkNeighbours", function()
        before_each(function()
            for i = 1, 10 do
                cell.neighbours[i] = Cell:new(CELL_X, i * CELL_Y, CELL_SIZE)
            end
        end)
        it("If clear_flags, then flags should be cleared", function()
            -- Given
            for _, neighbour in ipairs(cell.neighbours) do
                neighbour.flagged = true
            end

            -- When
            cell:checkNeighbours(true)

            -- Then
            for _, neighbour in ipairs(cell.neighbours) do
                assert.is_false(neighbour.flagged)
            end
        end)
        it("If not clear_flags, then no flags should be cleared", function()
            -- Given
            for _, neighbour in ipairs(cell.neighbours) do
                neighbour.flagged = true
            end

            -- When
            cell:checkNeighbours(false)

            -- Then
            for _, neighbour in ipairs(cell.neighbours) do
                assert.is_true(neighbour.flagged)
            end
        end)
        it("Number of cleared flags should be returned", function()
            -- Given
            for _, neighbour in ipairs(cell.neighbours) do
                neighbour.flagged = true
            end

            -- When
            local cleared_flags = cell:checkNeighbours(true)

            -- Then
            assert.is.equal(cleared_flags, #cell.neighbours)
        end)
        it("If cell is a mine, then no neighbours should be checked", function()
            -- Given
            cell.mine = true

            -- When
            cell:checkNeighbours(true)

            -- Then
            for _, neighbour in ipairs(cell.neighbours) do
                assert.is_false(neighbour.checked)
            end
        end)
        it("If cell is already checked, then no neighbours should be checked", function()
            -- Given
            cell.checked = true

            -- When
            cell:checkNeighbours(true)

            -- Then
            for _, neighbour in ipairs(cell.neighbours) do
                assert.is_false(neighbour.checked)
            end
        end)
        it("If cell has neighbouring mines, then no neighbours should be checked", function()
            -- Given
            cell.neighbours[1].mine = true

            -- When
            cell:checkNeighbours(true)

            -- Then
            for _, neighbour in ipairs(cell.neighbours) do
                assert.is_false(neighbour.checked)
            end
        end)
        it("If cell has no neighbouring mines, then all neighbouring mines should be checked", function()
            -- Given
            for _, neighbour in ipairs(cell.neighbours) do
                neighbour.mine = false
            end

            -- When
            cell:checkNeighbours(true)

            -- Then
            for _, neighbour in ipairs(cell.neighbours) do
                assert.is_true(neighbour.checked)
            end
        end)
    end)

    describe("toggleFlag", function()
        it("If cell is checked nothing should change", function()
            -- Given
            cell.flagged = false
            other.flagged = true
            cell.checked = true
            other.checked = true

            -- When
            cell:toggleFlag()
            other:toggleFlag()

            -- Then
            assert.is_false(cell.flagged)
            assert.is_true(other.flagged)

        end)
        it("Cell flag status should be toggled", function()
            -- Given
            cell.flagged = true
            other.flagged = false

            -- When
            cell:toggleFlag()
            other:toggleFlag()

            -- Then
            assert.is_false(cell.flagged)
            assert.is_true(other.flagged)
        end)
        it("The change in flag amount should be returned", function()
            -- Given
            cell.flagged = false
            other.flagged = true
            local checked_cell = Cell:new(CELL_X, CELL_Y, CELL_SIZE)
            checked_cell.checked = true

            -- When
            local onemore = cell:toggleFlag()
            local oneless = other:toggleFlag()
            local same = checked_cell:toggleFlag()

            -- Then
            assert.is.equal(onemore, 1)
            assert.is.equal(oneless, -1)
            assert.is.equal(same, 0)
        end)
    end)

    describe("click", function()
        it("If cell is flagged, it won't be clicked", function()
            -- Given
            cell.flagged = true

            -- When
            local click = cell:click()

            -- Then
            assert.is_falsy(click)
            assert.is_false(cell.clicked)
        end)
        it("If cell is not flagged, it will be clicked", function()
            -- Given
            cell.flagged = false

            -- When
            local click = cell:click()

            -- Then
            assert.is_truthy(click)
            assert.is_true(cell.clicked)
        end)
        it("If cell is clicked, neighbours will be checked", function()
            -- Given
            cell.flagged = false
            local s = spy.on(cell, "checkNeighbours")

            -- When
            local click = cell:click()
            assert.is_true(cell.clicked)

            -- Then
            assert.spy(s).was_called()
        end)
    end)

    describe("equals", function()
        it("If cell has the same position, they are equal", function()
            -- When
            local equality = cell:equals(cell)

            -- Then
            assert.is_true(equality)
        end)
        it("If cell has different position, they are not equal", function()
            -- When
            local equality = cell:equals(other)

            -- Then
            assert.is_false(equality)
        end)
    end)

    describe("isNeighbour", function()
        it("If other is in cell's neighbour list, they are neighbours", function()
            -- Given
            cell.neighbours[1] = other

            -- When
            local neighbouring = cell:isNeighbour(other)

            -- Then
            assert.is_true(neighbouring)
        end)

        it("If cell is in other's neighbour list, they are neighbours", function()
            -- Given
            other.neighbours[1] = cell

            -- When
            local neighbouring = cell:isNeighbour(other)

            -- Then
            assert.is_true(neighbouring)
        end)

        it("If neither is in eachothers neighbours list, they are not neighbours", function()
            -- Given
            cell.neighbours = {}
            other.neighbours = {}

            -- When
            local neighbouring = cell:isNeighbour(other) or other:isNeighbour(cell)

            -- Then
            assert.is_false(neighbouring)
        end)
    end)

end)
