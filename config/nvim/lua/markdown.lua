vim.api.nvim_create_augroup("markdown", { clear = true })
vim.api.nvim_create_autocmd({"BufRead","BufNewFile","BufEnter"}, {
  desc = "Set formatting options in Markdown files",
  group = "markdown",
  pattern = "*.md",
  -- format options:
  --   a - automatic formatting of paragraphs
  --   c - auto-wrap comments
  --   q - allow formatting comments with 'gq'
  --   t - auto-wrap text
  --   w - trailing whitespace indicates paragraph continues on next line
  -- command = "silent! setlocal spell formatoptions=acqt textwidth=80 colorcolumn=+1 wrap",
  command = "silent! setlocal spell formatoptions=cqt textwidth=80 colorcolumn=+1 wrap joinspaces",
})

vim.api.nvim_create_autocmd({"BufRead","BufNewFile","BufEnter"}, {
  desc = "Configure emoji abbreviations",
  group = "markdown",
  pattern = { "*.md", ".txt"},
  callback = function(event)
    vim.cmd('iabbrev :shrug: ¯\\_(ツ)_/¯')
    vim.cmd('iabbrev &shrug; ¯\\_(ツ)_/¯')

    vim.cmd("iabbrev :smile: 😄")
    vim.cmd("iabbrev :smile: 😄")
    vim.cmd("iabbrev :smiley: 😃")
    vim.cmd("iabbrev :slight_smile: 🙂")
    vim.cmd("iabbrev :grin: 😁")
    vim.cmd("iabbrev :grinning: 😀")
    vim.cmd("iabbrev :wink: 😉")
    vim.cmd("iabbrev :laughing: 😆")
    vim.cmd("iabbrev :rofl: 🤣")
    vim.cmd("iabbrev :cry: 😢")

    vim.cmd("iabbrev :thumbsup: 👍")
    vim.cmd("iabbrev :thumbsdown: 👎")
    vim.cmd("iabbrev :wave: 👋")

    vim.cmd("iabbrev :neutral_face: 😐")
    vim.cmd("iabbrev :neutral: 😐")
    vim.cmd("iabbrev :frowning_face: ☹️ ")
    vim.cmd("iabbrev :frown: ☹️ ")
    vim.cmd("iabbrev :slightly_frowning_face: 🙁")
    vim.cmd("iabbrev :tired_face: 😫")
    vim.cmd("iabbrev :tired: 😫")
    vim.cmd("iabbrev :raised_eyebrow: 🤨")
    vim.cmd("iabbrev :roll_eyes: 🙄")
    vim.cmd("iabbrev :eye_roll: 🙄")
    vim.cmd("iabbrev :open_mouth: 😮")
    vim.cmd("iabbrev :thinking: 🤔")
    vim.cmd("iabbrev :upside_down_face: 🙃")

    vim.cmd("iabbrev :stuck_out_tongue: 😛")
    vim.cmd("iabbrev :stuck_out_tongue_closed_eyes: 😝")
    vim.cmd("iabbrev :stuck_out_tongue_winking_eye: 😜")
    vim.cmd("iabbrev :blush: 😊")
    vim.cmd("iabbrev :zany_face: 🤪")
    vim.cmd("iabbrev :drooling_face: 🤤")
    vim.cmd("iabbrev :nerd_face: 🤓")
    vim.cmd("iabbrev :pleading_face: 🥺")
    vim.cmd("iabbrev :partying_face: 🥳")
    vim.cmd("iabbrev :zipper_mouth_face: 🤐")
    vim.cmd("iabbrev :angry: 😠")
    vim.cmd("iabbrev :rage: 😡")
    vim.cmd("iabbrev :cursing_face: 🤬")

    vim.cmd("iabbrev :coffee: ☕")
    vim.cmd("iabbrev :sun: ☀️")
    vim.cmd("iabbrev :sunshine: ☀️")
    vim.cmd("iabbrev :umbrella: ☔")
    vim.cmd("iabbrev :rain: 🌧️")


    vim.cmd("iabbrev :linux: 🐧")
    vim.cmd("iabbrev :penguin: 🐧")
    vim.cmd("iabbrev :rust: 🦀")

    vim.cmd("iabbrev :facepalm: 🤦")
    vim.cmd("iabbrev :hugging: 🤗")
    vim.cmd("iabbrev :heart: ❤️ ")
    vim.cmd("iabbrev :kissing_heart: 😘")
    vim.cmd("iabbrev :heart_eyes: 😍")
    vim.cmd("iabbrev :clown_face: 🤡")
  end
})

