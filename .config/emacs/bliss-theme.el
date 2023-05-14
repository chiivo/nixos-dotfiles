(require 'autothemer)

(autothemer-deftheme
 bliss "A theme loosely based on the bliss keycap colorway by Minterly"

 ((((class color) (min-colors #xFFFFFF)))

  ;; Define color palette
  ;; (dark-black "#141515")
  (dark-black "#191a1a")
  (black "#262727")
  (gray "#555657")
  (white "#dddddd")
  (pink "#f5d1c8")
  (red "#ff8278")
  (orange "#ffc178")
  (yellow "#eadc86")
  (green "#bde077")
  (blue "#77bee0")
  (purple "#dd91f3")
 )

 ;; Customize faces
 (
  (default (:font "monospace" :foreground white :background black :weight 'medium))
  (cursor (:background white))
  (region (:background gray))
  (fringe (:background black))
  (success (:foreground pink :weight 'bold))
  (error (:foreground red :weight 'bold))
  (highlight (:foreground black :background blue :weight 'bold))

  (completions-common-part (:foreground green :weight 'medium))
  (corfu-default (:foreground pink :weight 'medium))
  (corfu-border (:background dark-black))
  (corfu-current (:foreground white :background gray :weight 'medium))
  (corfu-bar (:background gray))
  
  (mode-line (:background black))
  (mode-line-inactive (:background gray))
  
  (isearch (:foreground pink :background gray))
  (isearch-fail (:foreground pink :background gray))
  (isearch-group-1 (:foreground pink :background gray))
  (isearch-group-2 (:foreground pink :background gray))
  (lazy-highlight (:foreground black :background pink))
  (evil-ex-substitute-replacement (:foreground red))
  
  (font-lock-comment-delimiter-face (:inherit font-lock-comment-face))
  (font-lock-comment-face (:foreground gray :slant 'italic))
  (font-lock-keyword-face (:foreground green))
  (font-lock-constant-face (:foreground blue))
  (font-lock-string-face (:foreground orange))
  (font-lock-builtin-face (:foreground purple))
  (font-lock-type-face (:foreground green))

  (widget-button-pressed (:foreground pink :weight 'bold))

  (focus-unfocused (:foreground gray))
  
  (line-number (:foreground gray))
  (line-number-current-line (:foreground pink :weight 'bold))
  
  (org-block (:foreground white :background dark-black))
  (org-block-begin-line (:foreground gray :background dark-black :slant 'italic))
  (org-block-end-line (:foreground gray :background dark-black :slant 'italic))
  (org-level-1 (:foreground purple :font "sans" :weight 'bold :height 160))
  (org-level-2 (:foreground blue :font "sans" :weight 'bold :height 150))
  (org-level-3 (:foreground green :font "sans" :weight 'bold :height 140))
  (org-level-4 (:foreground yellow :font "sans" :weight 'bold :height 130))
  (org-level-5 (:foreground orange :font "sans" :weight 'bold :height 120))
  (org-level-6 (:foreground red :font "sans" :weight 'bold))
  (org-level-7 (:foreground white :font "sans" :weight 'bold))
  (org-level-8 (:foreground pink :font "sans" :weight 'bold))

  (centaur-tabs-default (:foreground gray :background gray))
  (centaur-tabs-active-bar-face (:background pink))
  (centaur-tabs-selected (:foreground white :background black :fontfamily "monospace" :height 140))
  (centaur-tabs-selected-modified (:foreground white :background black :fontfamily "monospace" :height 140))
  (centaur-tabs-unselected (:foreground white :background gray :fontfamily "monospace" :height 140))
  (centaur-tabs-unselected-modified (:foreground white :background gray :fontfamily "monospace" :height 140))

  (rainbow-delimiters-depth-1-face (:foreground red))
  (rainbow-delimiters-depth-2-face (:foreground orange))
  (rainbow-delimiters-depth-3-face (:foreground yellow))
  (rainbow-delimiters-depth-4-face (:foreground green))
  (rainbow-delimiters-depth-5-face (:foreground blue))
  (rainbow-delimiters-depth-6-face (:foreground purple))
  (rainbow-delimiters-depth-7-face (:foreground gray))
  (rainbow-delimiters-depth-8-face (:foreground dark-black))
  (rainbow-delimiters-depth-9-face (:foreground pink))

  (fixed-pitch (:fontfamily "serif"))
 ))

(provide-theme 'bliss)
