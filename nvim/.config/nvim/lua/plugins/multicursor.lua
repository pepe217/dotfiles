return {
  'jake-stewart/multicursor.nvim',
  config = function()
    local mc = require 'multicursor-nvim'

    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ 'n', 'v' }, '<up>', function()
      mc.lineAddCursor(-1)
    end)
    set({ 'n', 'v' }, '<down>', function()
      mc.lineAddCursor(1)
    end)
    set({ 'n', 'v' }, '<leader><up>', function()
      mc.lineSkipCursor(-1)
    end)
    set({ 'n', 'v' }, '<leader><down>', function()
      mc.lineSkipCursor(1)
    end)

    -- Add or skip adding a new cursor by matching word/selection
    set({ 'n', 'v' }, '<leader>cn', function()
      mc.matchAddCursor(1)
    end)
    set({ 'n', 'v' }, '<leader>cs', function()
      mc.matchSkipCursor(1)
    end)
    set({ 'n', 'v' }, '<leader>cN', function()
      mc.matchAddCursor(-1)
    end)
    set({ 'n', 'v' }, '<leader>cS', function()
      mc.matchSkipCursor(-1)
    end)

    -- Add all matches in the document
    set({ 'n', 'v' }, '<leader>ca', mc.matchAllAddCursors)

    -- Rotate the main cursor.
    set({ 'n', 'v' }, '<left>', mc.nextCursor)
    set({ 'n', 'v' }, '<right>', mc.prevCursor)

    -- Delete the main cursor.
    set({ 'n', 'v' }, '<leader>cx', mc.deleteCursor)

    -- Easy way to add and remove cursors using the main cursor.
    set({ 'n', 'v' }, '<leader>cq', mc.toggleCursor)

    -- Clone every cursor and disable the originals.
    set({ 'n', 'v' }, '<leader>cd', mc.duplicateCursors)

    set('n', '<esc>', function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        vim.cmd 'nohlsearch'
      end
    end)

    -- bring back cursors if you accidentally clear them
    set('n', '<leader>cv', mc.restoreCursors)

    -- Align cursor columns.
    set('n', '<leader>cl', mc.alignCursors)

    -- Split visual selections by regex.
    set('v', 'S', mc.splitCursors)

    -- Append/insert for each line of visual selections.
    set('v', 'I', mc.insertVisual)
    set('v', 'A', mc.appendVisual)

    -- match new cursors within visual selections by regex.
    set('v', 'M', mc.matchCursors)

    -- Rotate visual selection contents.
    set('v', '<leader>t', function()
      mc.transposeCursors(1)
    end)
    set('v', '<leader>T', function()
      mc.transposeCursors(-1)
    end)

    -- Jumplist support
    set({ 'v', 'n' }, '<c-i>', mc.jumpForward)
    set({ 'v', 'n' }, '<c-o>', mc.jumpBackward)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, 'MultiCursorCursor', { link = 'Cursor' })
    hl(0, 'MultiCursorVisual', { link = 'Visual' })
    hl(0, 'MultiCursorSign', { link = 'SignColumn' })
    hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
  end,
}
