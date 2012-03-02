;;Emacs (Terminal) 用設定;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;全てのバックアップファイルを/tmp以下に保存する。
(defun make-backup-file-name (filename)
  (expand-file-name
    (concat "/tmp/" (file-name-nondirectory filename) "~")
    (file-name-directory filename)))

(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)

;; Command-Key and Option-Key
;(setq ns-command-modifier (quote meta))
;(setq ns-alternate-modifier (quote super))

;;タイムスタンプ
(add-hook 'before-save-hook 'time-stamp)

;;EmacsServer --バイブル P.91
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

(provide 'mac-terminal-init)