(require 'autothemer)

(autothemer-deftheme
 bliss "A theme loosely based on the bliss keycap colorway by Minterly"

 ((((class color) (min-colors #xFFFFFF)))

  ;; Define color palette
  (dark-black "#161515")
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
  (default (:fontfamily "monospace" :foreground white :background black :weight 'semi-bold))
  (cursor (:background white))
  (region (:background gray))
  (fringe (:background black))
  (success (:foreground pink :weight 'bold))
  
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

  (focus-unfocused (:foreground gray))
  
  (line-number (:foreground gray))
  (line-number-current-line (:foreground pink :weight 'bold))
  
  (org-block (:foreground white))
  (org-level-1 (:foreground purple :fontfamily "sans-serif" :weight 'bold :height 160))
  (org-level-2 (:foreground blue :fontfamily "sans-serif" :weight 'bold :height 150))
  (org-level-3 (:foreground green :fontfamily "sans-serif" :weight 'bold :height 140))
  (org-level-6 (:foreground yellow :fontfamily "sans-serif" :weight 'bold :height 130))
  (org-level-5 (:foreground orange :fontfamily "sans-serif" :weight 'bold :height 120))
  (org-level-6 (:foreground red :fontfamily "sans-serif" :weight 'bold))
  (org-level-7 (:foreground white :fontfamily "sans-serif" :weight 'bold))
  (org-level-8 (:foreground pink :fontfamily "sans-serif" :weight 'bold))

  (fixed-pitch-serif (:fontfamily "serif"))
 ))

(provide-theme 'bliss)
