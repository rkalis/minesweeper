-- local Highscores = require "src.highscores"
-- require "love.filesystem"
--
-- describe("Highscores Tests", function()
--     local highscores
--     local EASY_FN = "test_hs_easy.txt"
--     local MEDIUM_FN = "test_hs_medium.txt"
--     local HARD_FN = "test_hs_hard.txt"
--
--     before_each(function()
--         highscores = Highscores:new(EASY_FN, MEDIUM_FN, HARD_FN)
--     end)
-- 
--     describe("new", function()
--         pending("If files don't exist, they are created")
--         pending("File objects are created for each difficulty")
--         pending("Tables are created for each difficulty")
--     end)
--
--     describe("load", function()
--         it("If no file exists, no scores should be read", function()
--             -- Given
--             love.filesystem.remove(highscores.files.easy:getFilename())
--
--             -- When
--             highscores:load("easy")
--
--             -- Then
--             assert.are.equal(highscores.highscores.easy, {})
--         end)
--         it("If file contains a corrupt line, it should be ignored", function()
--
--         end)
--         pending("If there are less than ten lines, they should all be read")
--         pending("If there are ten lines, they should all be read")
--         pending("If There ar emore than ten lines, only the first ten should be read")
--     end)
-- end)