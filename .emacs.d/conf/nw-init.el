;;Emacs (Terminal) 用設定;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)

;; Command-Key and Option-Key
;(setq ns-command-modifier (quote meta))
;(setq ns-alternate-modifier (quote super))

;;EmacsServer --バイブル P.91
;;Usage
;; emacs --daemon
;; emacsclient FILENAME

;(server-start)
(add-hook 'after-init-hook 'server-start)
(defun iconify-emacs-when-server-is-done ()
  (unless server-clients (iconify-frame)))

;編集が終了したらEmacsをアイコン化する
(add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)

;C-x C-c に割り当てる
(global-set-key (kbd "C-x C-c") 'server-edit)

;M-x exitでEmacsを終了できるようにする
(defalias 'exit 'save-buffers-kill-emacs)

;;タイムスタンプ
(add-hook 'before-save-hook 'time-stamp)
