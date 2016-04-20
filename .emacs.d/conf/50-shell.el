;; ansi-colorでエスケープシーケンスをfontifyする設定
;; http://d.hatena.ne.jp/rubikitch/20081102/1225601754
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; エスケープを綺麗に表示する <http://sakito.jp/emacs/emacsshell.html#id31>
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;; より下に記述した物が PATH の先頭に追加されます
;(dolist (dir (list
;              "/sbin"
;              "/usr/sbin"
;              "/bin"
;              "/usr/bin"
;              "/usr/local/bin"
;              (expand-file-name "~/bin")
;              (expand-file-name "~/.emacs.d/bin")
;              ))
;;; PATH と exec-path に同じ物を追加します
;(when (and (file-exists-p dir) (not (member dir exec-path)))
;    (setenv "PATH" (concat dir ":" (getenv "PATH")))
;    (setq exec-path (append (list dir) exec-path))))

;;; MANPATH
;(setenv "MANPATH" (concat ;"/usr/local/man:/usr/share/man:/Developer/usr/share/man:/sw/share/man" (getenv ;"MANPATH")))

;; Emacs が保持する terminfo を利用する
(setq system-uses-terminfo nil)
