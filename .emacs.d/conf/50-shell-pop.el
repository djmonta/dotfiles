; shell-pop の設定
; http://d.hatena.ne.jp/kyagi/20090601/1243841415
(require 'shell-pop)
(global-set-key [f8] 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-window-height 40)

(provide 'init-shell-pop)