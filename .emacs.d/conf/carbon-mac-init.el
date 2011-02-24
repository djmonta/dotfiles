;;Carbon Emacs用設定;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;全てのバックアップファイルを/tmp以下に保存する。
(defun make-backup-file-name (filename)
  (expand-file-name
    (concat "/tmp/" (file-name-nondirectory filename) "~")
    (file-name-directory filename)))

(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)

;; Command-Key and Option-Key
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;;タイムスタンプ
(add-hook 'before-save-hook 'time-stamp)

(provide 'carbon-mac-init)