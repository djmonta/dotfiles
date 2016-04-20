;; whitespace-mode like jaspace
;; http://piyolian.blogspot.jp/2011/12/emacs-whitespace-like-jaspace.html

(when (and (>= emacs-major-version 23)
	   (require 'whitespace nil t))
  (setq whitespace-style
	'(face
	  tabs spaces newline trailing space-before-tab space-after-tab
	  space-mark tab-mark newline-mark))
  (let ((dark (eq 'dark (frame-parameter nil 'background-mode))))
    (set-face-attribute 'whitespace-space nil
			:foreground (if dark "pink4" "azure3")
			:background 'unspecified)
    (set-face-attribute 'whitespace-tab nil
			:foreground (if dark "gray20" "gray80")
			:background 'unspecified
			:strike-through t)
    (set-face-attribute 'whitespace-newline nil
			:foreground (if dark "darkcyan" "darkseagreen")))
  (setq whitespace-space-regexp "\\(　+\\)")
  (setq whitespace-display-mappings
	'((space-mark   ?\xA0  [?\xA4]  [?_]) ; hard space - currency
	  (space-mark   ?\x8A0 [?\x8A4] [?_]) ; hard space - currency
	  (space-mark   ?\x920 [?\x924] [?_]) ; hard space - currency
	  (space-mark   ?\xE20 [?\xE24] [?_]) ; hard space - currency
	  (space-mark   ?\xF20 [?\xF24] [?_]) ; hard space - currency
	  (space-mark   ?　    [?□]    [?＿]) ; full-width space - square
	  (newline-mark ?\n    [?\xAB ?\n])   ; eol - right quote mark
	  ))
  (setq whitespace-global-modes '(not dired-mode tar-mode))
  (global-whitespace-mode 1))
