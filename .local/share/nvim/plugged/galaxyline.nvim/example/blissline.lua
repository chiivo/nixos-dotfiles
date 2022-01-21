local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer'}

gls.left[1] = {
	RainbowRed = {
		provider = function() return ' ' end,
		highlight = {colors.blue,colors.bg}
	},
}

gls.left[2] = {
  	ViMode = {
    		provider = function()
      			-- auto change color according the vim mode
      			local mode_color = {n=colors.fg, i=colors.green, v=colors.magenta,
                          	['']=colors.blue, V=colors.blue,
                          	c=colors.magenta, no=colors.red, s=colors.orange,
                          	S=colors.orange, ['']=colors.orange,
                          	ic=colors.yellow, R=colors.violet, Rv=colors.violet,
                          	cv=colors.red, ce=colors.red, r=colors.cyan,
                          	rm = colors.cyan, ['r?']=colors.cyan,
                          	['!']=colors.red, t=colors.red}
      			vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
      			return ' '
    		end,
    		highlight = {colors.red,colors.bg,'bold'},
		separator_highlight = {nil,colors.bg}
  	},
}

gls.mid[1] ={
  	FileIcon = {
    		provider = 'FileIcon',
    		condition = condition.buffer_not_empty,
    		highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
  	},
}

gls.mid[2] = {
  	FileName = {
		provider = 'FilePath',
    		condition = condition.buffer_not_empty,
    		highlight = {colors.magenta,colors.bg,'bold'}
  	}
}

gls.right[1] = {
  	LineInfo = {
    		provider = 'LineColumn',
    		separator = ' ',
    		separator_highlight = {'NONE',colors.bg},
    		highlight = {colors.fg,colors.bg},
  	},
}

gls.right[3] = {
  	RainbowBlue = {
    		provider = function() return ' ' end,
    		highlight = {colors.blue,colors.bg}
  	},
}

gls.short_line_left[1] = {
  	BufferType = {
    		provider = 'FileTypeName',
    		separator = ' ',
    		separator_highlight = {'NONE',colors.bg},
    		highlight = {colors.blue,colors.bg,'bold'}
  	}
}

gls.short_line_left[2] = {
  	SFileName = {
    		provider =  'SFileName',
    		condition = condition.buffer_not_empty,
    		highlight = {colors.fg,colors.bg,'bold'}
  	}
}

gls.short_line_right[1] = {
  	BufferIcon = {
    		provider= 'BufferIcon',
    		highlight = {colors.fg,colors.bg}
  	}
}
