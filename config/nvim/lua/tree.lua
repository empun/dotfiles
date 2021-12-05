return {
  toggle = function(find)
    require('nvim-tree').toggle(find)

    if require('nvim-tree.view').win_open() then
      require('bufferline.state').set_offset(28, '🌱  FileTree')
      require('nvim-tree').find_file(find)
    else
      require('bufferline.state').set_offset(0)
    end
  end,
}
