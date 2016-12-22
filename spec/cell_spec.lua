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
end)
